import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/servicio_solicitud.dart';
import 'package:serverpod/serverpod.dart';

class SolicitudEndpoint extends Endpoint with Controller<ServicioSolicitud> {
  @override
  ServicioSolicitud get servicio => ServicioSolicitud();

  /// la funcion `crearSolicitud` crea un registro de solicitud en una base de datos y devuelve el
  /// registro creado.
  Future<Solicitud> crearSolicitud(
    Session session,
    Solicitud solicitud,
  ) async {
    return await ejecutarOperacionControlador(
      session,
      'crearSolicitu',
      () => servicio.crearSolicitud(
        session,
        solicitud: solicitud,
      ),
    );
  }

  /// la funcion `actualizarSolicitud` actualiza un registro de solicitud en una base de datos y
  /// devuelve el registro actualizado.
  Future<Solicitud> actualizarSolicitud(
    Session session,
    Solicitud solicitud,
  ) async {
    return await ejecutarOperacionControlador(
      session,
      'actualizarSolicitud',
      () => servicio.actualizarSolicitud(
        session,
        solicitud: solicitud,
      ),
    );
  }

  /// la funcion `obtenerSolicitudes` recupera una lista de solicitudes utilizando un objeto de sesión.
  /// Args:
  /// Session:
  Future<List<Solicitud>> obtenerSolicitudes(
    Session session,
  ) async {
    return await ejecutarOperacionControlador(
      session,
      'obtenerSolicitudes',
      () => servicio.obtenerSolicitudes(
        session,
      ),
    );
  }

  /// la funcion `obtenerSolicitudPorId` obtiene un registro de solicitud en una base de datos y
  /// devuelve el registro.
  /// Args:
  /// Session:
  /// id:
  Future<Solicitud> obtenerSolicitud(
    Session session,
    int id,
  ) async {
    return await ejecutarOperacionControlador(
      session,
      'obtenerSolicitud',
      () => servicio.obtenerSolicitudPorId(
        session,
        id: id,
      ),
    );
  }

  ///la funcion `obtenerSolicitudes` recupera una lista de solicitudes utilizando un objeto de sesión.
  /// Args:
  /// Session:
  Future<List<Solicitud>> obtenerSolicitudesPorIdUsuario(
    Session session,
    int idUsuario,
  ) async {
    return await ejecutarOperacionControlador(
      session,
      'obtenerSolicitudesPorIdUsuario',
      () => servicio.obtenerSolicitudes(
        session,
      ),
    );
  }

  /// la funcion `eliminarSolicitud` elimina un registro de solicitud de una base de datos utilizando
  /// un objeto de sesión y un parámetro `id`.
  /// Args:
  /// Session:
  /// id:
  /// Returns:
  /// un `Future<int>`.
  Future<int> eliminarSolicitud(
    Session session,
    int id,
  ) async {
    return await ejecutarOperacionControlador(
      session,
      'eliminarSolicitud',
      () => servicio.eliminarSolicitud(
        session,
        id: id,
      ),
    );
  }
}
