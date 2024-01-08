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
    Session session,
    Periodo? periodo,
    int? idConceptoDeCalificacion,
  ) async =>
      ejecutarOperacionOrm(
        session,
        (session) => Calificacion.db.find(
          session,
          where: (t) {
            if (periodo != null && idConceptoDeCalificacion != null) {
              return t.fechaCreacion.between(
                    periodo.fechaInicio,
                    periodo.fechaFin,
                  ) &
                  t.idConcepto.equals(idConceptoDeCalificacion);
            }

            if (periodo != null) {
              return t.fechaCreacion.between(
                periodo.fechaInicio,
                periodo.fechaFin,
              );
            }

            if (idConceptoDeCalificacion != null) {
              return t.idConcepto.equals(idConceptoDeCalificacion);
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
}
