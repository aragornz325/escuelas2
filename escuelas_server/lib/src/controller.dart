import 'package:escuelas_server/src/servicio.dart';
import 'package:logging/logging.dart';
import 'package:escuelas_server/src/generated/protocol.dart';

mixin Controller<T extends Servicio> {
  late T servicio;
  final logger = Logger('endpoint');
  

  Future<K> ejecutarOperacionControlador<K>(
    String nombreEndpoint,
    Future<K> Function() funcion,
  ) async {
    try {
      logger.info('Accediendo a endpoint $nombreEndpoint...');
      return await funcion();
    } on ExcepcionCustom {
      rethrow;
    } on Exception {
      rethrow;
    }
  }
}
