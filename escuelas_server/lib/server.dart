import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart' as auth;
import 'package:escuelas_server/src/web/routes/root.dart';

import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';

// This is the starting point of your Serverpod server. In most cases, you will
// only need to make additions to this file if you add future calls,  are
// configuring Relic (Serverpod's web-server), or need custom setup work.

void run(List<String> args) async {
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
        final gmailEmail = session.serverpod.getPassword('gmailEmail')!;
        final gmailPassword = session.serverpod.getPassword('gmailPassword')!;

        // Crea un cliente SMTP para Gmail.
        final smtpServer = gmail(gmailEmail, gmailPassword);

        // Crea un mensaje de correo electrónico con el código de validación.
        final message = Message()
          ..from = Address(gmailEmail)
          ..recipients.add(email)
          ..subject = 'Codigo de validación'
          ..html = 'Tu codigo de validación es: $validationCode';
        //Envía el mensaje de correo electrónico.
        try {
          await send(message, smtpServer);
        } catch (_) {
          // Devuelve falso si no se pudo enviar el correo electrónico.
          return false;
        }
        print('Validation code: $validationCode');
        return true;
      },
      sendPasswordResetEmail: (session, userInfo, validationCode) async {
        final gmailEmail = session.serverpod.getPassword('gmailEmail')!;
        final gmailPassword = session.serverpod.getPassword('gmailPassword')!;

        // Crea un cliente SMTP para Gmail.
        final smtpServer = gmail(gmailEmail, gmailPassword);

        // Crea un mensaje de correo electrónico con el código de validación.
        final message = Message()
          ..from = Address(gmailEmail)
          ..recipients.add(userInfo.email!)
          ..subject = 'Codigo de validación'
          ..html = 'Tu codigo de validación es: $validationCode';
        //Envía el mensaje de correo electrónico.
        try {
          await send(message, smtpServer);
        } catch (_) {
          // Devuelve falso si no se pudo enviar el correo electrónico.
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
