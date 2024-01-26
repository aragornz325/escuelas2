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
}
