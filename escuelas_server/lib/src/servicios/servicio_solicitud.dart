import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_solicitud.dart';
import 'package:escuelas_server/src/orms/orm_solicitud_nota_mensual.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:serverpod/server.dart';

class ServicioSolicitud extends Servicio<OrmSolicitud> {
  @override
  OrmSolicitud get orm => OrmSolicitud();

  final _ormSolicitudNotaMensual = OrmSolicitudNotaMensual();

  /// La función `crearSolicitud` crea un registro de solicitud en una base de datos y devuelve el
  /// registro creado.
  /// Args:
  /// Session:
  /// solicitud (Solicitud): Un objeto de tipo Solicitud, que representa un registro de solicitud.
  /// Returns:
  /// Un `Future<Solicitud>`.
  Future<Solicitud> crearSolicitud(
    Session session, {
    required Solicitud solicitud,
  }) async {
    final solicitudADb = await ejecutarOperacion(
      () => orm.crearSolicitud(
        session,
        solicitud: solicitud,
      ),
    );
    return solicitudADb;
  }

  /// La función `actualizarSolicitud` actualiza un registro de solicitud en una base de datos y
  /// devuelve el registro actualizado.
  /// Args:
  /// Session:
  /// solicitud (Solicitud): Un objeto de tipo Solicitud, que representa un registro de solicitud.
  /// Returns:
  /// Un `Future<Solicitud>`.
  Future<Solicitud> actualizarSolicitud(
    Session session, {
    required Solicitud solicitud,
  }) async {
    final solicitudADb = await ejecutarOperacion(
      () => orm.actualizarSolicitud(
        session,
        solicitud: solicitud,
      ),
    );
    return solicitudADb;
  }

  /// La función `obtenerSolicitudes` recupera una lista de solicitudes utilizando un objeto de sesión.
  /// Args:
  /// Session:
  /// Returns:
  /// un `Future<List<Solicitud>>`.
  Future<List<Solicitud>> obtenerSolicitudes(
    Session session,
  ) async {
    final solicitudes = await ejecutarOperacion(
      () => orm.obtenerSolicitudes(session),
    );
    return solicitudes;
  }

  /// La función `obtenerSolicitudPorId` recupera una solicitud utilizando un objeto de sesión y un
  /// parámetro `id`.
  /// Args:
  /// Session:
  /// id (int): El parámetro "id" es de tipo "int" y es obligatorio.
  /// Returns:
  /// un `Future<Solicitud>`.
  Future<Solicitud> obtenerSolicitudPorId(
    Session session, {
    required int id,
  }) async {
    final solicitud = await ejecutarOperacion(
      () => orm.obtenerSolicitudPorId(
        session,
        id: id,
      ),
    );
    return solicitud;
  }

  /// La función `eliminarSolicitud` elimina un registro de solicitud de una base de datos utilizando
  /// una sesión y un parámetro `id`.
  /// Args:
  /// Session:
  /// id (int): El parámetro "id" es de tipo "int" y es obligatorio.
  /// Returns:
  /// un `Future<int>`.
  Future<int> eliminarSolicitud(
    Session session, {
    required int id,
  }) async {
    final solicitud = await ejecutarOperacion(
      () => orm.eliminarSolicitud(
        session,
        id: id,
      ),
    );
    return solicitud;
  }

  Future<List<Solicitud>> obtenerSolicitudesPendientes(
    Session session,
  ) async =>
      ejecutarOperacion(
        () => orm.obtenerSolicitudesPendientes(session),
      );

  Future<List<SolicitudNotaMensual>> obtenerSolicitudesCalificacionMensual(
    Session session, {
    required int numeroDeMes,
  }) async =>
      ejecutarOperacion(
        () => _ormSolicitudNotaMensual.obtenerSolicitudesCalificacionMensual(
          session,
          numeroDeMes: numeroDeMes,
        ),
      );
}
