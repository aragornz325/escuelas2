import 'package:escuelas_server/src/endpoints/calificacion_endpoint.dart';
import 'package:escuelas_server/src/endpoints/solicitud_endpoint.dart';
import 'package:escuelas_server/src/endpoints/usuario_endpoint.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_calificacion.dart';
import 'package:escuelas_server/src/orms/orm_comision.dart';
import 'package:escuelas_server/src/orms/orm_direccionesDeEmail.dart';
import 'package:escuelas_server/src/orms/orm_usuario.dart';
import 'package:escuelas_server/src/servicios/servicio_rol.dart';
import 'package:escuelas_server/src/servicios/servicio_solicitud_nota_mensual.dart';
import 'package:escuelas_server/src/servicios/servicio_usuario.dart';
import 'package:serverpod_auth_server/module.dart' as auth;

import 'server_test.dart';

Future<void> main() async {
  final ahora = DateTime.now();

  await runServerTesting([]);

  final session = await podTesting.createSession();

  final authKey = await session.auth.signInUser(11, 'email');

  final mes = ahora.month;

  final anio = ahora.year;

  final idEstudiantes = [51];

  final usuariosACrear = List.generate(
      10,
      (index) => Usuario(
          idUserInfo: 990 + index,
          nombre: 'User',
          apellido: '$index',
          urlFotoDePerfil: 'about:blank'));

  for (var usuario in usuariosACrear) {
    final usuarioCreado = await OrmUsuario().crearUsuario(
      session,
      nuevoUsuario: usuario,
    );
    await OrmDireccionesdeEmail().crearDireccionDeEmail(
      session,
      direccionDeMail: DireccionDeEmail(
        usuarioId: usuarioCreado.id!,
        direccionDeEmail:
            'test${usuarioCreado.idUserInfo}@escuelas2wasawasa.com',
      ),
    );
    await ServicioRol().asignarRolAUsuario(
      session,
      idUsuario: usuarioCreado.id!,
      idRol: usuariosACrear.indexOf(usuario) <= 6 ? 1 : 2,
      // TODO(anyone):
      // Por ahora el id de organizacion siempre va a ser 1
      // ese id va a ser referente a la organizacion de la escuela
      // `Redemptoris Missio`
      idOrganizacion: 1,
    );
  }
}
