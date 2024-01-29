import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/servicio_solicitud_nota_mensual.dart';
import 'package:serverpod/serverpod.dart';

class SolicitudNotaMensualEndpoint extends Endpoint
    with Controller<ServicioSolicitudNotaMensual> {
  @override
  ServicioSolicitudNotaMensual get servicio => ServicioSolicitudNotaMensual();

  /// La función `crearSolicitudNotaMensual` crea un registro de solicitud en una base de datos y devuelve el
  /// registro creado.
  Future<SolicitudCalificacionMensual> crearSolicitudNotaMensual(
    Session session,
    SolicitudCalificacionMensual solicitudNotaMensual,
  ) async {
    return await ejecutarOperacionControlador(
      session,
      'crearSolicitudNotaMensual',
      () => servicio.crearSolicitudNotaMensual(
        session,
        solicitudNotaMensual: solicitudNotaMensual,
      ),
    );
  }

  /// La función `actualizarSolicitudNotaMensual` actualiza un registro de solicitud en una base de datos y
  /// devuelve el registro actualizado.
  /// Args:
  /// Session:
  /// solicitudNotaMensual (SolicitudNotaMensual): Un objeto de tipo SolicitudNotaMensual, que representa un registro de solicitud.
  Future<SolicitudCalificacionMensual> actualizarSolicitudNotaMensual(
    Session session,
    SolicitudCalificacionMensual solicitudNotaMensual,
  ) async {
    return await ejecutarOperacionControlador(
      session,
      'actualizarSolicitudNotaMensual',
      () => servicio.actualizarSolicitudNotaMensual(
        session,
        solicitudNotaMensual: solicitudNotaMensual,
      ),
    );
  }

  /// La función `obtenerSolicitudNotaMensual` obtiene un registro de solicitud en una base de datos y
  /// devuelve el registro.
  Future<SolicitudCalificacionMensual> obtenerSolicitudNotaMensual(
    Session session,
    int id,
  ) async {
    return await ejecutarOperacionControlador(
      session,
      'obtenerSolicitudNotaMensual',
      () => servicio.obtenerSolicitudNotaMensual(
        session,
        id: id,
      ),
    );
  }

  /// La función `obtenerSolicitudesNotaMensual` obtiene una lista de solicitudes en una base de datos y
  /// devuelve la lista.
  Future<List<SolicitudCalificacionMensual>> obtenerSolicitudesNotaMensual(
    Session session,
  ) async {
    return await ejecutarOperacionControlador(
      session,
      'obtenerSolicitudesNotaMensual',
      () => servicio.obtenerSolicitudesNotaMensual(
        session,
      ),
    );
  }

  /// La función `eliminarSolicitudNotaMensual` elimina un registro de solicitud en una base de datos y
  /// devuelve el id del registro eliminado.
  Future<int> eliminarSolicitudNotaMensual(
    Session session,
    int id,
  ) async {
    return await ejecutarOperacionControlador(
      session,
      'eliminarSolicitudNotaMensual',
      () => servicio.eliminarSolicitudNotaMensual(
        session,
        id: id,
      ),
    );
  }

  Future<bool> enviarSolicitudADocentes(Session session) async {
    await ejecutarOperacionControlador(
      session,
      'enviarSolicitudADocentes',
      () => servicio.enviarSolicitudADocentes(
        session,
      ),
    );
    return true;
  }

  Future<List<SolicitudesComisionMensual>> obtenerSolicitudesPorComisionMensual(
    Session session, {
    required int numeroDeMes,
    required int numeroDeAnio,
  }) async =>
      ejecutarOperacionControlador(
        session,
        'obtenerSolicitudesPorComisionMensual',
        () => servicio.obtenerSolicitudesPorComisionMensual(
          session,
          numeroDeMes: numeroDeMes,
          numeroDeAnio: numeroDeAnio,
        ),
      );
}
