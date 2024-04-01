import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/servicios/servicio_user_info.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart';

class UserInfoEndpoint extends Endpoint with Controller<ServicioUserInfo> {
  @override
  ServicioUserInfo get servicio => ServicioUserInfo();

  Future<UserInfo> registrarUserInfo(
    Session session, {
    required String nombre,
    required String apellido,
    required String email,
    required String password,
    required String dni,
  }) =>
      ejecutarOperacionControlador(
        session,
        'registrarUserInfo',
        () => servicio.registrarUserInfo(
          session,
          nombre: nombre,
          apellido: apellido,
          email: email,
          password: password,
          dni: dni,
        ),
      );

  Future<bool> reiniciarPasswordDelUsuario(
    Session session, {
    required String antiguaPassword,
    required String nuevaPassword,
  }) =>
      ejecutarOperacionControlador(
        session,
        'reiniciarPasswordDelUsuario',
        () => servicio.reiniciarPasswordDelUsuario(
          session,
          antiguaPassword: antiguaPassword,
          nuevaPassword: nuevaPassword,
        ),
      );
}
