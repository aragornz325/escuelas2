import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/servicio_rol.dart';
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
  Future<RolDeUsuario> obtenerRolPorId(
    Session session, {
    required int id,
  }) async {
    return await ejecutarOperacionControlador(
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
  Future<List<RolDeUsuario>> obtenerRoles(
    Session session,
  ) async {
    return await ejecutarOperacionControlador(
      'obtenerRoles',
      () => servicio.obtenerRoles(session),
    );
  }

  /// La función `crearRol` crea un rol de usuario utilizando una sesión y un servicio.
  /// args:
  ///   session (Session): El parámetro de sesión es de tipo Sesión. Se utiliza para representar la
  /// sesión actual o la conexión a una base de datos o servidor.
  ///  rol (RolDeUsuario): El parámetro "rol" es de tipo "RolDeUsuario" y es obligatorio.
  /// 
  Future<RolDeUsuario> crearRol(
    Session session, {
    required RolDeUsuario rol,
  }) async {
    return await ejecutarOperacionControlador(
        'crearRol',
        () => servicio.crearRol(
              session,
              rol: rol,
            ));
  }

  /// La función `actualizarRol` actualiza un rol de usuario utilizando una sesión y un servicio.
  /// args:
  ///   session (Session): El parámetro de sesión es de tipo Sesión. Se utiliza para representar la
  /// sesión actual o la conexión a una base de datos o servidor.
  /// rol (RolDeUsuario): El parámetro "rol" es de tipo "RolDeUsuario" y es obligatorio.
  Future<RolDeUsuario> actualizarRol(
    Session session, {
    required RolDeUsuario rol,
  }) async {
    return await ejecutarOperacionControlador(
        'actualizarRol',
        () => servicio.actualizarRol(
              session,
              rol: rol,
            ));
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
        'eliminarRol',
        () => servicio.eliminarRol(
              session,
              id: id,
            ));
  }
}
