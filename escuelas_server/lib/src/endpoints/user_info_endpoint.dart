import 'package:escuelas_commons/permisos/permisos.dart';
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

  Future<bool> cambiarPasswordPropia(
    Session session, {
    required String nuevaPassword,
  }) =>
      ejecutarOperacionControlador(
        session,
        'cambiarPasswordPropia',
        () => servicio.cambiarPasswordPropia(
          session,
          nuevaPassword: nuevaPassword,
        ),
      );

  /// `conRequerimientoDeCambioDePassword` indica si se le debe requerir al usuario
  /// un cambio de contraseña la próxima vez que inicie sesión.
  Future<bool> cambiarPasswordDeOtroUsuario(
    Session session, {
    required int idUsuario,
    required String nuevaPassword,
    required bool conRequerimientoDeCambioDePassword,
  }) =>
      ejecutarOperacionControlador(
        session,
        'cambiarPasswordDeOtroUsuario',
        () => servicio.cambiarPasswordDeOtroUsuario(
          session,
          idUsuario: idUsuario,
          nuevaPassword: nuevaPassword,
          conRequerimientoDeCambioDePassword: conRequerimientoDeCambioDePassword,
        ),
        permisoRequerido: PermisoDeUsuario.cambiarPasswordDeUsuarioDirectivo,
      );
}
