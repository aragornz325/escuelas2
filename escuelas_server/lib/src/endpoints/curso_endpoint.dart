import 'package:escuelas_server/controller.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/servicio_curso.dart';
import 'package:serverpod/server.dart';

class CursoEndpoint extends Endpoint with Controller<ServicioCurso> {
  @override
  ServicioCurso get servicio => ServicioCurso();

  @override
  bool get requireLogin => false;

  Future<Curso> obtenerCursoPorId(
    Session session, {
    required int id,
  }) async {
    return servicio.obtenerCursoPorId(
      session,
      id: id,
    );
  }

  Future<List<Curso>> obtenerCursos(Session session) async {
    return servicio.obtenerCursos(session);
  }

  Future<Curso> crearCurso(
    Session session, {
    required Curso curso,
  }) async {
    return servicio.crearCurso(
      session,
      curso: curso,
    );
  }

  Future<Curso> actualizarCurso(
    Session session, {
    required Curso curso,
  }) async {
    return servicio.actualizarCurso(
      session,
      curso: curso,
    );
  }

  Future<void> eliminarCurso(
    Session session, {
    required int id,
  }) async {
    return servicio.eliminarCurso(
      session,
      id: id,
    );
  }
}
