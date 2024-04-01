import 'dart:async';
import 'dart:developer';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/utilidades/cliente_serverpod.dart';
import 'package:flutter/foundation.dart';

typedef ExcepcionCustomErrorHandlerCallback = void Function(
    ExcepcionCustom, StackTrace);

void _constNoOp(_, __) {}
const ExcepcionCustomErrorHandlerCallback _noOp = _constNoOp;

/// Operación de los eventos de los `Bloc`(s) para
/// de forma centralizada manejar los errores que puedan
/// llegar a darse en el cliente.
Future<void> operacionBloc({
  required FutureOr<void> Function(Client client) callback,
  required void Function(Object e, StackTrace st) onError,
  ExcepcionCustomErrorHandlerCallback onErrorCustom = _noOp,

  /// Callback que se ejecuta cuando el back devuelve
  /// un error 404, no encontró alguna entidad en la db.
  ExcepcionCustomErrorHandlerCallback onErrorNoEncontrado = _noOp,

  /// Callback que se ejecuta cuando no se puede ejecutar
  /// un endpoint por falta de conexión.
  ExcepcionCustomErrorHandlerCallback onSinConexion = _noOp,

  /// Callback que se ejecuta cuando el back devuelve
  /// un error 570, habría que crear algun error para estos
  /// casos.
  ExcepcionCustomErrorHandlerCallback onDesconocido = _noOp,
}) async {
  try {
    return await callback(client);
  } on ExcepcionCustom catch (e, st) {
    var ningunHandlerLlamado = true;
    void callHandler(ExcepcionCustomErrorHandlerCallback callback) {
      if (callback != _noOp) {
        ningunHandlerLlamado = false;
        callback.call(e, st);
      }
    }

    switch (e.tipoDeError) {
      case TipoExcepcion.noEncontrado:
        callHandler(onErrorNoEncontrado);
      case TipoExcepcion.noAutorizado:
      case TipoExcepcion.prohibido:
      case TipoExcepcion.solicitudIncorrecta:
      case TipoExcepcion.sinConexion:
        callHandler(onSinConexion);
      case TipoExcepcion.parseo:
      case TipoExcepcion.desconocido:
        callHandler(onDesconocido);
      case TipoExcepcion.registerDuplicatedIdNumber:
      case TipoExcepcion.registerDuplicatedEmail:
        callHandler(onErrorCustom);
    }

    if (ningunHandlerLlamado) onError(e, st);
  } catch (e, st) {
    if (kDebugMode) {
      debugger(
          message: 'error desconocido, handlear esto (q no debería pasar)');
    }
    onError(e, st);
  }
}
