import 'package:escuelas_server/src/generated/protocol.dart';

import 'package:escuelas_server/src/orms/orm_userInfo.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart';

class ServicioUserInfo extends Servicio<OrmUserInfo> {
  @override
  OrmUserInfo get orm => OrmUserInfo();

  /// La función `traerInformacionDeUsuario` recupera un usuario por su ID usando una sesión y un ORM.
  ///
  /// Args:
  ///  session (Session):
  /// idUserInfo (int): El parámetro "idUserInfo" es un número entero que representa el identificador único del usuario
  /// que desea recuperar.
  /// Returns:
  ///  a `Futuro<UserInfo>`.
  
  Future<UserInfo> traerInformacionDeUsuario(
    Session session, {
    required int idUserInfo,
  }) async {
    final userInfo = await ejecutarOperacion(() => orm.traerInformacionDeUsuario(
          session,
          idUserInfo: idUserInfo,
        ));
    return userInfo;
  }
}
