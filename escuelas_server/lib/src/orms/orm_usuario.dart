import 'package:escuelas_server/orm.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class OrmUsuario extends ORM {
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

  Future<UsuarioPendiente?> obtenerUsuariosPendiente(
    Session session,
  ) async {
    final usuarios = await UsuarioPendiente.db
        .find(session, where: (t) => t.aprobado.equals(false));

    if (usuarios.isEmpty) {
      throw Exception('No hay usuarios pendientes');
    }
    return usuarios.first;
  }
}
