import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmAsignaturaSolicitada extends ORM {
  Future<List<AsignaturaSolicitada>> crearAsignaturasSolicitadas(
    Session session, {
    required List<AsignaturaSolicitada> asignaturasSolicitadas,
  }) async =>
      ejecutarOperacionOrm(
        session,
        (session) => AsignaturaSolicitada.db.insert(
          session,
          asignaturasSolicitadas,
        ),
      );
}
