import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmUsuario extends ORM {
  Future<Usuario> crearUsuario(
    Session session, {
    required Usuario nuevoUsuario,
  }) async {
    return await ejecutarOperacionOrm(
      session,
      (session) async => await Usuario.db.insertRow(session, nuevoUsuario),
    );
  }

  Future<Usuario?> buscarUsuario(
    Session session, {
    int? idUserInfo,
  }) async {
    return await ejecutarOperacionOrm(
      session,
      (session) async => await Usuario.db.findFirstRow(
        session,
        where: (t) {
          if (idUserInfo != null) {
            return t.idUserInfo.equals(idUserInfo);
          }
          return t.id.notEquals(null);
        },
      ),
    );
  }

  Future<Usuario> actualizarUsuario(
    Session session, {
    required Usuario usuario,
  }) async {
    return await ejecutarOperacionOrm(
      session,
      (session) async => await Usuario.db.updateRow(session, usuario),
    );
  }
}
