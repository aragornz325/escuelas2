import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmInstanciaDeEvaluacion extends ORM {
  Future<InstanciaDeEvaluacion> crearInstanciaDeEvaluacion(
    Session session, {
    required InstanciaDeEvaluacion instanciaDeEvaluacion,
  }) async =>
      ejecutarOperacionOrm(
        session,
        (session) => InstanciaDeEvaluacion.db.insertRow(
          session,
          instanciaDeEvaluacion,
        ),
      );
}
