import 'dart:io';

import 'package:escuelas_server/server.dart';
import 'package:escuelas_server/src/endpoints/calificacion_endpoint.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/servicio_comision.dart';
import 'package:test/test.dart';

import 'server_test.dart';

Future<void> main() async {
  final ahora = DateTime.now();

  await run(['--mode', 'production', '--logging', 'verbose']);

  final session = await pod.createSession();

  final authKey = await session.auth.signInUser(1, 'email');

  await CalificacionEndpoint()
      .enviarCalificacionesPorMesYAnio(
    session,
    filtroDeEnvio: EnvioCalificaciones.porCurso,
    idCursos: [1],
    anio: 2024,
    mes: 5,
  );

  exit(0);
}
