import 'package:escuelas_server/orm.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class OrmCurso extends ORM {
  Future<Curso> obtenerCursoPorId(
    Session session, {
    required int id,
  }) async {
    final curso = await ejecutarOperacionOrm(
      session,
      (session) => Curso.db.findById(session, id),
    );
    if (curso == null) {
      throw Exception(
        'Curso no encontrado',
      );
    }
    return curso;
  }

  Future<List<Curso>> obtenerCursos(Session session) async {
    final cursos =await ejecutarOperacionOrm(
      session,
      (session) => Curso.db.find(session),
    );
    if (cursos.isEmpty) {
      throw Exception(
        'No hay cursos',
      );
    }
    return cursos;
  }

  Future<Curso> crearCurso(
    Session session, {
    required Curso curso,
  }) async {
    final cursoADb = await ejecutarOperacionOrm(
      session,
      (session) => Curso.db.insert(session, [curso]),
    );
    return cursoADb.first;
  }

  Future<Curso> actualizarCurso(
    Session session, {
    required Curso curso,
  }) async {
    final cursoADb = await ejecutarOperacionOrm(
      session,
      (session) => Curso.db.update(session, [curso]),
    );
    return cursoADb.first;
  }

  Future<void> eliminarCurso(
    Session session, {
    required int id,
  }) async {
    final curso = await obtenerCursoPorId(
      session,
      id: id,
    );
    await ejecutarOperacionOrm(
      session,
      (session) => Curso.db.delete(session, [curso]),
    );
  }
}
