import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/servicios/servicio_user_info.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart';

class UserInfoEndpoint extends Endpoint with Controller<ServicioUserInfo> {
  @override
  ServicioUserInfo get servicio => ServicioUserInfo();

  Future<UserInfo?> registrarUserInfo(
    Session session,
    String userName,
    String email,
    String password,
  ) =>
      ejecutarOperacionControlador(
        session,
        'crearUserInfo',
        () => servicio.crearUserInfo(
          session,
          userName,
          email,
          password,
        ),
      );
}
