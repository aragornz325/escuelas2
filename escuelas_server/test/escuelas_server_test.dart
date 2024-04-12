import 'dart:io';

import 'package:escuelas_server/server.dart';
import 'package:escuelas_server/src/endpoints/calificacion_endpoint.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'server_test.dart';

Future<void> main() async {
  final ahora = DateTime.now();

  await run(['--mode', 'production']);

  final session = await pod.createSession();

  final authKey = await session.auth.signInUser(1, 'email');

  await CalificacionEndpoint().enviarCalificacionesPorMesYAnio(
    session,
    mes: 3,
    anio: 2024,
    filtroDeEnvio: EnvioCalificaciones.porCurso,
    idCursos: [1],
  );

  exit(0);
}
