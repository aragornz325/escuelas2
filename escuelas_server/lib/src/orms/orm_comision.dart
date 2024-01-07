import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmComision extends ORM {
  Future<List<ComisionDeCurso>> obtenerComisiones(Session session) async =>
      ejecutarOperacionOrm(
        session,
        (session) => ComisionDeCurso.db.find(session),
      );
}
