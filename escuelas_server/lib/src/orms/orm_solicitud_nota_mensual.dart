import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/server.dart';

class OrmSolicitudNotaMensual extends ORM {
  /// La función `crearSolicitudNotaMensual` crea un registro de solicitud en una base de datos y devuelve el
  /// registro creado.
  Future<SolicitudCalificacionMensual> crearSolicitudNotaMensual(
    Session session, {
    required SolicitudCalificacionMensual solicitudNotaMensual,
  }) async {
    final solicitudNotaMensualADb = await ejecutarOperacionOrm(
      session,
      (session) => SolicitudCalificacionMensual.db.insert(
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
  Future<SolicitudCalificacionMensual> actualizarSolicitudNotaMensual(
    Session session, {
    required SolicitudCalificacionMensual solicitudNotaMensual,
  }) async {
    final solicitudNotaMensualADb = await ejecutarOperacionOrm(
      session,
      (session) => SolicitudCalificacionMensual.db.update(
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
  Future<SolicitudCalificacionMensual> obtenerSolicitudNotaMensual(
    Session session, {
    required int id,
  }) async {
    final solicitudNotaMensualADb = await ejecutarOperacionOrm(
      session,
      (session) => SolicitudCalificacionMensual.db.findById(
        session,
        id,
        include: SolicitudCalificacionMensual.include(
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

  Future<SolicitudCalificacionMensual>
      obtenerSolicitudNotaMensualPorIdSolicitud(
    Session session, {
    required int idSolicitud,
  }) async {
    final solicitudNotaMensualADb = await ejecutarOperacionOrm(
      session,
      (session) => SolicitudCalificacionMensual.db.find(
        session,
        where: (t) => t.solicitudId.equals(idSolicitud),
        include: SolicitudCalificacionMensual.include(
          solicitud: Solicitud.include(),
        ),
      ),
    );
    
    if (solicitudNotaMensualADb.isEmpty) {
      throw ExcepcionCustom(
        titulo: 'no se pudo obtener',
        mensaje: 'no se pudo obtener el registro',
        tipoDeError: TipoExcepcion.desconocido,
        codigoError: 404,
      );
    }

    return solicitudNotaMensualADb.first;
  }

  /// La función `obtenerSolicitudesNotaMensual` obtiene todos los registros de solicitud en una base de datos y
  /// devuelve los registros.
  Future<List<SolicitudCalificacionMensual>> obtenerSolicitudesNotaMensual(
    Session session,
  ) async {
    final solicitudNotaMensualADb = await ejecutarOperacionOrm(
      session,
      (session) => SolicitudCalificacionMensual.db.find(
        session,
        include: SolicitudCalificacionMensual.include(
          solicitud: Solicitud.include(),
          comision: ComisionDeCurso.include(),
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
  Future<int> eliminarSolicitudNotaMensual(
    Session session, {
    required int id,
  }) async {
    final solicitudNotaMensualADb = await ejecutarOperacionOrm(
      session,
      (session) => SolicitudCalificacionMensual.db.deleteWhere(
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

  Future<List<SolicitudCalificacionMensual>>
      obtenerSolicitudesCalificacionMensual(
    Session session, {
    required int numeroDeMes,
  }) async =>
          ejecutarOperacionOrm(
            session,
            (session) => SolicitudCalificacionMensual.db.find(
              session,
              where: (t) => t.mes.equals(
                numeroDeMes,
              ),
              include: SolicitudCalificacionMensual.include(
                solicitud: Solicitud.include(),
              ),
            ),
          );

  Future<List<SolicitudCalificacionMensual>> crearSolicitudesMensualesEnLote(
    Session session, {
    required List<SolicitudCalificacionMensual> solicitudNotaMensual,
  }) async {
    final solicitudNotaMensualADb = await ejecutarOperacionOrm(
      session,
      (session) => SolicitudCalificacionMensual.db.insert(
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
  Future<List<SolicitudCalificacionMensual>>
      obtenerSolicitudesPorAsignaturaComisionyMes(
    Session session, {
    required int idAsignatura,
    required idComision,
    required int numeroDeMes,
  }) async {
    final solicitud = await ejecutarOperacionOrm(
      session,
      (session) => SolicitudCalificacionMensual.db.find(
        session,
        where: (t) =>
            t.idAsignatura.equals(
              idAsignatura,
            ) &
            t.comisionId.equals(
              idComision,
            ) &
            t.mes.equals(
              numeroDeMes,
            ),
        include: SolicitudCalificacionMensual.include(
          solicitud: Solicitud.include(),
        ),
      ),
    );
    if (solicitud.isEmpty) {
      return [];
    }

    return solicitud;
  }
}
