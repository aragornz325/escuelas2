import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/servicio_usuario.dart';
import 'package:serverpod/serverpod.dart';

class UsuarioEndpoint extends Endpoint with Controller {
  @override
  ServicioUsuario get servicio => ServicioUsuario();

  /// La función "obtenerUsuarioPendiente" devuelve un objeto Futuro que recupera usuario pendiente
  /// usando una sesión.
  ///
  /// Args:
  ///   session (Session): El parámetro de sesión es un objeto que representa la sesión del usuario
  /// actual. Se utiliza para autenticar y autorizar al usuario que realiza la solicitud.
  Future<UsuarioPendiente?> obtenerUsuarioPendiente(
    Session session, {
    required int idUserInfo,
  }) async =>
      ejecutarOperacionControlador(
        'obtenerUsuarioPendiente',
        () => servicio.obtenerUsuarioPendiente(
          session,
          idUserInfo: idUserInfo,
        ),
      );

  /// La función `enviarSoliciturRegistro` envía una solicitud de registro para un usuario pendiente.
  ///
  /// Args:
  ///   session (Session): Un objeto de sesión que representa la sesión del usuario actual. Es necesario
  /// para fines de autenticación y autorización.
  ///   usuarioPendiente (UsuarioPendiente): El parámetro "UserPending" es de tipo "UserPending" y es
  /// obligatorio.
  Future<UsuarioPendiente> enviarSoliciturRegistro(
    Session session, {
    required UsuarioPendiente usuarioPendiente,
  }) async =>
      ejecutarOperacionControlador(
        'enviarSoliciturRegistro',
        () => servicio.enviarSolicitudRegistro(
          session,
          usuarioPendiente: usuarioPendiente,
        ),
      );
}
