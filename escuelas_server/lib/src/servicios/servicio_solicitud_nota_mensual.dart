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
  Future<SolicitudNotaMensual> crearSolicitudNotaMensual(
    Session session, {
    required SolicitudNotaMensual solicitudNotaMensual,
  }) async {
    final solicitudNotaMensualADb = await ejecutarOperacion(
      () => orm.crearSolicitudNotaMensual(
        session,
        solicitudNotaMensual: solicitudNotaMensual,
      ),
    );
    return solicitudNotaMensualADb;
  }

  Future<List<SolicitudNotaMensual>> crearSolicitudesMensualesEnLote(
    Session session, {
    required List<SolicitudNotaMensual> solicitudesMensuales,
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
  /// Args:
  /// Session:
  /// solicitudNotaMensual (SolicitudNotaMensual): Un objeto de tipo SolicitudNotaMensual, que representa un registro de solicitud.
  /// Returns:
  /// Un `Future<SolicitudNotaMensual>`.
  Future<SolicitudNotaMensual> actualizarSolicitudNotaMensual(
    Session session, {
    required SolicitudNotaMensual solicitudNotaMensual,
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
  /// Args:
  /// Session:
  /// id (int): El id del registro de solicitud.
  /// Returns:
  /// Un `Future<SolicitudNotaMensual>`.
  Future<SolicitudNotaMensual> obtenerSolicitudNotaMensual(
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
  /// Args:
  /// Session:
  /// Returns:
  /// un `Future<List<SolicitudNotaMensual>>`.
  Future<List<SolicitudNotaMensual>> obtenerSolicitudesNotaMensual(
    Session session,
  ) async {
    final solicitudesNotaMensual = await ejecutarOperacion(
      () => orm.obtenerSolicitudesNotaMensual(session),
    );
    return solicitudesNotaMensual;
  }

  /// La función `eliminarSolicitudNotaMensual` elimina un registro de solicitud en una base de datos y
  /// devuelve el registro eliminado.
  /// Args:
  /// Session:
  /// id (int): El id del registro de solicitud.
  /// Returns:
  /// Un `Future<int>`.
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
  ///
  /// Args:
  ///   session (Session): El parámetro de sesión es un objeto que representa la sesión o conexión
  /// actual a la base de datos. Se utiliza para realizar operaciones de bases de datos, como consultar
  /// y guardar datos.
  Future enviarSolicitudADocentes(Session session) async {
    final ahora = DateTime.now();
    final listaUsuarios = await ormUsuario.obtenerUsuariosConAsignaturas(
      session,
    );

    final idDirectivo = await session.auth.authenticatedUserId;
    final usuarios = await ormUsuario.obtenerUsuariosEnLote(
      session,
      ids: listaUsuarios,
    );

    for (final usuario in usuarios) {
      List<SolicitudNotaMensual> solicitudesMensualesAdb = [];
      for (final asignatura in usuario.asignaturas!) {
        final solicitud = Solicitud(
          tipoSolicitud: TipoSolicitud.calificacion,
          idAutor: idDirectivo!,
          idDestinatario: usuario.id!,
          fechaCreacion: ahora,
        );
        final solicitudCreada = await ormSolicitud.crearSolicitud(
          session,
          solicitud: solicitud,
        );
        final solicitudNotaMensual = SolicitudNotaMensual(
          idSolicitud: solicitudCreada.id!,
          idAsignatura: asignatura.asignaturaId,
          idComision: asignatura.comisionId,
          numeroDeMes: DateTime.now().month,
          solicitudId: solicitudCreada.id!,
        );
        solicitudesMensualesAdb.add(solicitudNotaMensual);

        final contenidoHtml = Plantillas().pedidoDeNotas(
            nombre: usuario.nombre,
            apellido: usuario.apellido,
            nombreMateria: asignatura.asignatura!.nombre,
            nombreDeLaComision: asignatura.comision!.nombre);

        await servicioComunicacion.enviarEmail(
          session,
          direccionEmailDestinatario:
              usuario.direccionesDeEmail!.first.direccionDeEmail.trim(),
          asuntoDelCorreo: "tienes un pedido de calificacion",
          contenidoHtmlDelCorreo: contenidoHtml,
        );
      }
      await crearSolicitudesMensualesEnLote(
        session,
        solicitudesMensuales: solicitudesMensualesAdb,
      );
    }
  }
}
