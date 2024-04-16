import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_relacion_asignatura_usuario.dart';
import 'package:escuelas_server/src/orms/orm_solicitud.dart';
import 'package:escuelas_server/src/orms/orm_solicitud_calificacion_mensual.dart';
import 'package:escuelas_server/src/orms/orm_userInfo.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:escuelas_server/src/servicios/servicio_comunicaciones.dart';
import 'package:escuelas_server/src/servicios/servicio_one_signal.dart';
import 'package:escuelas_server/src/servicios/servicio_usuario.dart';
import 'package:escuelas_server/utils/constants.dart';
import 'package:serverpod/server.dart';

import 'package:escuelas_server/utils/templates.dart';
import 'package:serverpod/serverpod.dart';

class ServicioSolicitudNotaMensual extends Servicio<OrmSolicitud> {
  @override
  OrmSolicitud get orm => OrmSolicitud();

  final _servicioComunicaciones = ServicioComunicaciones();
  final _servicioUsuario = ServicioUsuario();

  final _ormRelacionAsignaturaUsuario = OrmRelacionAsignaturaUsuario();
  final _ormSolicitudDeCalificacionMensual = OrmSolicitudCalificacionMensual();

  final _servicioOneSignal = ServicioOneSignal();

  /// La función `crearSolicitudNotaMensual` crea un registro de solicitud en una base de datos y devuelve el
  /// registro creado.
  Future<SolicitudCalificacionMensual> crearSolicitudNotaMensual(
    Session session, {
    required SolicitudCalificacionMensual solicitudNotaMensual,
  }) async {
    final solicitudNotaMensualADb = await ejecutarOperacion(
      () => _ormSolicitudDeCalificacionMensual.crearSolicitudNotaMensual(
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
      () => _ormSolicitudDeCalificacionMensual.crearSolicitudesMensualesEnLote(
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
      () => _ormSolicitudDeCalificacionMensual.actualizarSolicitudNotaMensual(
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
      () => _ormSolicitudDeCalificacionMensual.obtenerSolicitudNotaMensual(
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
      () => _ormSolicitudDeCalificacionMensual
          .obtenerSolicitudesNotaMensual(session),
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
      () => _ormSolicitudDeCalificacionMensual.eliminarSolicitudNotaMensual(
        session,
        id: id,
      ),
    );
    return idSolicitudNotaMensual;
  }

  /// La función `enviarSolicitudADocentes` envía una solicitud de calificaciones mensuales a los
  /// profesores para cada usuario con materias asignadas.
  Future<void> enviarSolicitudDeCalificacionMensualADocentes(
    Session session,
  ) async {
    final ahora = DateTime.now();
    logger.finer(
        'Obteniendo información del autor de las solicitudes. ID de cuenta: ${await obtenerIdDeUsuarioLogueado(session)}...');
    final usuarioAutorDeLasSolicitudes = await ejecutarOperacion(
      () => _servicioUsuario.obtenerInfoBasicaUsuario(session),
    );
    if (usuarioAutorDeLasSolicitudes.id == null) {
      throw ExcepcionCustom(tipoDeError: TipoExcepcion.desconocido);
    }
    logger.finer(
        'Obtenida información de perfil del autor de las solicitudes. ID de perfil de usuario: ${usuarioAutorDeLasSolicitudes.id}.');

    final esPasadoElDiaVeinteDelMes = ahora.day > 20;
    final numeroDeMesDeLaSolicitud =
        esPasadoElDiaVeinteDelMes ? ahora.month : ahora.month - 1;
    final anioDeLaSolicitud = ahora.year;

    logger
        .finer('Obteniendo lista de docentes relacionados con asignaturas...');

    final listaDeDocentesRelacionadosConAsignaturas =
        await _ormRelacionAsignaturaUsuario.listarRegistrosEnDbPorFiltro(
      session,
      filtroCondicional:
          RelacionAsignaturaUsuario.t.fechaEliminacion.equals(null),
      incluirObjetos: RelacionAsignaturaUsuario.include(
          usuario: Usuario.include(
            direccionesDeEmail: DireccionDeEmail.includeList(),
          ),
          asignatura: Asignatura.include(),
          comision: ComisionDeCurso.include()),
    );

    logger.finer(
        'Encontrados ${listaDeDocentesRelacionadosConAsignaturas.length} docentes relacionados con asignaturas.');

    logger.finer(
        'Buscando solicitudes de calificacion mensual existentes para el mes 0$numeroDeMesDeLaSolicitud/$anioDeLaSolicitud...');

    final solicitudesDeCalificacionMensualExistentes =
        await _ormSolicitudDeCalificacionMensual.listarRegistrosEnDbPorFiltro(
      session,
      filtroCondicional:
          SolicitudCalificacionMensual.t.mes.equals(numeroDeMesDeLaSolicitud) &
              SolicitudCalificacionMensual.t.anio.equals(anioDeLaSolicitud) &
              SolicitudCalificacionMensual.t.solicitud.fechaEliminacion
                  .equals(null),
      incluirObjetos: SolicitudCalificacionMensual.include(
        solicitud: Solicitud.include(),
      ),
    );

    logger.finer(
        'Encontradas ${solicitudesDeCalificacionMensualExistentes.length} solicitudes de carga de calificación mensual para el mes 0$numeroDeMesDeLaSolicitud/$anioDeLaSolicitud...');

    List<SolicitudCalificacionMensual> solicitudesMensualesNuevas = [];

    logger.finer('Comprobando docentes faltantes de enviar solicitud...');

    for (var relacion in listaDeDocentesRelacionadosConAsignaturas) {
      if (relacion.usuario == null) {
        logger.shout(
            'No se ha podido encontrar la información del docente con ID: ${relacion.usuarioId}. Relación ID: ${relacion.id}.\nOmitiendo...');
        continue;
      }
      if (relacion.asignatura == null) {
        logger.shout(
            'No se ha podido encontrar la información de la asignatura con ID: ${relacion.asignaturaId}. Relación ID: ${relacion.id}.\nOmitiendo...');
        continue;
      }
      if (relacion.comision == null) {
        logger.shout(
            'No se ha podido encontrar la información de la comisión con ID: ${relacion.asignaturaId}. Relación ID: ${relacion.id}.\nOmitiendo...');
        continue;
      }

      final docente = relacion.usuario!;
      final asignatura = relacion.asignatura!;
      final comision = relacion.comision!;

      logger.finer(
          'Comprobando relacion docente ID ${docente.id}, asignatura ID ${asignatura.id}, comision ID ${comision.id}');

      final solicitudDeCalificacionMensualEnviada =
          solicitudesDeCalificacionMensualExistentes
              .where(
                (element) =>
                    element.comisionId == relacion.comisionId &&
                    element.idAsignatura == relacion.asignaturaId &&
                    element.solicitud?.idDestinatario == relacion.usuarioId,
              )
              .firstOrNull;

      final existeUnaSolicitudDeCalificacionMensualEnviada =
          solicitudDeCalificacionMensualEnviada != null;

      if (existeUnaSolicitudDeCalificacionMensualEnviada) {
        logger.finer('Ya existe una solicitud enviada. Omitiendo...');
        continue;
      }

      logger.finer(
          'Creando nueva solicitud para el docente con ID: ${relacion.usuarioId}...');

      final solicitudCreada = await orm.crearSolicitud(session,
          solicitud: Solicitud(
            tipoSolicitud: TipoSolicitud.calificacion,
            idAutor: usuarioAutorDeLasSolicitudes.id!,
            idDestinatario: relacion.usuarioId,
            fechaCreacion: ahora,
          ));
      if (solicitudCreada.id == null) {
        continue;
      }
      logger.finer(
          'Nueva solicitud creada para el docente con ID: ${relacion.usuarioId}. ID de solicitud: ${solicitudCreada.id}.');

      final solicitudDeCalificacionMensualAlUsuario =
          SolicitudCalificacionMensual(
        solicitudId: solicitudCreada.id!,
        comisionId: relacion.comisionId,
        idAsignatura: relacion.asignaturaId,
        mes: numeroDeMesDeLaSolicitud,
        anio: anioDeLaSolicitud,
      );

      solicitudesMensualesNuevas.add(solicitudDeCalificacionMensualAlUsuario);

      List<String> direccionesDeEmailDeContactoDelDocente;

      if (docente.direccionesDeEmail == null ||
          docente.direccionesDeEmail!.isEmpty) {
        logger.info(
            'El docente no posee direcciones de email de contacto. Se enviará a la dirección de email asociada a su cuenta.');
        final userInfoDocente = await OrmUserInfo()
            .traerInformacionDeUsuario(session, idUserInfo: docente.idUserInfo);
        if (userInfoDocente.email == null) {
          logger.info(
              'No se ha podido encontrar la dirección de email asociada a la cuenta del usuario.');
          direccionesDeEmailDeContactoDelDocente = [];
        } else {
          direccionesDeEmailDeContactoDelDocente = [userInfoDocente.email!];
          logger.finer(
              'Enviando solicitudes a ${direccionesDeEmailDeContactoDelDocente.firstOrNull}...');
        }
      } else {
        direccionesDeEmailDeContactoDelDocente =
            docente.direccionesDeEmail!.map((e) => e.direccionDeEmail).toList();
        logger.finer(
            'Enviando solicitudes a ${direccionesDeEmailDeContactoDelDocente.join(', ')}...');
      }

      final resultadoEnvioDeEmails = await _servicioComunicaciones.enviarEmail(
        session,
        direccionEmailDestinatarios: direccionesDeEmailDeContactoDelDocente,
        asuntoDelCorreo:
            asuntoDeCorreoSolicitudDeCargaDeCalificacionesMensuales,
        contenidoHtmlDelCorreo: Plantillas.pedidoDeNotas(
          nombre: docente.nombre,
          apellido: docente.apellido,
          nombreMateria: asignatura.nombre,
          nombreDeLaComision: comision.nombre,
        ),
      );

      _servicioOneSignal.enviarNotificacionesDeCargaDeCalificaciones(
        docente,
        asignatura.nombre,
        comision.nombre,
      );

      if (resultadoEnvioDeEmails.huboUnError == false) {
        logger.finer(
            'Solicitudes enviadas correctamente al docente ID ${docente.id}.');
      }
    }

    logger.finer(
        'Correos enviados. Insertando registros de solicitudes de calificación mensual...');

    await _ormSolicitudDeCalificacionMensual.insertarVariosRegistrosEnDb(
      session,
      nuevosRegistros: solicitudesMensualesNuevas,
    );
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
