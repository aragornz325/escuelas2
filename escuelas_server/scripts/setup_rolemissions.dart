import 'dart:io';

import 'package:escuelas_server/server.dart';
import 'package:escuelas_server/utils/init_env.dart';
import 'package:rolemissions/rolemissions.dart';

void main() async {
  final runMode = 'development';

  await run(['--mode', runMode]);

  final rolemission = Rolemissions(
    persistanceDelegate: PostgresStrategy(
      host: env.hostDb,
      databaseName: env.nombreDb,
      userName: env.usuarioDb,
      dbPassword: pod.config.database.password,
      port: env.puertoDb,
    ),
  );

  await rolemission.initialFixture(
    userTable: 'usuarios',
  );

  exit(0);
}
