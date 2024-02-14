import 'package:escuelas_commons/modelo_notificacion/notificacion_data.dart';
import 'package:escuelas_server/src/extensiones/estado_asistencia.dart';
import 'package:escuelas_server/src/generated/protocol/asistencia/asistencia_diaria.dart';
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

      // TODO(ANYONE): Las notificaciones deberian estar guardadas en base de datos.
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
}
