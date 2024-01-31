import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmCalificacion extends ORM {
  Future<List<Calificacion>> crearCalificaciones(
    Session session, {
    required List<Calificacion> calificaciones,
  }) async {
    return await ejecutarOperacionOrm(
      session,
      (session) => Calificacion.db.insert(
        session,
        calificaciones,
      ),
    );
  }

  Future<List<Calificacion>> obtenerCalificaciones(
    Session session, {
    Periodo? periodo,
  }) async =>
      ejecutarOperacionOrm(
        session,
        (session) => Calificacion.db.find(
          session,
          where: (t) {
            if (periodo != null) {
              return t.fechaCreacion.between(
                periodo.fechaInicio,
                periodo.fechaFin,
              );
            }

            return t.id.notEquals(null);
          },
        ),
      );

  Future<List<Calificacion>> actualizarCalificaciones(
    Session session, {
    required List<Calificacion> calificaciones,
  }) async {
    return await ejecutarOperacionOrm(
      session,
      (session) => Calificacion.db.update(
        session,
        calificaciones,
      ),
    );
  }

  Future<List<int>> eliminarCalificaciones(
    Session session, {
    required List<Calificacion> calificaciones,
  }) async {
    return await ejecutarOperacionOrm(
      session,
      (session) => Calificacion.db.delete(session, calificaciones),
    );
  }

  /// La función `obtenerCalificacionesPorAsignaturaPorPeriodo` recupera una lista de calificaciones
  /// para una materia y periodo específico.
  ///
  /// Args:
  ///   session (Session): El parámetro de sesión es una instancia de la clase Session, que se utiliza
  /// para interactuar con la base de datos.
  ///   idAsignatura (int): El ID de la asignatura de la que quieres obtener las calificaciones.
  ///   periodo (Periodo): El parámetro "periodo" es un objeto de tipo "Periodo" que representa un
  /// período de tiempo específico. Tiene dos propiedades: "fechaInicio" (fecha de inicio del período)
  /// y "fechaFin" (fecha de finalización del período).
  ///
  /// Returns:
  ///   a `Future<List<Calificacion>>`.
  Future<List<Calificacion>> obtenerCalificacionesPorAsignaturaPorPeriodo(
    Session session, {
    required int idAsignatura,
    required Periodo periodo,
  }) async {
    return await ejecutarOperacionOrm(
      session,
      (session) => Calificacion.db.find(
        session,
        where: (t) {
          return t.idAsignatura.equals(idAsignatura) &
              t.fechaCreacion.between(
                periodo.fechaInicio,
                periodo.fechaFin,
              );
        },
        include: Calificacion.include(
          estudiante: Usuario.include(),
        ),
      ),
    );
  }

  Future<List<Calificacion>> actualizarCalificacionesEnLote(
    Session session, {
    required List<Calificacion> calificaciones,
  }) async {
    return await ejecutarOperacionOrm(
      session,
      (session) => Calificacion.db.update(
        session,
        calificaciones,
      ),
    );
  }
}
