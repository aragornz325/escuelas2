import 'dart:io';

import 'package:escuelas_server/server.dart';
import 'package:escuelas_server/src/endpoints/usuario_endpoint.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:serverpod_auth_server/module.dart';

Future<void> main() async {
  final ahora = DateTime.now();

  await run(['--mode','production']);

  final session = await pod.createSession();

  final authKey = await session.auth.signInUser(160, 'email');

  final userInfo = await UserInfo.db.findById(session, authKey.userId);

  await UsuarioEndpoint().enviarSolicitudRegistroDocente(
    session,
    usuarioPendiente: UsuarioPendiente(
      idUserInfo: authKey.userId,
      nombre: userInfo!.userName.split(';').first,
      apellido: userInfo.userName.split(';').last,
      dni: userInfo.userIdentifier,
      urlFotoDePerfil:
          'https://res.cloudinary.com/dovck0lft/image/upload/v1710430707/contentHeadingImages/img_content_63_1710430707199.jpg',
      idRolSolicitado: 2,
      estadoDeSolicitud: EstadoDeSolicitud.pendiente,
      ultimaModificacion: ahora,
      fechaCreacion: ahora,
    ),
    asignaturasSolicitadas: [
      AsignaturaSolicitada(
        asignaturaId: 49,
        comisionId: 5,
        idUsuarioPendiente: 0,
        ultimaModificacion: ahora,
        fechaCreacion: ahora,
      ),
      AsignaturaSolicitada(
        asignaturaId: 37,
        comisionId: 6,
        idUsuarioPendiente: 0,
        ultimaModificacion: ahora,
        fechaCreacion: ahora,
      ),
    ],
  );

  exit(0);
}