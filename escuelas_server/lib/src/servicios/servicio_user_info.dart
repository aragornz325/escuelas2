import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_userInfo.dart';
import 'package:escuelas_server/src/orms/orm_usuario.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart';

class ServicioUserInfo extends Servicio<OrmUserInfo> {
  @override
  OrmUserInfo get orm => OrmUserInfo();

  final _ormUsuario = OrmUsuario();

  Future<UserInfo> registrarUserInfo(
    Session session, {
    required String nombre,
    required String apellido,
    required String email,
    required String password,
    required String dni,
  }) async =>
      await ejecutarOperacion(
        () async {
          var userInfoConElMismoMail =
              await Users.findUserByEmail(session, email);

          if (userInfoConElMismoMail != null) {
            throw ExcepcionCustom(
                tipoDeError: TipoExcepcion.registerDuplicatedEmail);
          }

          var userInfoConElMismoDNI =
              await Users.findUserByIdentifier(session, dni);

          if (userInfoConElMismoDNI != null) {
            throw ExcepcionCustom(
                tipoDeError: TipoExcepcion.registerDuplicatedIdNumber);
          }

          final userInfo = await crearUserInfo(
            session,
            userName: '$nombre;$apellido',
            email: email,
            password: password,
            dni: dni,
          );

          if (userInfo == null) {
            throw ExcepcionCustom(tipoDeError: TipoExcepcion.desconocido);
          }

          final user = userInfo..userIdentifier = dni;

          return await actualizarUserInfo(session, userInfo: user);
        },
      );

  /// Crea un user info con un nombre de usuario, correo electrónico y contraseña.
  Future<UserInfo?> crearUserInfo(
    Session session, {
    required String userName,
    required String email,
    required String password,
    required String dni,
  }) async {
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

  Future<bool> cambiarPasswordDelUsuario(
    Session session, {
    required String nuevaPassword,
  }) async {
    final idUsuario = await obtenerIdDeUsuarioLogueado(session);

    return await _cambiarPasswordDeUsuario(session, idUsuario: idUsuario, nuevaPassword: nuevaPassword);
  }

  Future<bool> cambiarPasswordDeUsuarioDirectivo(
    Session session, {
    required int idUsuario,
    required String nuevaPassword,
  }) async {
    return await _cambiarPasswordDeUsuario(session, idUsuario: idUsuario, nuevaPassword: nuevaPassword);
  }

  Future<bool> _cambiarPasswordDeUsuario(
    Session session, {
    required int idUsuario,
    required String nuevaPassword,
  }) async {
    var auth = await EmailAuth.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(idUsuario),
    );
    if (auth == null) {
      return false;
    }

    // Update password
    auth.hash = Emails.generatePasswordHash(nuevaPassword, auth.email);
    await EmailAuth.db.updateRow(session, auth);

    return true;
  }
}
