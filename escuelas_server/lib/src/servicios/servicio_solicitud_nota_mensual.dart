import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_solicitud.dart';
import 'package:escuelas_server/src/orms/orm_solicitud_nota_mensual.dart';
import 'package:escuelas_server/src/orms/orm_usuario.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:escuelas_server/src/servicios/servicio_comunicaciones.dart';
import 'package:serverpod/server.dart';

import 'package:escuelas_server/utils/templates.dart';
import 'package:serverpod/serverpod.dart';

class ServicioSolicitudNotaMensual extends Servicio<OrmSolicitudNotaMensual> {
  @override
  OrmSolicitudNotaMensual get orm => OrmSolicitudNotaMensual();
  OrmUsuario get ormUsuario => OrmUsuario();
  OrmSolicitud get ormSolicitud => OrmSolicitud();
  ServicioComunicaciones get servicioComunicacion => ServicioComunicaciones();

  /// La función `crearSolicitudNotaMensual` crea un registro de solicitud en una base de datos y devuelve el
  /// registro creado.
  Future<SolicitudCalificacionMensual> crearSolicitudNotaMensual(
    Session session, {
    required SolicitudCalificacionMensual solicitudNotaMensual,
  }) async {
    final solicitudNotaMensualADb = await ejecutarOperacion(
      () => orm.crearSolicitudNotaMensual(
        session,
        solicitudNotaMensual: solicitudNotaMensual,
      ),
    );
    return solicitudNotaMensualADb;
  }

  Future<List<SolicitudCalificacionMensual>> crearSolicitudesMensualesEnLote(
    Session session, {
    required List<SolicitudCalificacionMensual> solicitudesMensuales,
  }) async {
    final solicitudesMensualesAdb = await ejecutarOperacion(
      () => orm.crearSolicitudesMensualesEnLote(
        session,
        solicitudNotaMensual: solicitudesMensuales,
      ),
    );
    return solicitudesMensualesAdb;
  }

  /// La función `actualizarSolicitudNotaMensual` actualiza un registro de solicitud en una base de datos y
  /// devuelve el registro actualizado.
  Future<SolicitudCalificacionMensual> actualizarSolicitudNotaMensual(
    Session session, {
    required SolicitudCalificacionMensual solicitudNotaMensual,
  }) async {
    final solicitudNotaMensualADb = await ejecutarOperacion(
      () => orm.actualizarSolicitudNotaMensual(
        session,
        solicitudNotaMensual: solicitudNotaMensual,
      ),
    );
    return solicitudNotaMensualADb;
  }

  /// La función `obtenerSolicitudNotaMensual` obtiene un registro de solicitud en una base de datos y
  /// devuelve el registro.
  Future<SolicitudCalificacionMensual> obtenerSolicitudNotaMensual(
    Session session, {
    required int id,
  }) async {
    final solicitudNotaMensual = await ejecutarOperacion(
      () => orm.obtenerSolicitudNotaMensual(
        session,
        id: id,
      ),
    );
    return solicitudNotaMensual;
  }

  /// La función `obtenerSolicitudesNotaMensual` recupera una lista de solicitudes utilizando un objeto de sesión.
  Future<List<SolicitudCalificacionMensual>> obtenerSolicitudesNotaMensual(
    Session session,
  ) async {
    final solicitudesNotaMensual = await ejecutarOperacion(
      () => orm.obtenerSolicitudesNotaMensual(session),
    );
    return solicitudesNotaMensual;
  }

  /// La función `eliminarSolicitudNotaMensual` elimina un registro de solicitud en una base de datos y
  /// devuelve el registro eliminado.
  Future<int> eliminarSolicitudNotaMensual(
    Session session, {
    required int id,
  }) async {
    final idSolicitudNotaMensual = await ejecutarOperacion(
      () => orm.eliminarSolicitudNotaMensual(
        session,
        id: id,
      ),
    );
    return idSolicitudNotaMensual;
  }

