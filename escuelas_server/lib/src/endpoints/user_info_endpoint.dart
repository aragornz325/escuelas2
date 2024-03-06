import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/servicios/servicio_user_info.dart';
import 'package:serverpod/serverpod.dart';

class UserInfoEndpoint extends Endpoint with Controller<ServicioUserInfo> {
  @override
  ServicioUserInfo get servicio => ServicioUserInfo();

  Future<bool> registrarUserInfo(
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
        () => servicio.registrarUsuario(
          session,
          nombre: nombre,
          apellido: apellido,
          email: email,
          password: password,
          dni: dni,
        ),
      );
}
