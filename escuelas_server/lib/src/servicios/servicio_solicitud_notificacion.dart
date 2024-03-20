import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_solicitud_notificacion.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:escuelas_server/src/servicios/servicio_one_signal.dart';
import 'package:serverpod/serverpod.dart';

class ServicioSolicitudNotificacion extends Servicio<OrmSolicitudNotificacion> {
  OrmSolicitudNotificacion get ormNotificacion => OrmSolicitudNotificacion();

  final _servicioOneSignal = ServicioOneSignal();

  /// La función `obtenerSolicitudesNotificacionesPendientes` recupera una lista de solicitudes de notificacion  utilizando un objeto de sesión.
  Future<List<SolicitudEnvioNotificacion>>
      obtenerSolicitudesNotificacionesPendientes(
    Session session, {
    String? userId,
  }) async {
    final solicitudesNotificacionPendiente = await ejecutarOperacion(
      () => ormNotificacion.obtenerSolicitudesNotificacionesPendientes(session),
    );
    // TODO(SAM): Verificar para q se mande 1 vez.
    if (userId != null && solicitudesNotificacionPendiente.isNotEmpty) {
      _servicioOneSignal
          .enviarNotificacionesDeSolicitudesNotificacionesPendientes(
        listaSolicitudesNotificaciones: solicitudesNotificacionPendiente,
        userId: userId,
      );
    }

    return solicitudesNotificacionPendiente;
  }

  /// La función `editarSolicitudNotificacionPendiente` actualiza una notificacion pendiente.
  Future<void> editarSolicitudNotificacionPendiente(
    Session session, {
    required Notificacion notificacionPendiente,
  }) async {
    final ahora = DateTime.now();

    return ejecutarOperacion(
      () => ormNotificacion.editarSolicitudNotificacionPendiente(
        session,
        notificacionPendiente: notificacionPendiente
          ..ultimaModificacion = ahora,
      ),
    );
  }

  /// La función `responderSolicitudNotificacionPendiente` actualiza una
  /// solicitud notificacion pendiente,
  /// cambiando su estado a aprobado o rechazado.
  Future<void> responderSolicitudNotificacionPendiente(
    Session session, {
    required SolicitudEnvioNotificacion solicitudEnvioNotificacion,
  }) async {
    return ejecutarOperacion(
      () => ormNotificacion.responderSolicitudNotificacionPendiente(
        session,
        solicitudEnvioNotificacion: solicitudEnvioNotificacion,
      ),
    );
  }
}
