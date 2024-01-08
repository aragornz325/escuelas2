import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmConceptoCalificacion extends ORM {
  Future<ConceptoCalificacion> crearConceptoDeCalificacion(
    Session session, {
    required ConceptoCalificacion conceptoCalificacion,
  }) async =>
      ejecutarOperacionOrm(
        session,
        (session) => ConceptoCalificacion.db.insertRow(
          session,
          conceptoCalificacion,
        ),
      );

  Future<ConceptoCalificacion> actualizarConceptoDeCalificacion(
    Session session, {
    required ConceptoCalificacion conceptoCalificacion,
  }) async =>
      ejecutarOperacionOrm(
        session,
        (session) => ConceptoCalificacion.db.updateRow(
          session,
          conceptoCalificacion,
        ),
      );

  Future<ConceptoCalificacion> obtenerConceptoDeCalificacionPorId(
    Session session, {
    required int id,
  }) async {
    final concepto = await ejecutarOperacionOrm(
      session,
      (session) => ConceptoCalificacion.db.findById(
        session,
        id,
      ),
    );

    if (concepto == null) {
      throw Exception(
        'Concepto de calificacion no encontradp',
      );
    }

    return concepto;
  }

  Future<List<ConceptoCalificacion>> obtenerConceptosDeCalificacion(
    Session session,
  ) async {
    final conceptos = await ejecutarOperacionOrm(
      session,
      (session) => ConceptoCalificacion.db.find(
        session,
        where: (t) => t.fechaEliminacion.equals(null),
      ),
    );
    return conceptos;
  }

  Future<int> eliminarConceptoDeCalificacion(
    Session session, {
    required int id,
  }) async {
    final concepto = await obtenerConceptoDeCalificacionPorId(
      session,
      id: id,
    );

    final idConceptoEliminado = await ejecutarOperacionOrm(
      session,
      (session) => ConceptoCalificacion.db.deleteRow(
        session,
        concepto,
      ),
    );

    return idConceptoEliminado;
  }
}
