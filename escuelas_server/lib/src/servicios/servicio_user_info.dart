import 'package:escuelas_server/src/orms/orm_userInfo.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart';

class ServicioUserInfo extends Servicio<OrmUserInfo> {
  @override
  OrmUserInfo get orm => OrmUserInfo();

  /// Crea un user info con un nombre de usuario, correo electrónico y contraseña.
  Future<UserInfo?> crearUserInfo(
    Session session,
    String userName,
    String email,
    String password,
  ) async {
    try {
      final userInfo = await ejecutarOperacion(
        () => Emails.createUser(session, userName, email, password),
      );
      return userInfo;
    } catch (e) {
      return null;
    }
  }

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
    final userInfo =
        await ejecutarOperacion(() => orm.traerInformacionDeUsuario(
              session,
              idUserInfo: idUserInfo,
            ));
    return userInfo;
  }

  /// La función `actualizarUserInfo` actualiza un usuario con un objeto `UserInfo` usando una sesión y un ORM.
  /// Args:
  ///   session (Session): Un objeto de sesión utilizado para operaciones de bases de datos.
  ///  userInfo (UserInfo): Un objeto `UserInfo` que representa la información del usuario que se va a actualizar.
  /// Returns:
  /// a `Futuro<UserInfo>`.

  Future<UserInfo> actualizarUserInfo(
    Session session, {
    required UserInfo userInfo,
  }) async {
    final userInfoActualizado = await ejecutarOperacion(
      () => orm.actualizarUserInfo(
        session,
        userInfo,
      ),
    );
    return userInfoActualizado;
  }
}
