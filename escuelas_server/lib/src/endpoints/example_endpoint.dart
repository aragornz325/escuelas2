import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/servicios/servicio_rol.dart';
import 'package:serverpod/serverpod.dart';

class ExampleEndpoint extends Endpoint with Controller<ServicioRol> {
  Future<int> hello(Session session) async {
    return 1;
  }
}
