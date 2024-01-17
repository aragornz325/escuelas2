import 'package:escuelas_server/src/servicio.dart';
import 'package:rolemissions/rolemissions.dart';
import 'package:serverpod/server.dart';

class ServicioRol extends Servicio {
  /// La función "obtenerRolPorId" recupera un rol por su ID usando un ORM y lo devuelve como Future.
  ///
  /// Args:
  ///   session (Session):
  ///   id (int): El parámetro "id" es un número entero que representa el identificador único de un
  /// rol.
  ///
  /// Returns:
  ///   un `Futuro<RolDeUsuario>`.
  Future<Role> obtenerRolPorId(
    Session session, {
    required int id,
  }) async =>
      ejecutarOperacion(
        () => Rolemissions.instance.getRoleById(
          id,
        ),
      );

  /// La función "obtenerRoles" recupera una lista de roles de usuario utilizando un objeto de sesión.
  ///
  /// Args:
  ///   session (Session):
  ///
  /// Returns:
  ///   un objeto `Futuro` que se resuelve en una `List<RolDeUsuario>`.
  Future<List<Role>> obtenerRoles(Session session) async => ejecutarOperacion(
        () => Rolemissions.instance.getRoles(),
      );

  /// La función crea una función en la base de datos utilizando la sesión proporcionada y el objeto de
  /// función.
  ///
  /// Args:
  ///   session (Session):
  ///   rol (RolDeUsuario): El parámetro "rol" es de tipo "RolDeUsuario" y es obligatorio.
  ///
  /// Returns:
  ///   un `Futuro<RolDeUsuario>`.
  Future<Role> crearRol(
    Session session, {
    required String name,
    required String permisos,
  }) async =>
      ejecutarOperacion(
        () => Rolemissions.instance.createRole(
          name: name,
          permissions: permisos,
        ),
      );

  /// La función `actualizarRol` actualiza el rol de un usuario en una base de datos utilizando la
  /// sesión y el rol proporcionados.
  ///
  /// Args:
  ///   session (Session):
  ///   rol (RolDeUsuario): El parámetro "rol" es de tipo "RolDeUsuario" y es obligatorio.
  ///
  /// Returns:
  ///   un `Futuro<RolDeUsuario>`.
  Future<Role> actualizarRol(
    Session session, {
    required Role role,
  }) async =>
      ejecutarOperacion(
        () => Rolemissions.instance.updateRole(role),
      );

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
  }) async =>
      ejecutarOperacion(
        () => Rolemissions.instance.deleteRole(id),
      );

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
  Future<int> asignarRolAUsuario(
    Session session, {
    required int idUsuario,
    required int idRol,
  }) async =>
      ejecutarOperacion(
        () => Rolemissions.instance.asignRoleToUser(
          userId: idUsuario,
          roleId: idRol,
        ),
      );
}
