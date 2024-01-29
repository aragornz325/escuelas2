import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/server.dart';

class OrmSolicitud extends ORM {
  /// La función `crearSolicitud` crea un registro de solicitud en una base de datos y devuelve el
  /// registro creado.
  /// Args:
  /// Session: Un objeto de sesión que representa una conexión a una base de datos. Se utiliza para
  /// realizar operaciones de bases de datos.
  /// solicitud (Solicitud): Un objeto de tipo Solicitud, que representa un registro de solicitud.
  Future<Solicitud> crearSolicitud(
    Session session, {
    required Solicitud solicitud,
  }) async {
    final solicitudADb = await ejecutarOperacionOrm(
      session,
      (session) => Solicitud.db.insert(
        session,
        [solicitud],
      ),
    );

    if (solicitudADb.isEmpty) {
      throw ExcepcionCustom(
        titulo: 'no se pudo crear',
        mensaje: 'error al crear registro',
        tipoDeError: TipoExcepcion.desconocido,
        codigoError: 422,
      );
    }
    return solicitudADb.first;
  }

  /// La función `actualizarSolicitud` actualiza un registro de solicitud en una base de datos y
  /// devuelve el registro actualizado.
  /// Args:
  /// Session: Un objeto de sesión que representa una conexión a una base de datos. Se utiliza para
  /// realizar operaciones de bases de datos.
  /// solicitud (Solicitud): Un objeto de tipo Solicitud, que representa un registro de solicitud.
  /// Returns:
  /// Un `Future<Solicitud>`.
  Future<Solicitud> actualizarSolicitud(
    Session session, {
    required Solicitud solicitud,
  }) async {
    final solicitudADb = await ejecutarOperacionOrm(
      session,
      (session) => Solicitud.db.update(
        session,
        [solicitud],
      ),
    );

    if (solicitudADb.isEmpty) {
      throw ExcepcionCustom(
        titulo: 'fallo al actualizar',
        mensaje: 'no se pudo actualizar el registro',
        tipoDeError: TipoExcepcion.desconocido,
        codigoError: 500,
      );
    }
    return solicitudADb.first;
  }

  /// La función `obtenerSolicitudes` devuelve todos los registros de solicitud de una base de datos.
  /// Args:
  /// Session: Un objeto de sesión que representa una conexión a una base de datos. Se utiliza para
  /// realizar operaciones de bases de datos.
  /// Returns:
  /// Un `Future<List<Solicitud>>`.
  Future<List<Solicitud>> obtenerSolicitudes(
    Session session,
  ) async {
    final solicitud = await ejecutarOperacionOrm(
      session,
      (session) => Solicitud.db.find(
        session,
      ),
    );

    if (solicitud.isEmpty) {
      throw ExcepcionCustom(
        titulo: 'no hay solicitudes',
        mensaje: 'no hay solicitudes',
        tipoDeError: TipoExcepcion.noEncontrado,
        codigoError: 404,
      );
    }
    return solicitud;
  }

  /// La función `obtenerSolicitudPorId` devuelve un registro de solicitud de una base de datos.
  /// Args:
  /// Session: Un objeto de sesión que representa una conexión a una base de datos. Se utiliza para
  /// realizar operaciones de bases de datos.
  /// id (int): El id del registro de solicitud que se desea obtener.
  /// Returns:
  /// Un `Future<Solicitud>`.
  Future<Solicitud> obtenerSolicitudPorId(
    Session session, {
    required int id,
  }) async {
    final solicitud = await ejecutarOperacionOrm(
      session,
      (session) => Solicitud.db.findById(
        session,
        id,
      ),
    );

    if (solicitud == null) {
      throw ExcepcionCustom(
        titulo: 'no encontrado',
        mensaje: 'no se encontro la solicitud',
        tipoDeError: TipoExcepcion.noEncontrado,
        codigoError: 404,
      );
    }
    return solicitud;
  }

  /// La función `eliminarSolicitud` elimina un registro de solicitud de una base de datos y devuelve
  /// el registro eliminado.
  /// Args:
  /// Session: Un objeto de sesión que representa una conexión a una base de datos. Se utiliza para
  /// realizar operaciones de bases de datos.
  /// id (int): El id del registro de solicitud que se desea eliminar.
  /// Returns:
  /// Un `Future<Solicitud>`.
  Future<int> eliminarSolicitud(
    Session session, {
    required int id,
  }) async {
    final solicitud = await ejecutarOperacionOrm(
      session,
      (session) => Solicitud.db.deleteWhere(
        session,
        where: (t) => t.id.equals(id),
      ),
    );
    if (solicitud.isEmpty) {
      throw ExcepcionCustom(
        titulo: 'no encontrado',
        mensaje: 'no se encontro la solicitud',
        tipoDeError: TipoExcepcion.noEncontrado,
        codigoError: 404,
      );
    }
    return solicitud.first;
  }

  Future<List<Solicitud>> obtenerSolicitudesPendientes(
    Session session,
  ) async =>
      ejecutarOperacionOrm(
        session,
        (session) => Solicitud.db.find(
          session,
          where: (t) => t.fechaRealizacion.equals(null),
        ),
      );
}
