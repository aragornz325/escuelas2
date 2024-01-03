import 'package:escuelas_server/servicio.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_curso.dart';
import 'package:serverpod/serverpod.dart';

class ServicioCurso extends Servicio {
  OrmCurso get orm => OrmCurso();

  Future<Curso> obtenerCursoPorId(
    Session session, {
    required int id,
  }) async {
    final curso = await ejecutarOperacion(() => orm.obtenerCursoPorId(
          session,
          id: id,
        ));
    return curso;
  }

  Future<List<Curso>> obtenerCursos(Session session) async {
    final cursos = await ejecutarOperacion(() => orm.obtenerCursos(session));
    return cursos;
  }

  Future<Curso> crearCurso(
    Session session, {
    required Curso curso,
  }) async {
    final cursoADb = await ejecutarOperacion(() => orm.crearCurso(
          session,
          curso: curso,
        ));
    return cursoADb;
  }

  Future<Curso> actualizarCurso(
    Session session, {
    required Curso curso,
  }) async {
    final cursoADb = await ejecutarOperacion(() => orm.actualizarCurso(
          session,
          curso: curso,
        ));
    return cursoADb;
  }

  Future<void> eliminarCurso(
    Session session, {
    required int id,
  }) async {
    await ejecutarOperacion(() => orm.eliminarCurso(
          session,
          id: id,
        ));
  }
}