  /// La función `enviarSolicitudADocentes` envía una solicitud de calificaciones mensuales a los
  /// profesores para cada usuario con materias asignadas.
  Future<void> enviarSolicitudADocentes(
    Session session,
  ) async {
    final ahora = DateTime.now();
    final listaIdDocentes = await ormUsuario.obtenerIdsDeUsuariosDocentes(
      session,
    );

    final idAutor = await obtenerIdDeUsuarioLogueado(session);
    final usuarios = await ormUsuario.obtenerUsuariosEnLote(
      session,
      ids: listaIdDocentes,
    );

    for (final usuario in usuarios) {
      List<SolicitudCalificacionMensual> solicitudesMensualesAdb = [];

      for (final asignatura
          in usuario.asignaturas ?? <RelacionAsignaturaUsuario>[]) {
        final solicitud = Solicitud(
          tipoSolicitud: TipoSolicitud.calificacion,
          idAutor: idAutor,
          idDestinatario: usuario.id!,
          fechaCreacion: ahora,
        );

        final solicitudCreada = await ormSolicitud.crearSolicitud(
          session,
          solicitud: solicitud,
        );

        final chequearSolicitudMensual =
            await orm.obtenerSolicitudesPorAsignaturaComisionyMes(
          session,
          idAsignatura: asignatura.asignaturaId,
          idComision: asignatura.comisionId,
          numeroDeMes: ahora.month,
        );

        if (chequearSolicitudMensual.isNotEmpty) {
          logger.warning("ya existe una solicitud para este mes");
          continue;
        }

        final solicitudNotaMensual = SolicitudCalificacionMensual(
          idAsignatura: asignatura.asignaturaId,
          comisionId: asignatura.comisionId,
          numeroDeMes: ahora.month,
          solicitudId: solicitudCreada.id!,
        );

        solicitudesMensualesAdb.add(solicitudNotaMensual);

        final contenidoHtml = Plantillas.pedidoDeNotas(
          nombre: usuario.nombre,
          apellido: usuario.apellido,
          nombreMateria: asignatura.asignatura!.nombre,
          nombreDeLaComision: asignatura.comision!.nombre,
        );

        if (usuario.direccionesDeEmail!.isEmpty) {
          logger.warning("el usuario no tiene email");
          continue;
        }

        if (usuario.direccionesDeEmail!.length > 1) {
          for (final direccionEmail in usuario.direccionesDeEmail!) {
            await servicioComunicacion.enviarEmail(
              session,
              direccionEmailDestinatario:
                  direccionEmail.direccionDeEmail.trim(),
              asuntoDelCorreo: "tienes un pedido de calificacion",
              contenidoHtmlDelCorreo: contenidoHtml,
            );
          }
        } else {
          await servicioComunicacion.enviarEmail(
            session,
            direccionEmailDestinatario:
                usuario.direccionesDeEmail!.first.direccionDeEmail.trim(),
            asuntoDelCorreo: "tienes un pedido de calificacion",
            contenidoHtmlDelCorreo: contenidoHtml,
          );
        }
      }

      await crearSolicitudesMensualesEnLote(
        session,
        solicitudesMensuales: solicitudesMensualesAdb,
      );
    }
  }

  Future<List<SolicitudesComisionMensual>> obtenerSolicitudesPorComisionMensual(
    Session session, {
    required int numeroDeMes,
    required int numeroDeAnio,
  }) async {
    final solicitudesMensuales = await obtenerSolicitudesNotaMensual(session);

    final comisiones = solicitudesMensuales
        .map((e) => e.comision != null ? e.comision! : throw Exception())
        .toSet()
        .toList();

    final solicitudesComisionMensual = comisiones.map((comision) {
      final solicitudes = solicitudesMensuales
          .where((solicitud) => solicitud.comisionId == comision.id)
          .toList();

      return SolicitudesComisionMensual(
        comision: comision,
        solicitudes: solicitudes,
      );
    }).toList();

    return solicitudesComisionMensual;
  }
}
