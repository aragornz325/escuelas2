import 'package:escuelas_commons/escuelas_commons.dart';
import 'package:escuelas_server/src/controller.dart';
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
  }) async =>
      ejecutarOperacionControlador(
        session,
        'obtenerCursoPorId',
        () => servicio.obtenerCursoPorId(
          session,
          id: id,
        ),permisoRequerido: PermisoDeCurso.verCurso,
      );

  /// La función "obtenerCursos" recupera una lista de cursos utilizando un objeto de sesión.
  Future<List<Curso>> obtenerCursos(Session session) async =>
      ejecutarOperacionControlador(
        session,
        'obtenerCursos',
        () => servicio.obtenerCursos(
          session,
        ),
        permisoRequerido: PermisoDeCurso.verCurso,
      );

  /// La función `crearCurso` crea un curso en una base de datos utilizando la sesión y el objeto del
  /// curso proporcionados.
  Future<Curso> crearCurso(
    Session session, {
    required Curso curso,
  }) async =>
      ejecutarOperacionControlador(
        session,
        'crearCurso',
        () => servicio.crearCurso(
          session,
          curso: curso,
        ),
        permisoRequerido: PermisoDeCurso.crearCurso,
      );

  /// La función `actualizarCurso` actualiza un curso en una base de datos utilizando la sesión y el
  /// objeto del curso proporcionados.
  Future<Curso> actualizarCurso(
    Session session, {
    required Curso curso,
  }) async =>
      ejecutarOperacionControlador(
        session,
        'actualizarCurso',
        () => servicio.actualizarCurso(
          session,
          curso: curso,
        ),
        permisoRequerido: PermisoDeCurso.editarCurso,
      );

  /// La función `eliminarCurso` elimina un curso de una base de datos utilizando una sesión y un ORM.
  Future<void> eliminarCurso(
    Session session, {
    required int id,
  }) async =>
      ejecutarOperacionControlador(
        session,
        'eliminarCurso',
        () => servicio.eliminarCurso(
          session,
          id: id,
        ),
        permisoRequerido: PermisoDeCurso.eliminarCurso,
      );

  /// La función "obtenerAsignaturasPorCurso" recupera una lista de materias de un curso determinado.
  ///
  /// Args:
  ///   session (Session): Un objeto de sesión que representa la sesión del usuario actual. Se utiliza
  /// para autenticar y autorizar las acciones del usuario.
  ///   idCurso (int): El parámetro "idCurso" es un número entero que representa el ID de un curso.
  ///
  /// Returns:
  ///   Se devuelve un objeto `Future<Curso>`.
  Future<Curso> obtenerAsignaturasPorCurso(
    Session session,
    int idCurso,
  ) async {
    return await ejecutarOperacionControlador(
      session,
      'obtenerAsignaturasPorCurso',
      () async {
        final respuesta = await servicio.obtenerAsignaturasPorCurso(
          session,
          idCurso: idCurso,
        );
        return respuesta;
      },
      permisoRequerido: PermisoDeCurso.verCurso,
    );
  }
}
