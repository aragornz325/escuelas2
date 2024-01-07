import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart';

class ExampleEndpoint extends Endpoint {
  Future<String> hello(
    Session session, {
    required String nombreDeUsuario,
    required String direccionDeEmail,
    required String password,
  }) async {
    await Emails.createUser(
      session,
      nombreDeUsuario,
      direccionDeEmail,
      password,
    );
    return "Ok.";
  }
}
