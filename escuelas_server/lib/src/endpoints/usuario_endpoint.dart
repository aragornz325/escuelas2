import 'package:escuelas_server/controller.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/servicio_usuario.dart';
import 'package:serverpod/serverpod.dart';

class UsuarioEndpoint extends Endpoint with Controller {
  ServicioUsuario get servicio => ServicioUsuario();

  Future<UsuarioPendiente> obtenerUsuariosPendientes(Session session) async {
    return await ejecutarOperacionControlador('obtenerUsuariosPendientes',
        () => servicio.obtenerUsuariosPendientes(session));
  }

  Future<UsuarioPendiente> enviarSoliciturRegistro(
    Session session, {
    required UsuarioPendiente usuarioPendiente,
  }) async {
    return await ejecutarOperacionControlador(
        'enviarSoliciturRegistro',
        () => servicio.enviarSoliciturRegistro(session,
            usuarioPendiente: usuarioPendiente));
  }
}
