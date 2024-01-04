import 'package:escuelas_server/controller.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/servicio_curso.dart';
import 'package:serverpod/server.dart';

class CursoEndpoint extends Endpoint with Controller<ServicioCurso> {
  @override
  ServicioCurso get servicio => ServicioCurso();

  @override
  bool get requireLogin => false;


  /// La función "obtenerCursoPorId" recupera un curso por su ID usando una sesión y un ORM.
  Future<Curso> obtenerCursoPorId(
    Session session, {
    required int id,
  }) async {
    return servicio.obtenerCursoPorId(
      session,
      id: id,
    );
  }

  /// La función "obtenerCursos" recupera una lista de cursos utilizando un objeto de sesión.
  Future<List<Curso>> obtenerCursos(Session session) async {
    return servicio.obtenerCursos(session);
  }

  /// La función `crearCurso` crea un curso en una base de datos utilizando la sesión y el objeto del
  /// curso proporcionados.
  Future<Curso> crearCurso(
    Session session, {
    required Curso curso,
  }) async {
    return servicio.crearCurso(
      session,
      curso: curso,
    );
  }

  /// La función `actualizarCurso` actualiza un curso en una base de datos utilizando la sesión y el
  /// objeto del curso proporcionados.
  Future<Curso> actualizarCurso(
    Session session, {
    required Curso curso,
  }) async {
    return servicio.actualizarCurso(
      session,
      curso: curso,
    );
  }


  /// La función `eliminarCurso` elimina un curso de una base de datos utilizando una sesión y un ORM.
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
