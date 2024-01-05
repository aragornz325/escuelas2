// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:escuelas_server/src/servicios/servicio_comunicaciones.dart';
import 'package:escuelas_server/utils/constants.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart' as auth;
import 'package:escuelas_server/src/web/routes/root.dart';

import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';

// This is the starting point of your Serverpod server. In most cases, you will
// only need to make additions to this file if you add future calls,  are
// configuring Relic (Serverpod's web-server), or need custom setup work.

void run(List<String> args) async {
  final ServicioComunicaciones _servicioComunicaciones =
      ServicioComunicaciones();
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
  );

  // If you are using any future calls, they need to be registered here.
  // pod.registerFutureCall(ExampleFutureCall(), 'exampleFutureCall');

  // Setup a default page at the web root.
  pod.webServer.addRoute(RouteRoot(), '/');
  pod.webServer.addRoute(RouteRoot(), '/index.html');
  // Serve all files in the /static directory.
  pod.webServer.addRoute(
    RouteStaticDirectory(serverDirectory: 'static', basePath: '/'),
    '/*',
  );
  pod.webServer.addRoute(auth.RouteGoogleSignIn(), '/googlesignin');

  auth.AuthConfig.set(
    auth.AuthConfig(
      sendValidationEmail: (session, email, validationCode) async {
        final enviarEmail = await _servicioComunicaciones.enviarEmail(
          session,
          direccionEmailDestinatario: email,
          asuntoDelCorreo: asuntoDeCorreoVerificacionDeCuenta,
          contenidoHtmlDelCorreo:
              '<p>Tu código de validación es $validationCode.</p>',
        );

        if (enviarEmail.huboUnError) {
          return false;
        }

        print('Validation code: $validationCode');
        return true;
      },
      sendPasswordResetEmail: (session, userInfo, validationCode) async {
        if (userInfo.email == null) {
          throw ExcepcionCustom(
            titulo: 'Error Desconocido.',
            mensaje: 'No se pudo acceder a la dirección de email del usuario.',
            tipoDeError: TipoExcepcion.desconocido,
            codigoError: 500,
          );
        }

        final enviarEmail = await _servicioComunicaciones.enviarEmail(
          session,
          direccionEmailDestinatario: userInfo.email!,
          asuntoDelCorreo: asuntoDeCorreoRecuperacionDePassword,
          contenidoHtmlDelCorreo:
              '<p>Tu código de validación es $validationCode.</p>',
        );

        if (enviarEmail.huboUnError) {
          return false;
        }

        print('Validation code: $validationCode');
        return true;
      },
    ),
  );

  // Start the server.
  await pod.start();
}
