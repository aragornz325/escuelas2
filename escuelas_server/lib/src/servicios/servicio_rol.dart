import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_asignatura.dart';
import 'package:escuelas_server/src/orms/orm_curso.dart';
import 'package:escuelas_server/src/orms/orm_rol.dart';
import 'package:escuelas_server/src/orms/orm_usuario.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:escuelas_server/src/utils/listado_alfabetico.dart';
import 'package:serverpod/server.dart';

class ServicioRol extends Servicio<OrmRol> {
  @override
  OrmRol get orm => OrmRol();

  final OrmUsuario _ormUsuario = OrmUsuario();

  final OrmAsignatura _ormAsignatura = OrmAsignatura();

  final OrmCurso _ormCurso = OrmCurso();

  /// La función "obtenerRolPorId" recupera un rol por su ID usando un ORM y lo devuelve como Future.
  ///
  /// Args:
  ///   session (Session):
  ///   id (int): El parámetro "id" es un número entero que representa el identificador único de un
  /// rol.
  ///
  /// Returns:
  ///   un `Futuro<RolDeUsuario>`.
  Future<RolDeUsuario> obtenerRolPorId(
    Session session, {
    required int id,
    OrdenarPor ordenarUsuariosPor = OrdenarPor.apellido,
  }) async {
    final rol = await ejecutarOperacion(() => orm.obtenerRolPorId(
          session,
          id: id,
          ordenarUsuariosPor: ordenarUsuariosPor,
        ));
    return rol;
  }

  Future<List<UsuariosListados>> obtenerUsuariosPorRolSorteados(
    Session session, {
    required int idRol,
    OrdenarPor ordenarUsuariosPor = OrdenarPor.apellido,
  }) async {
    final usuarios = await ejecutarOperacion(
      () => _ormUsuario.obtenerUsuarios(session),
    );

    final usuariosListados = <UsuariosListados>[];

    switch (ordenarUsuariosPor) {
      case OrdenarPor.apellido:
        for (var letra in listaAlfabetica) {
          final usuariosLetra = usuarios
              .where((usuario) => usuario.apellido.startsWith(letra))
              .toList();

          usuariosListados.add(
            UsuariosListados(
              etiquetaDelIndexListado: letra,
              usuarios: usuariosLetra,
            ),
          );
        }
      case OrdenarPor.curso:
        final cursos = await ejecutarOperacion(
          () => _ormCurso.obtenerCursos(session),
        );

        for (var curso in cursos) {
          final usuariosDelCurso = usuarios
              .where((usuario) =>
                  usuario.asignaturas?.any((cursoUsuario) =>
                      cursoUsuario.asignaturaId == curso.id) ??
                  false)
              .toList();

          usuariosListados.add(
            UsuariosListados(
              etiquetaDelIndexListado: curso.nombre,
              usuarios: usuariosDelCurso,
            ),
          );
        }

      case OrdenarPor.asignatura:
        final asignaturas = await ejecutarOperacion(
          () => _ormAsignatura.obtenerAsignaturas(session),
        );

        for (var asignatura in asignaturas) {
          final usuariosAsignatura = usuarios
              .where((usuario) =>
                  usuario.asignaturas?.any((asignaturaUsuario) =>
                      asignaturaUsuario.asignaturaId == asignatura.id) ??
                  false)
              .toList();

          usuariosListados.add(
            UsuariosListados(
              etiquetaDelIndexListado: asignatura.nombre,
              usuarios: usuariosAsignatura,
            ),
          );
        }
    }

    return usuariosListados;
  }

  /// La función "obtenerRoles" recupera una lista de roles de usuario utilizando un objeto de sesión.
  ///
  /// Args:
  ///   session (Session):
  ///
  /// Returns:
  ///   un objeto `Futuro` que se resuelve en una `List<RolDeUsuario>`.
  Future<List<RolDeUsuario>> obtenerRoles(Session session) async {
    final roles = await ejecutarOperacion(() => orm.obtenerRoles(session));
    return roles;
  }

  /// La función crea una función en la base de datos utilizando la sesión proporcionada y el objeto de
  /// función.
  ///
  /// Args:
  ///   session (Session):
  ///   rol (RolDeUsuario): El parámetro "rol" es de tipo "RolDeUsuario" y es obligatorio.
  ///
  /// Returns:
  ///   un `Futuro<RolDeUsuario>`.
  Future<RolDeUsuario> crearRol(
    Session session, {
    required RolDeUsuario rol,
  }) async {
    final rolADb = await ejecutarOperacion(() => orm.crearRol(
          session,
          rol: rol,
        ));
    return rolADb;
  }

  /// La función `actualizarRol` actualiza el rol de un usuario en una base de datos utilizando la
  /// sesión y el rol proporcionados.
  ///
  /// Args:
  ///   session (Session):
  ///   rol (RolDeUsuario): El parámetro "rol" es de tipo "RolDeUsuario" y es obligatorio.
  ///
  /// Returns:
  ///   un `Futuro<RolDeUsuario>`.
  Future<RolDeUsuario> actualizarRol(
    Session session, {
    required RolDeUsuario rol,
  }) async {
    final rolADb = await ejecutarOperacion(() => orm.actualizarRol(
          session,
          rol: rol,
        ));
    return rolADb;
  }

  /// La función `eliminarRol` es una función de Dart que toma un objeto `Session` y un parámetro `id`, y
  /// devuelve un `Future<int>`.
  ///
  /// Args:
  ///   session (Session):
  ///   id (int): El parámetro "id" es un número entero que representa el identificador único del rol que
  /// debe eliminarse.
  ///
  /// Returns:
  ///   un `Futuro<int>`.
  Future<int> eliminarRol(
    Session session, {
    required int id,
  }) async {
    return await ejecutarOperacion(() => orm.eliminarRol(
          session,
          id: id,
        ));
  }

  /// La función `asignarRolAUsuario` asigna un rol a un usuario en una sesión.
  ///
  /// Args:
  ///   session (Session):
  ///   idUsuario (int): El parámetro "idUsuario" es un número entero que representa el ID del usuario
  /// al que se le asignará el rol.
  ///   idRol (int): El parámetro "idRol" es un número entero que representa el ID del rol que debe
  /// asignarse a un usuario.
  ///
  /// Returns:
  ///   El método devuelve un `Future<String>`.
  Future<String> asignarRolAUsuario(
    Session session, {
    required int idUsuario,
    required int idRol,
  }) async {
    final rol = await ejecutarOperacion(() => orm.asignarRolAUsuario(
          session,
          idUsuario: idUsuario,
          idRol: idRol,
        ));
    return rol;
  }
}
