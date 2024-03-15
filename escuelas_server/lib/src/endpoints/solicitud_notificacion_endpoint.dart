import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/servicio_solicitud_notificacion.dart';

import 'package:serverpod/serverpod.dart';

class SolicitudNotificacionEndpoint extends Endpoint
    with Controller<ServicioSolicitudNotificacion> {
  @override
  ServicioSolicitudNotificacion get servicio => ServicioSolicitudNotificacion();

  /// La función `obtenerSolicitudesNotificacionesPendientes` obtiene una lista de solicitudes pendientes en una base de datos y
  /// devuelve la lista.
  Future<List<SolicitudEnvioNotificacion>>
      obtenerSolicitudesNotificacionesPendientes(
    Session session,{
      String? userId, 
    }
  ) async {
    return await ejecutarOperacionControlador(
      session,
      'obtenerSolicitudesNotificacionesPendientes',
      () => servicio.obtenerSolicitudesNotificacionesPendientes(
        session,
        userId: userId,
      ),
    );
  }

  /// La función `editarSolicitudNotificacionPendiente` actualiza una notificacion pendiente
  /// en la base de datos.
  Future<void> editarSolicitudNotificacionPendiente(
    Session session, {
    required Notificacion notificacionPendiente,
  }) async {
    return await ejecutarOperacionControlador(
      session,
      'editarSolicitudNotificacionPendiente',
      () => servicio.editarSolicitudNotificacionPendiente(
        session,
        notificacionPendiente: notificacionPendiente,
      ),
    );
  }

  /// La función `responderSolicitudNotificacionPendiente` actualiza una notificacion pendiente
  /// en la base de datos, respondiendo a la solicitud aprobandola o rechazandola.
  Future<void> responderSolicitudNotificacionPendiente(
    Session session, {
    required SolicitudEnvioNotificacion solicitudEnvioNotificacion,
  }) async {
    return await ejecutarOperacionControlador(
      session,
      'responderSolicitudNotificacionPendiente',
      () => servicio.responderSolicitudNotificacionPendiente(
        session,
        solicitudEnvioNotificacion: solicitudEnvioNotificacion,
      ),
    );
  }
}
