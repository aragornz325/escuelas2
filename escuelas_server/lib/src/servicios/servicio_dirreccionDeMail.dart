import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_curso.dart';
import 'package:escuelas_server/src/orms/orm_direccionesDeEmail.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:escuelas_server/src/servicios/servicio_userInfo.dart';
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
      idUsuario: idUsuario,
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
}
