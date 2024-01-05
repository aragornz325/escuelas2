import 'package:escuelas_server/servicio.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_curso.dart';
import 'package:serverpod/serverpod.dart';

class ServicioCurso extends Servicio {
  @override
  OrmCurso get orm => OrmCurso();

  /// La función `obtenerCursoPorId` recupera un curso por su ID usando una sesión y un ORM.
  ///
  /// Args:
  ///   session (Session):
  ///   id (int): El parámetro "id" es un número entero que representa el identificador único del curso
  /// que desea recuperar.
  ///
  /// Returns:
  ///   a `Futuro<Curso>`.
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

  /// La función "obtenerCursos" recupera una lista de cursos utilizando un objeto de sesión.
  ///
  /// Args:
  ///   session (Session):
  ///
  /// Returns:
  ///   un objeto `Futuro` que se resuelve en una `Lista` de objetos `Curso`.
  Future<List<Curso>> obtenerCursos(Session session) async {
    final cursos = await ejecutarOperacion(() => orm.obtenerCursos(session));
    return cursos;
  }

  /// La función `crearCurso` crea un curso en una base de datos utilizando la sesión y el objeto del
  /// curso proporcionados.
  ///
  /// Args:
  ///   session (Session):
  ///   curso (Curso): El parámetro "curso" es de tipo "Curso" y es obligatorio.
  ///
  /// Returns:
  ///   a `Futuro<Curso>`.
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

  /// La función `actualizarCurso` actualiza un curso en una base de datos usando una sesión
  /// proporcionada y devuelve el curso actualizado.
  ///
  /// Args:
  ///   session (Session):
  ///   curso (Curso): El parámetro "curso" es de tipo "Curso" y es obligatorio.
  ///
  /// Returns:
  ///   a `Futuro<Curso>`.
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

  /// La función `eliminarCurso` elimina un curso utilizando la sesión proporcionada y el ID del curso.
  ///
  /// Args:
  ///   session (Session):
  ///   id (int): El parámetro "id" es un número entero que representa el identificador único del curso
  /// que debe eliminarse.
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
