// ignore_for_file: avoid_shadowing_type_parameters

import 'package:cloudinary/cloudinary.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:logging/logging.dart';
import 'package:escuelas_server/src/excepciones/excepcion_endpoint.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/orm.dart';
import 'package:escuelas_server/src/servicios/servicios.dart';
//import 'package:escuelas_server/utils/config/constants.dart';
//import 'package:escuelas_server/utils/config/init_env.dart';
import 'package:serverpod/serverpod.dart';
// import 'package:similar_web/similar_web.dart';

/// Clase abstracta para la capa de Servicio.
abstract class Servicio<T extends ORM> {
  /// Variable con la instancia del odm.
  late final T orm;

  /// Instancia del logger.
  // ignore: always_specify_types
  final logger = Logger('Servicio');

  /// Instancia de [Dio].
  final dio = Dio();

  /// Instancia del servicio para almacenamiento en la nube
  /// (actualmente Cloudinary).
  // final almacenamientoNube = Cloudinary.signedConfig(
  //   apiKey: env['CLOUDINARY_APIKEY'],
  //   apiSecret: env['CLOUDINARY_APISECRET'],
  //   cloudName: env['CLOUDINARY_CLOUDNAME'],
  // );

  /// Instancia del singleton para acceder a la API de SimilarWeb (Del paquete
  /// `similar_web`). Aquí debe ir una API-KEY válida proporcionada por el
  /// servicio.
  // final similarWeb = SimilarWeb('API-KEY');

  /// Metodo para ejecutar las operaciones y manejar errores.
  Future<T> ejecutarOperacion<T>(Future<T> Function() operacion) async {
    try {
      return operacion();
    } on ExcepcionCustom catch (e, st) {
      logger.shout('''
ERROR DE PRLAB:
Titulo: ${e.titulo}
Tipo de error: ${e.tipoDeError}
Código de error: ${e.codigoError}
Mensaje: ${e.mensaje}
StackTrace: $st
''');
      rethrow;
    } on Exception catch (e, st) {
      logger.severe(
        'Unidentified error: $e \n$st',
      );
      throw UnimplementedError(
        'Unidentified error: $e \n$st',
      );
    }
  }

  /// Metodo para ejecutar las operaciones relacionadas a JSON Web Tokens y
  /// manejar sus errores.
  T ejecutarOperacionToken<T>(T Function() operacion) {
    try {
      return operacion();
    } on JWTException catch (e) {
      logger.shout('$e');
      rethrow;
    } on Exception catch (e, st) {
      logger.severe(
        'Unidentified error: $e \n$st',
      );
      throw UnimplementedError(
        'Unidentified error: $e \n$st',
      );
    }
  }

  // Future<String?> subirImagenALaNubeYRetornarUrl({
  //   required Session session,
  //   required String nombreImagen,
  //   List<int>? bytesImagen,
  // }) async {
  //   if (bytesImagen != null && bytesImagen.isNotEmpty) {
  //     return await ServicioAlmacenamientoArchivosNube()
  //         .subirImagen(
  //           session,
  //           nombreImagen: nombreImagen,
  //           directorioNube: ConstantesPrLab.cloudinaryReportsPicturesFolder,
  //           bytesImagen: bytesImagen,
  //         )
  //         .then((value) => value.secureUrl);
  //   }
  //   return null;
  // }

  String crearSlug(
    List<String> stringsParaSlug,
  ) =>
      stringsParaSlug
          .map(
            limpiarStringParaSlug,
          )
          .join('-');

  String limpiarStringParaSlug(String string) =>
      string.trim().replaceAll(RegExp(r'\s+'), '-').replaceAll(
            RegExp(
              r'''[\'\"\s;À-ÖØ-öø-ÿ\u0300-\u036f\uD83C-\uDBFF\uDC00-\uDFFF]''',
            ),
            '',
          );

  /// Comprueba el id del usuario logueado en la sesión y lo retorna.
  /// Arroja un error en caso de no haber usuario logueado.
  Future<int> obtenerIdDeUsuarioLogueado(
    Session session,
  ) async {
    final idUsuario = await session.auth.authenticatedUserId;
    if (idUsuario == null) {
      throw Excepciones.noAutorizado();
    } else {
      return idUsuario;
    }
  }
}
