import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/server.dart';

class OrmSolicitudNotificacion extends ORM {
  /// La función `obtenerSolicitudesNotificacionesPendientes` obtiene todos los registros de solicitud de envio de
  /// notificacion en una base de datos y devuelve los registros.
  Future<List<SolicitudEnvioNotificacion>>
      obtenerSolicitudesNotificacionesPendientes(
    Session session,
  ) async {
    final solicitudesNotificacion = await ejecutarOperacionOrm(
      session,
      (session) => SolicitudEnvioNotificacion.db.find(
        session,
        where: (t) => t.estado.equals(
          EstadoDeSolicitud.pendiente,
        ),
        include: SolicitudEnvioNotificacion.include(
          solicitud: Solicitud.include(),
          comision: ComisionDeCurso.include(),
          notificacion: Notificacion.include(),
          docente: Usuario.include(),
          alumno: Usuario.include(),
        ),
      ),
    );

    return solicitudesNotificacion;
  }

  /// La función `editarSolicitudNotificacionPendiente` actualiza una notificacion pendiente.
  Future<void> editarSolicitudNotificacionPendiente(
    Session session, {
    required Notificacion notificacionPendiente,
  }) async =>
      ejecutarOperacionOrm(
        session,
        (session) => Notificacion.db.updateRow(
          session,
          notificacionPendiente,
          columns: (t) => [
            t.titulo,
            t.cuerpo,
            t.fueEditada,
            t.ultimaModificacion,
          ],
        ),
      );

  /// La función `responderSolicitudNotificacionPendiente` actualiza una
  /// solicitud notificacion pendiente, cambiando su estado a aprobado o rechazado.
  Future<void> responderSolicitudNotificacionPendiente(
    Session session, {
    required SolicitudEnvioNotificacion solicitudEnvioNotificacion,
  }) async =>
      ejecutarOperacionOrm(
        session,
        (session) => SolicitudEnvioNotificacion.db.updateRow(
          session,
          solicitudEnvioNotificacion,
          columns: (t) => [t.estado],
        ),
      );
}
