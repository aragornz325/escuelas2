import 'package:escuelas_server/src/servicio.dart';
import 'package:escuelas_server/src/servicios/servicio_usuario.dart';
import 'package:escuelas_commons/escuelas_commons.dart';
import 'package:logging/logging.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

mixin Controller<T extends Servicio> {
  late T servicio;
  final logger = Logger('endpoint');

  final _servicioUsuario = ServicioUsuario();

  Future<K> ejecutarOperacionControlador<K>(
    Session session,
    String nombreEndpoint,
    Future<K> Function() funcion, {
    Enum? permisoRequerido,
  }) async {
    final usuario = await _servicioUsuario.obtenerInfoBasicaUsuario(
      session,
    );

    if (permisoRequerido != null) {
      final roles = usuario.roles;
      final privilegios = usuario.privileges;

      if (roles == null && privilegios == null) {
        throw ExcepcionCustom(
          titulo: 'No tienes permisos para acceder a este recurso.',
          mensaje: 'No tienes permisos para acceder a este recurso.',
          tipoDeError: TipoExcepcion.noAutorizado,
          codigoError: 403,
        );
      }

      final permisosDeUsuario =
          roles?.values.map((e) => Permisos.fromSerialization(e)).toList() ??
              [];

      if (privilegios != null) {
        permisosDeUsuario.add(Permisos.fromSerialization(privilegios));
      }

      if (!permisosDeUsuario
          .any((permisos) => permisos.hasPermission(permisoRequerido))) {
        throw ExcepcionCustom(
          titulo: 'No tienes permisos para acceder a este recurso.',
          mensaje: 'No tienes permisos para acceder a este recurso.',
          tipoDeError: TipoExcepcion.noAutorizado,
          codigoError: 403,
        );
      }
    }

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
