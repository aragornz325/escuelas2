import 'package:escuelas_server/src/generated/protocol.dart';

import 'package:escuelas_server/src/orms/orm_direccionesDeEmail.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:escuelas_server/src/servicios/servicio_user_info.dart';
import 'package:serverpod/serverpod.dart';

class ServicioDireccionDeMail extends Servicio<OrmDireccionesdeEmail> {
  @override
  OrmDireccionesdeEmail get orm => OrmDireccionesdeEmail();
  ServicioUserInfo get servicioUserInfo => ServicioUserInfo();

  Future<DireccionDeEmail> crearDireccionDeEmail(
    Session session, {
    required int idUserInfo,
    required int idUsuario,
  }) async {
    final informacionDeUssuario = await servicioUserInfo
        .traerInformacionDeUsuario(session, idUserInfo: idUserInfo);

    final ahora = DateTime.now();
    final direccionDeEmail = DireccionDeEmail(
      usuarioId: idUsuario,
      direccionDeEmail: informacionDeUssuario.email!,
      ultimaModificacion: ahora,
      fechaCreacion: ahora,
    );

    final direccionDeEmailADb =
        await ejecutarOperacion(() => orm.crearDireccionDeEmail(
              session,
              direccionDeMail: direccionDeEmail,
            ));
    return direccionDeEmailADb;
  }

  Future<DireccionDeEmail> obtenerDireccionDeEmail(
    Session session, {
    required int idUsuario,
  }) async {
    final direccionDeEmail = await ejecutarOperacion(
        () => orm.obtenerDireccionDeEmail(session, idUsuario: idUsuario));
    return direccionDeEmail;
  }

  Future<DireccionDeEmail> actualizarDireccionDeEmail(
    Session session, {
    required DireccionDeEmail direccionDeEmail,
  }) async {
    final direccionDeEmailActualizada = await ejecutarOperacion(
      () => orm.actualizarDireccionDeEmail(
        session,
        direccionDeEmail: direccionDeEmail,
      ),
    );
    return direccionDeEmailActualizada;
  }
}
