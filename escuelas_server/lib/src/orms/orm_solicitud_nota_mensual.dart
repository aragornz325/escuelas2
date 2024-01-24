import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/server.dart';

class OrmSolicitudNotaMensual extends ORM {
  /// La función `crearSolicitudNotaMensual` crea un registro de solicitud en una base de datos y devuelve el
  /// registro creado.
  /// Args:
  /// Session: Un objeto de sesión que representa una conexión a una base de datos. Se utiliza para
  /// SolicitudNotaMensual (SolicitudNotaMensual): Un objeto de tipo SolicitudNotaMensual, que representa un registro de solicitud.
  /// Returns:
  /// Un `Future<SolicitudNotaMensual>`.
  Future<SolicitudNotaMensual> crearSolicitudNotaMensual(
    Session session, {
    required SolicitudNotaMensual solicitudNotaMensual,
  }) async {
    final solicitudNotaMensualADb = await ejecutarOperacionOrm(
      session,
      (session) => SolicitudNotaMensual.db.insert(
        session,
        [solicitudNotaMensual],
      ),
    );

    if (solicitudNotaMensualADb.isEmpty) {
      throw ExcepcionCustom(
          titulo: 'no se pudo crear',
          mensaje: 'error al crear registro',
          tipoDeError: TipoExcepcion.desconocido,
          codigoError: 422);
    }
    return solicitudNotaMensualADb.first;
  }

  /// La función `actualizarSolicitudNotaMensual` actualiza un registro de solicitud en una base de datos y
  /// devuelve el registro actualizado.
  Future<SolicitudNotaMensual> actualizarSolicitudNotaMensual(
    Session session, {
    required SolicitudNotaMensual solicitudNotaMensual,
  }) async {
    final solicitudNotaMensualADb = await ejecutarOperacionOrm(
      session,
      (session) => SolicitudNotaMensual.db.update(
        session,
        [solicitudNotaMensual],
      ),
    );
    if (solicitudNotaMensualADb.isEmpty) {
      throw ExcepcionCustom(
          titulo: 'fallo al actualizar',
          mensaje: 'no se pudo actualizar el registro',
          tipoDeError: TipoExcepcion.desconocido,
          codigoError: 500);
    }
    return solicitudNotaMensualADb.first;
  }

  /// La función `obtenerSolicitudNotaMensual` obtiene un registro de solicitud en una base de datos y
  /// devuelve el registro.
  /// Args:
  /// Session: Un objeto de sesión que representa una conexión a una base de datos. Se utiliza para
  /// realizar operaciones de bases de datos.
  /// id (int): Un entero que representa el id del registro de solicitud.
  /// Returns:
  /// Un `Future<SolicitudNotaMensual>`.

  Future<SolicitudNotaMensual> obtenerSolicitudNotaMensual(
    Session session, {
    required int id,
  }) async {
    final solicitudNotaMensualADb = await ejecutarOperacionOrm(
      session,
      (session) => SolicitudNotaMensual.db.findById(
        session,
        id,
        include: SolicitudNotaMensual.include(
          solicitud: Solicitud.include(),
        ),
      ),
    );

    if (solicitudNotaMensualADb == null) {
      throw ExcepcionCustom(
          titulo: 'no se pudo obtener',
          mensaje: 'no se pudo obtener el registro',
          tipoDeError: TipoExcepcion.desconocido,
          codigoError: 404);
    }
    return solicitudNotaMensualADb;
  }

  Future<SolicitudNotaMensual> obtenerSolicitudNotaMensualPorIdSolicitud(
    Session session, {
    required int idSolicitud,
  }) async {
    final solicitudNotaMensualADb = await ejecutarOperacionOrm(
      session,
      (session) => SolicitudNotaMensual.db.findFirstRow(
        session,
        where: (t) => t.solicitudId.equals(idSolicitud),
        include: SolicitudNotaMensual.include(
          solicitud: Solicitud.include(),
        ),
      ),
    );

    if (solicitudNotaMensualADb == null) {
      throw ExcepcionCustom(
        titulo: 'no se pudo obtener',
        mensaje: 'no se pudo obtener el registro',
        tipoDeError: TipoExcepcion.desconocido,
        codigoError: 404,
      );
    }

    return solicitudNotaMensualADb;
  }

