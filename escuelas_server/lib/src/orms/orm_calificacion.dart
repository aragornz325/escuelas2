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
    int? mes,
    int? anio,
    List<int>? idComisiones,
    List<int>? idEstudiantes,
  }) async {
    final ahora = DateTime.now();
    return ejecutarOperacionOrm(
      session,
      (session) => Calificacion.db.find(
        session,
        where: (t) {
          final expresionPeriodo = periodo != null
              ? t.fechaCreacion.between(
                  periodo.fechaInicio,
                  periodo.fechaFin,
                )
              : t.id.notEquals(null);
          final expresionFecha = (mes != null || anio != null)
              ? t.fechaCreacion.between(
                  DateTime(
                    anio ?? ahora.year,
                    mes ?? ahora.month,
                    1,
                  ),
                  DateTime(
                    (mes != null)
                        ? ((anio != null) ? (anio + 1) : (ahora.year + 1))
                        : anio ?? ahora.year,
                    (mes != null)
                        ? (mes + 1)
                        : (anio != null)
                            ? 1
                            : (ahora.month + 1),
                    1,
                  ),
                )
              : t.id.notEquals(null);
          final expresionComisiones =
              (idComisiones != null && idComisiones.isNotEmpty)
                  ? t.idComision.inSet(idComisiones.toSet())
                  : t.id.notEquals(null);
          final expresionEstudiantes =
              (idEstudiantes != null && idEstudiantes.isNotEmpty)
                  ? t.estudianteId.inSet(idEstudiantes.toSet())
                  : t.id.notEquals(null);

          return expresionPeriodo &
              expresionFecha &
              expresionComisiones &
              expresionEstudiantes & t.estudiante.fechaEliminacion.equals(null);
        },
      ),
    );
  }

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
          return t.asignaturaId.equals(idAsignatura) &
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
