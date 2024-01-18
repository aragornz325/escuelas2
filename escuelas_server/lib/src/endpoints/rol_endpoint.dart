import 'package:escuelas_commons/escuelas_commons.dart';
import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/servicios/servicio_rol.dart';
import 'package:rolemissions/rolemissions.dart';
import 'package:serverpod/serverpod.dart';

class RolEndpoint extends Endpoint with Controller<ServicioRol> {
  @override
  ServicioRol get servicio => ServicioRol();

  /// La función `obtenerRolPorId` recupera un rol de usuario por su ID usando una sesión y un servicio.
  ///
  /// Args:
  ///   session (Session): El parámetro de sesión es de tipo Sesión. Se utiliza para representar la
  /// sesión actual o la conexión a una base de datos o servidor.
  ///   id (int): El parámetro "id" es un número entero que representa el identificador único del rol.
  ///
  /// Returns:
  ///   un `Futuro<RolDeUsuario>`.
  Future<Role> obtenerRolPorId(
    Session session, {
    required int id,
  }) async {
    return await ejecutarOperacionControlador(
      session,
      'obtenerRolPorId',
      () => servicio.obtenerRolPorId(
        session,
        id: id,
      ),
    );
  }

  /// La función `obtenerRoles` recupera una lista de roles de usuario utilizando una sesión y un
  /// servicio.
  ///  args:
  ///  session (Session): El parámetro de sesión es de tipo Sesión. Se utiliza para representar la
  /// sesión actual o la conexión a una base de datos o servidor.
  Future<List<Role>> obtenerRoles(
    Session session,
  ) async {
    return await ejecutarOperacionControlador(
      session,
      'obtenerRoles',
      () => servicio.obtenerRoles(session),
      permisoRequerido: PermisoDeAsistencia.verAsistencia,
    );
  }

  /// La función `crearRol` crea un rol de usuario utilizando una sesión y un servicio.
  /// args:
  ///   session (Session): El parámetro de sesión es de tipo Sesión. Se utiliza para representar la
  /// sesión actual o la conexión a una base de datos o servidor.
  ///  rol (RolDeUsuario): El parámetro "rol" es de tipo "RolDeUsuario" y es obligatorio.
  ///
  Future<Role> crearRol(
    Session session, {
    required String name,
    required String permisos,
  }) async {
    return await ejecutarOperacionControlador(
      session,
      'crearRol',
      () => servicio.crearRol(
        session,
        name: name,
        permisos: permisos,
      ),
    );
  }

  /// La función `actualizarRol` actualiza un rol de usuario utilizando una sesión y un servicio.
  /// args:
  ///   session (Session): El parámetro de sesión es de tipo Sesión. Se utiliza para representar la
  /// sesión actual o la conexión a una base de datos o servidor.
  /// rol (RolDeUsuario): El parámetro "rol" es de tipo "RolDeUsuario" y es obligatorio.
  Future<Role> actualizarRol(
    Session session, {
    required Role rol,
  }) async {
    return await ejecutarOperacionControlador(
      session,
      'actualizarRol',
      () => servicio.actualizarRol(
        session,
        role: rol,
      ),
    );
  }

  /// La función `eliminarRol` elimina un rol de usuario utilizando una sesión y un servicio.
  /// args:
  ///  session (Session): El parámetro de sesión es de tipo Sesión. Se utiliza para representar la
  /// sesión actual o la conexión a una base de datos o servidor.
  /// id (int): El parámetro "id" es un número entero que representa el identificador único del rol.
  ///
  Future<void> eliminarRol(
    Session session, {
    required int id,
  }) async {
    return await ejecutarOperacionControlador(
      session,
      'eliminarRol',
      () => servicio.eliminarRol(
        session,
        id: id,
      ),
    );
  }
}
