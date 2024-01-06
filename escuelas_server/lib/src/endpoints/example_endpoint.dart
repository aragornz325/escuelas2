import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart';


class ExampleEndpoint extends Endpoint {

  Future<String> hello(Session session, String name) async {
    await Emails.createUser(session, 'JuanjoTest', 'juanjgar998@gmail.com', 'Password123!');
    return "Ok.";
  }
}