  /// La función `obtenerSolicitudesNotaMensual` obtiene todos los registros de solicitud en una base de datos y
  /// devuelve los registros.
  /// Args:
  /// Session: Un objeto de sesión que representa una conexión a una base de datos. Se utiliza para
  /// realizar operaciones de bases de datos.
  ///
  Future<List<SolicitudNotaMensual>> obtenerSolicitudesNotaMensual(
    Session session,
  ) async {
    final solicitudNotaMensualADb = await ejecutarOperacionOrm(
      session,
      (session) => SolicitudNotaMensual.db.find(
        session,
        include: SolicitudNotaMensual.include(
          solicitud: Solicitud.include(),
        ),
      ),
    );

    if (solicitudNotaMensualADb.isEmpty) {
      throw ExcepcionCustom(
        titulo: 'no se pudo obtener',
        mensaje: 'no se pudieron obtener registros',
        tipoDeError: TipoExcepcion.desconocido,
        codigoError: 560,
      );
    }
    return solicitudNotaMensualADb;
  }

  /// La función `eliminarSolicitudNotaMensual` elimina un registro de solicitud en una base de datos y
  /// devuelve el id del registro eliminado.
  /// Args:
  /// realizar operaciones de bases de datos.
  /// id (int): Un entero que representa el id del registro de solicitud.
  /// Returns:
  /// Un `Future<int>`.
  Future<int> eliminarSolicitudNotaMensual(
    Session session, {
    required int id,
  }) async {
    final solicitudNotaMensualADb = await ejecutarOperacionOrm(
      session,
      (session) => SolicitudNotaMensual.db.deleteWhere(
        session,
        where: (t) => t.id.equals(id),
      ),
    );

    if (solicitudNotaMensualADb.isEmpty) {
      throw ExcepcionCustom(
          titulo: 'no se pudo eliminar',
          mensaje: 'no se pudo eliminar el registro',
          tipoDeError: TipoExcepcion.desconocido,
          codigoError: 500);
    }
    return solicitudNotaMensualADb.first;
  }

  Future<List<SolicitudNotaMensual>> obtenerSolicitudesCalificacionMensual(
    Session session, {
    required int numeroDeMes,
  }) async =>
      ejecutarOperacionOrm(
        session,
        (session) => SolicitudNotaMensual.db.find(
          session,
          where: (t) => t.numeroDeMes.equals(numeroDeMes),
          include: SolicitudNotaMensual.include(
            solicitud: Solicitud.include(),
          ),
        ),
      );

  Future<List<SolicitudNotaMensual>> crearSolicitudesMensualesEnLote(
    Session session, {
    required List<SolicitudNotaMensual> solicitudNotaMensual,
  }) async {
    final solicitudNotaMensualADb = await ejecutarOperacionOrm(
      session,
      (session) => SolicitudNotaMensual.db.insert(
        session,
        solicitudNotaMensual,
      ),
    );

    if (solicitudNotaMensualADb.isEmpty) {
      return [];
    }
    return solicitudNotaMensualADb;
  }

  /// La función `obtenerSoliciturPorAsignaturaComisionyMes` recupera una solicitud de nota mensual por
  /// tema, comisión y mes dados.
  ///
  /// Args:
  ///   session (Session):
  ///   idAsignatura (int): El parámetro "ID del sujeto" representa el ID del sujeto.
  ///   idComision: El parámetro "idComision" se utiliza para especificar el ID de una comisión.
  ///   numeroDeMes (int): El parámetro "numeroDeMes" representa el número del mes para el cual se
  /// realiza la solicitud de nota mensual.
  ///
  /// Returns:
  ///   a Futuro de tipo SolicitudNotaMensual.
  Future<List<SolicitudNotaMensual>>
      obtenerSolicitudesPorAsignaturaComisionyMes(
    Session session, {
    required int idAsignatura,
    required idComision,
    required int numeroDeMes,
  }) async {
    final solicitud = await ejecutarOperacionOrm(
      session,
      (session) => SolicitudNotaMensual.db.find(
        session,
        where: (t) =>
            t.idAsignatura.equals(idAsignatura) &
            t.idComision.equals(idComision) &
            t.numeroDeMes.equals(numeroDeMes),
      ),
    );
    if (solicitud.isEmpty) {
      return [];
    }

    return solicitud;
  }
}
