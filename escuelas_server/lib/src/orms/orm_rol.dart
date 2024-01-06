import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/server.dart';

class OrmRol extends ORM {
  /// La función `obtenerRolPorId` recupera un rol de usuario por su ID y lanza una excepción si no se
  /// encuentra el rol.
  ///
  /// Args:
  ///   session (Session): El parámetro de sesión es de tipo Sesión, que se utiliza para interactuar con
  /// la base de datos. Es necesario para ejecutar la operación de la base de datos.
  ///   id (int): El parámetro "id" es un número entero que representa el identificador único del rol
  /// que debe recuperarse.
  ///
  /// Returns:
  ///   un `Futuro<RolDeUsuario>`.
  Future<RolDeUsuario> obtenerRolPorId(
    Session session, {
    required int id,
  }) async {
    final rol = await ejecutarOperacionOrm(
      session,
      (session) => RolDeUsuario.db.findById(session, id),
    );
    if (rol == null) {
      throw Exception(
        'Rol no encontrado',
      );
    }
    return rol;
  }

  /// La función `obtenerRoles` recupera una lista de roles de usuario de una base de datos usando un
  /// ORM y lanza una excepción si no se encuentran roles.
  ///
  /// Args:
  ///   session (Session): El parámetro de sesión es de tipo Sesión, que probablemente sea un objeto que
  /// representa una sesión o conexión de base de datos. Se utiliza para interactuar con la base de
  /// datos y ejecutar consultas u operaciones.
  ///
  /// Returns:
  ///   un `Futuro` que se resuelve en una `Lista` de objetos `RolDeUsuario`.
  Future<List<RolDeUsuario>> obtenerRoles(
    Session session,
  ) async {
    final roles = await ejecutarOperacionOrm(
      session,
      (session) => RolDeUsuario.db.find(session),
    );
    if (roles.isEmpty) {
      throw Exception(
        'No hay roles',
      );
    }
    return roles;
  }

  /// La función `crearRol` crea un nuevo rol en la base de datos usando la sesión proporcionada y
  /// devuelve el rol creado.
  ///
  /// Args:
  ///   session (Session): El parámetro de sesión es un objeto que representa una sesión de base de
  /// datos. Se utiliza para realizar operaciones de bases de datos dentro del contexto de una sesión.
  ///   rol (RolDeUsuario): El parámetro "rol" es de tipo "RolDeUsuario" y es obligatorio.
  ///
  /// Returns:
  ///   un `Futuro<RolDeUsuario>`.
  Future<RolDeUsuario> crearRol(
    Session session, {
    required RolDeUsuario rol,
  }) async {
    return await ejecutarOperacionOrm(
      session,
      (session) => RolDeUsuario.db.insert(session, [rol]).then((_) => rol),
    );
  }

  /// La función `actualizarRol` actualiza un rol de usuario en una base de datos usando un ORM.
  ///
  /// Args:
  ///   session (Session): El parámetro de sesión es de tipo Sesión, que se utiliza para administrar la
  /// sesión de la base de datos para ejecutar operaciones de la base de datos.
  ///   rol (RolDeUsuario): El parámetro `rol` es de tipo `RolDeUsuario` y es obligatorio.
  ///
  /// Returns:
  ///   un `Futuro<RolDeUsuario>`.
  Future<RolDeUsuario> actualizarRol(
    Session session, {
    required RolDeUsuario rol,
  }) async {
    await obtenerRolPorId(
      session,
      id: rol.id!,
    );
    return await ejecutarOperacionOrm(
      session,
      (session) => RolDeUsuario.db.update(session, [rol]).then((_) => rol),
    );
  }

  /// La función `eliminarRol` elimina un rol de la base de datos usando la sesión proporcionada y
  /// devuelve el ID del rol eliminado.
  ///
  /// Args:
  ///   session (Session): El parámetro `session` es de tipo `Session` y representa la sesión de la base
  /// de datos que se utilizará para la operación.
  ///   id (int): El parámetro "id" es un número entero que representa el identificador único del rol que
  /// debe eliminarse.
  ///
  /// Returns:
  ///   un `Futuro<int>`.
  Future<int> eliminarRol(
    Session session, {
    required int id,
  }) async {
    final rol = await obtenerRolPorId(
      session,
      id: id,
    );
    return await ejecutarOperacionOrm(
      session,
      (session) => RolDeUsuario.db.delete(session, [rol]).then((_) => id),
    );
  }

  /// La función `asignarRolAUsuario` asigna un rol a un usuario en una base de datos mediante un ORM.
  ///
  /// Args:
  ///   session (Session): Un objeto de sesión utilizado para operaciones de bases de datos.
  ///   idUsuario (int): El ID del usuario al que se le va a asignar el rol.
  ///   idRol (int): La identificación del rol que desea asignar al usuario.
  ///
  /// Returns:
  ///   El método `asignarRolAUsuario` devuelve un `Futuro<String>`.
  Future<String> asignarRolAUsuario(
    Session session, {
    required int idUsuario,
    required int idRol,
  }) async {
    final ahora = DateTime.now().toUtc();
    final usuario = await ejecutarOperacionOrm(
      session,
      (session) => Usuario.db.findById(session, idUsuario),
    );
    if (usuario == null) {
      throw Exception(
        'Usuario no encontrado',
      );
    }
    final rol = await ejecutarOperacionOrm(
      session,
      (session) => RolDeUsuario.db.findById(session, idRol),
    );
    if (rol == null) {
      throw Exception(
        'Rol no encontrado',
      );
    }
    await ejecutarOperacionOrm(
      session,
      (session) => RelacionUsuarioRol.db.insert(
        session,
        [
          RelacionUsuarioRol(
            usuarioId: idUsuario,
            rolId: idRol,
          ),
        ],
      ),
    );
    return 'Rol $rol asignado a usuario $usuario';
  }
}
