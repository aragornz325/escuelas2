import 'dart:async';
import 'dart:io';

import 'package:escuelas_server/server.dart';
import 'package:logging/logging.dart';

/// This is the starting point for your Serverpod server. Typically, there is
/// no need to modify this file.
Future<void> main(List<String> args) async {
  if (args.contains('staging')) {
    args[args.indexOf('staging')] = 'development';
    Logger('SERVER').info('Modo STAGING no disponible. Arrancando server en modo DEVELOPMENT...');
  }

  if (Platform.environment['DEPLOY_STATUS'] == 'ONLINE') {
    args[args.indexOf('--mode') + 1] = Platform.environment['RAILWAY_ENVIRONMENT_NAME'] ?? 'development';
  }
  
  await run(args);
}
