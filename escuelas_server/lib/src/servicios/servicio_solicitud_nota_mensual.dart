import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_solicitud_nota_mensual.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:serverpod/server.dart';

class ServicioSolicitudNotaMensual extends Servicio<OrmSolicitudNotaMensual> {
  @override
  OrmSolicitudNotaMensual get orm => OrmSolicitudNotaMensual();

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
}
