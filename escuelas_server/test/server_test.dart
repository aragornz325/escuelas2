// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:escuelas_server/src/generated/endpoints.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/utils/logger.dart';
import 'package:escuelas_server/utils/rewrite_yaml.dart';
import 'package:rolemissions/rolemissions.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart' as auth;
import 'package:escuelas_server/src/web/routes/root.dart';

late final Serverpod podTesting;

Future<void> runServerTesting(List<String> args) async {

  const modoDevelopment = 'development';
  const flagArgumentoDeModo = '--mode';
  final indexArgumentoDeModo = args.contains(flagArgumentoDeModo) ? args.indexOf(flagArgumentoDeModo) + 1 : null;
  final argumentoDeModo = indexArgumentoDeModo != null ? args[indexArgumentoDeModo] : null;
      
  rewriteConfigYaml(
    argumentoDeModo ?? modoDevelopment,
  );

  inicializarLogger();

  podTesting = Serverpod(
    args,
    Protocol(),
    Endpoints(),
  );

  podTesting.webServer.addRoute(RouteRoot(), '/');
  podTesting.webServer.addRoute(RouteRoot(), '/index.html');

  podTesting.webServer.addRoute(
    RouteStaticDirectory(serverDirectory: 'static', basePath: '/'),
    '/*',
  );
  podTesting.webServer.addRoute(auth.RouteGoogleSignIn(), '/googlesignin');

  final rolePermissions = Rolemissions(
    persistanceDelegate: PostgresStrategy(
      host: podTesting.config.database.host,
      databaseName: podTesting.config.database.name,
      userName: podTesting.config.database.user,
      dbPassword: podTesting.config.database.password,
      port: podTesting.config.database.port,
    ),
  );

  await rolePermissions.setUp();

  auth.AuthConfig.set(
    auth.AuthConfig(
      sendValidationEmail: (session, email, validationCode) async {
        print('Validation code: $validationCode');
        return true;
      },
      sendPasswordResetEmail: (session, userInfo, validationCode) async {
        print('Validation code: $validationCode');
        return true;
      },
    ),
  );

  // Start the server.
  await podTesting.start();
}
