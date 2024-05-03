import 'package:escuelas_commons/modelo_notificacion/notificacion_data.dart';
import 'package:escuelas_server/src/extensiones/estado_asistencia.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/handlers/manejador_one_signal.dart';

class ServicioOneSignal {
  ServicioOneSignal();

// TODO(ANYONE): add docu, q tabla se usa para sacar la data etc.

  /// Envia notificaciones de inasistencia obteniendolas de la tabla X
  Future<void> enviarNotificacionesDeInasistencia(
    List<AsistenciaDiaria> listaInasistencias,
  ) async {
    final List<Future<void>> futures = [];

    for (AsistenciaDiaria inasistencia in listaInasistencias) {
      final estudiante = inasistencia.estudiante!;

      final userId = inasistencia.estudianteId.toString();

      final nombreUsuario = estudiante.nombre.toString();

      final apellidoUsuario = estudiante.apellido.toString();

      // TODO(ANYONE): Las notificaciones deberian estar guardadas en base de datos, carry over en esa HU.
      // https://tree.taiga.io/project/rodsevich-escuelas/us/208?kanban-status=7686844&kanban-swimlane=15087
      final notificationData = NotificacionData(
        titulo: 'Inasistencia de $nombreUsuario $apellidoUsuario.',
        contenido:
            'En el día de la fecha se registró ${inasistencia.estadoDeAsistencia.nombreEstado()} para $nombreUsuario $apellidoUsuario.',
        pathRuta: 'absences',
        // TODO(ANYONE): Agregar ID notificacion una vez implementado el CRUD.
        idNotificacion: '1',
      );

      final notificationFuture =
          ManejadorOneSignal.instance.enviarPushNotification(
        notificationData: notificationData,
        includeExternalUserIds: [userId],
      );

      futures.add(notificationFuture);
    }

    // Espera que todas las notificaciones se envien antes de avanzar.
    await Future.wait(futures);
  }

  /// Envia notificaciones de Carga de Calificaciones a los docentes.
  Future<void> enviarNotificacionesDeCargaDeCalificaciones(
    Usuario docente,
    String nombreAsignatura,
    String comision,
  ) async {
    final userId = docente.id.toString();

    final nombreUsuario = docente.nombre.toString();

    final apellidoUsuario = docente.apellido.toString();

    // TODO(ANYONE): Las notificaciones deberian estar guardadas en base de datos, carry over en esa HU.
    // https://tree.taiga.io/project/rodsevich-escuelas/us/208?kanban-status=7686844&kanban-swimlane=15087
    final notificationData = NotificacionData(
      titulo: 'Solicitud de carga de calificaciones mensuales de $nombreAsignatura de $comision.',
      contenido:
          'En el día de la fecha se registró una solicitud de carga de calificaciones mensuales de $nombreAsignatura de $comision para $nombreUsuario $apellidoUsuario. Por favor revise su estado de Carga de Calificaciones.',
      pathRuta: 'my-courses',
      // TODO(ANYONE): Agregar ID notificacion una vez implementado el CRUD.
      idNotificacion: '1',
    );

    await ManejadorOneSignal.instance.enviarPushNotification(
      notificationData: notificationData,
      includeExternalUserIds: [userId],
    );
  }

  /// Envia notificaciones de solicitudes de comunicaciones/ notificaciones pendientes a resolver
  /// por el directivo.
  Future<void> enviarNotificacionesDeSolicitudesNotificacionesPendientes({
    required List<SolicitudEnvioNotificacion> listaSolicitudesNotificaciones,
    required String userId,
  }) async {
    final List<Future<void>> futures = [];

    final cantidadSolicitudesNotificaciones =
        listaSolicitudesNotificaciones.length.toString();
    final nombreAlumno = listaSolicitudesNotificaciones[0].alumno?.nombre ?? '';
    final nombreDocente =
        listaSolicitudesNotificaciones[0].docente?.nombre ?? '';
    final apellidoAlumno =
        listaSolicitudesNotificaciones[0].alumno?.apellido ?? '';
    final apellidoDocente =
        listaSolicitudesNotificaciones[0].docente?.apellido ?? '';
    final nombreComision =
        listaSolicitudesNotificaciones[0].comision?.nombre ?? '';

    // TODO(ANYONE): Las notificaciones deberian estar guardadas en base de datos, carry over en esa HU.
    // https://tree.taiga.io/project/rodsevich-escuelas/us/208?kanban-status=7686844&kanban-swimlane=15087
    final notificationData = NotificacionData(
      titulo:
          'Tenés $cantidadSolicitudesNotificaciones solicitudes de notificación pendientes.',
      contenido:
          '$nombreDocente $apellidoDocente quiere notificar a $nombreAlumno $apellidoAlumno de $nombreComision',
      pathRuta: 'communications',
      // TODO(ANYONE): Agregar ID notificacion una vez implementado el CRUD.
      idNotificacion: '2',
    );

    final notificationFuture =
        ManejadorOneSignal.instance.enviarPushNotification(
      notificationData: notificationData,
      includeExternalUserIds: [userId],
    );

    futures.add(notificationFuture);

    // Espera que todas las notificaciones se envien antes de avanzar.
    await Future.wait(futures);
  }
}
