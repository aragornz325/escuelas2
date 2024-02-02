import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmDocente extends ORM {
  Future<bool> crearRelacionesDocenteAsignatura(
    Session session, {
    required List<RelacionAsignaturaUsuario> relacionAsignaturaUsuario,
  }) async {
    ejecutarOperacionOrm(
      session,
      (session) => RelacionAsignaturaUsuario.db.insert(
        session,
        relacionAsignaturaUsuario,
      ),
    );
    return true;
  }

  
}
