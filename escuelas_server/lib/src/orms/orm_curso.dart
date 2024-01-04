import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmCurso extends ORM {
  /// La función `obtenerCursoPorId` recupera un curso por su ID y lanza una excepción si no se
  /// encuentra el curso.
  ///
  /// Args:
  ///   session (Session): Un objeto de sesión utilizado para operaciones de bases de datos.
  ///   id (int): El parámetro `id` es un número entero que representa el identificador único del curso
  /// que queremos recuperar.
  ///
  /// Returns:
  ///   a `Futuro<Curso>`.
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

  /// La función "obtenerCursos" recupera una lista de cursos de una base de datos usando un ORM y lanza
  /// una excepción si no se encuentran cursos.
  ///
  /// Args:
  ///   session (Session): El parámetro de sesión es un objeto que representa una sesión de base de
  /// datos. Se utiliza para realizar operaciones de bases de datos, como consultar y guardar datos.
  ///
  /// Returns:
  ///   El método `obtenerCursos` devuelve un `Futuro` que se resuelve en una `Lista` de objetos `Curso`.
  Future<List<Curso>> obtenerCursos(Session session) async {
    final cursos = await ejecutarOperacionOrm(
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

  /// La función `crearCurso` crea un nuevo curso en una base de datos usando un ORM.
  ///
  /// Args:
  ///   session (Session): El parámetro "sesión" es de tipo "Sesión" y representa una sesión de base de
  /// datos. Se utiliza para realizar operaciones de base de datos dentro de la función.
  ///   curso (Curso): El parámetro "curso" es de tipo "Curso" y es obligatorio.
  ///
  /// Returns:
  ///   a `Futuro<Curso>`.
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

  /// La función `actualizarCurso` actualiza un curso en una base de datos usando un ORM.
  ///
  /// Args:
  ///   session (Session): El parámetro de sesión es de tipo Sesión, que se utiliza para administrar la
  /// sesión de la base de datos para ejecutar operaciones de la base de datos.
  ///   curso (Curso): El parámetro "curso" es de tipo "Curso" y es obligatorio.
  ///
  /// Returns:
  ///   a `Futuro<Curso>`.
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

  /// La función `eliminarCurso` elimina un curso de la base de datos utilizando la sesión proporcionada
  /// y el ID del curso.
  ///
  /// Args:
  ///   session (Session): El parámetro de sesión es de tipo Sesión y representa la sesión actual de la
  /// base de datos. Se utiliza para realizar operaciones de base de datos dentro de la sesión.
  ///   id (int): El parámetro "id" es un número entero que representa el identificador único del curso
  /// que debe eliminarse.
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
