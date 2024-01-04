import 'package:escuelas_server/servicio.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_usuario.dart';
import 'package:serverpod/serverpod.dart';

class ServicioUsuario extends Servicio {
  OrmUsuario get orm => OrmUsuario();

  Future<UsuarioPendiente> obtenerUsuariosPendientes(Session session) async {
    final result =
        await ejecutarOperacion(() => orm.obtenerUsuariosPendiente(session));
    return result!;
  }

  Future<UsuarioPendiente> enviarSoliciturRegistro(
    Session session, {
    required UsuarioPendiente usuarioPendiente,
  }) async {
    final ahora = DateTime.now();
    final result = await ejecutarOperacion(
      () => orm.crearUsuarioPendiente(
        session,
        usuarioPendiente: UsuarioPendiente(
            idUserInfo: usuarioPendiente.idUserInfo,
            nombre: usuarioPendiente.nombre,
            apellido: usuarioPendiente.apellido,
            dni: usuarioPendiente.dni,
            rolSolicitado: usuarioPendiente.rolSolicitado,
            aprobado: usuarioPendiente.aprobado,
            fechaCreacion: ahora,
            ultimaModificacion: ahora),
      ),
    );
    return result;
  }
}
