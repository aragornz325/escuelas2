import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart';

class OrmUserInfo extends ORM {
  Future<UserInfo> traerInformacionDeUsuario(Session session,
      {required int idUserInfo}) async {
    final userInfo = await ejecutarOperacionOrm(
      session,
      (session) => UserInfo.db.findById(session, idUserInfo),
    );
    if (userInfo == null) {
      throw ExcepcionCustom(
          titulo: 'no se encontro',
          mensaje: 'no se encontro el usuario solicitado',
          tipoDeError: TipoExcepcion.noEncontrado,
          codigoError: 404);
    }
    return userInfo;
  }

  Future<String?> traerEmailDeUsuarioConUseridentifier(
    Session session, {
    required String userIdentifier,
  }) async {
    final userInfo = await ejecutarOperacionOrm(
      session,
      (session) => UserInfo.db.find(
        session,
        where: (t) => t.userIdentifier.equals(userIdentifier),
      ),
    );
    if (userInfo.isEmpty) {
      throw ExcepcionCustom(
        titulo: 'no se encontro',
        mensaje: 'no se encontro el usuario solicitado',
        tipoDeError: TipoExcepcion.noEncontrado,
        codigoError: 404,
      );
    }
    return userInfo.first.email;
  }

  Future<UserInfo> actualizarUserInfo(
      Session session, UserInfo userInfo) async {
    final userInfoActualizado = await ejecutarOperacionOrm(
      session,
      (session) => UserInfo.db.update(
        session,
        [userInfo],
      ),
    );

    if (userInfoActualizado.isEmpty) {
      throw ExcepcionCustom(
        titulo: 'no se actualizo',
        mensaje: 'no se actualizo el usuario solicitado',
        tipoDeError: TipoExcepcion.desconocido,
        codigoError: 560,
      );
    }
    return userInfoActualizado.first;
  }
}
