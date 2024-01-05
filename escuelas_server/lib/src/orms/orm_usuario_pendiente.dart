import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmUsuarioPendiente extends ORM {
  /// La función `crearUsuarioPendiente` crea un nuevo usuario pendiente en una base de datos y devuelve
  /// el usuario insertado.
  ///
  /// Args:
  ///   session (Session): El parámetro de sesión es de tipo Sesión  y es obligatorio.
  ///   usuarioPendiente (UsuarioPendiente): El parámetro "UserPending" es de tipo "UserPending" y es
  /// obligatorio.
  ///
  /// Returns:
  ///   a `Future<UsuarioPendiente>`.
  Future<UsuarioPendiente> crearUsuarioPendiente(
    Session session, {
    required UsuarioPendiente usuarioPendiente,
  }) async {
    return await UsuarioPendiente.db.insert(session, [usuarioPendiente]).then(
      (rows) {
        return rows.first;
      },
    );
  }

  /// La función obtiene el primer usuario pendiente de la base de datos y lanza una excepción si no hay
  /// usuarios pendientes.
  ///
  /// Args:
  ///   session (Session): Un objeto de sesión que representa la sesión del usuario actual.
  ///
  /// Returns:
  ///   La función `obtenerUsuariosPendiente` devuelve un `Futuro` que se resuelve en una instancia de
  /// `UsuarioPendiente` o `null`.
  Future<UsuarioPendiente?> obtenerUsuariosPendiente(
    Session session,
  ) async {
    final usuarios = await UsuarioPendiente.db.find(
      session,
      where: (t) => t.aprobado.equals(false),
    );

    if (usuarios.isEmpty) {
      throw Exception('No hay usuarios pendientes');
    }
    return usuarios.first;
  }
}
