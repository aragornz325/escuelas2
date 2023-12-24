import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';

// void Function(ExcepcionCustom excepcion) onErrorCustom = (_) {};

/// Callback que se ejecuta cuando el back devuelve
/// un error 404, no encontró alguna entidad en la db.
// void Function(ExcepcionCustom excepcion) onErrorNoEncontrado = (_) {};

/// Callback que se ejecuta cuando no se puede ejecutar
/// un endpoint por falta de conexión.
void Function() onSinConexion = () {};

/// Callback que se ejecuta cuando el back devuelve
/// un error 570, habría que crear algun error para estos
/// casos.
// void Function(StackTrace st, ExcepcionCustom excepcionCustom) onDesconocido =
//     (_, e) {};

/// Operación de los eventos de los `Bloc`(s) para
/// de forma centralizada manejar los errores que puedan
/// llegar a darse en el cliente.
Future<void> operacionBloc({
  required FutureOr<void> Function(
          // Client client
          )
      callback,
  required void Function(Object e, StackTrace st) onError,
}) async {
  try {
    return await callback(
        // client
        );
  } catch (e, st) {
    onError(e, st);

    // if (e is ExcepcionCustom) {
    //   switch (e.tipoDeError) {
    //     case TipoExcepcion.noEncontrado:
    //       onErrorNoEncontrado(e);
    //     case TipoExcepcion.noAutorizado:
    //     case TipoExcepcion.prohibido:
    //     case TipoExcepcion.solicitudIncorrecta:
    //       onErrorCustom(e);
    //     case TipoExcepcion.sinConexion:
    //       onSinConexion.call();
    //     case TipoExcepcion.parseo:
    //     case TipoExcepcion.desconocido:
    //       onDesconocido.call(st, e);
    //   }
    // }

    // En caso de que el back no resuelva, se crea una excepcion
    // desconocida, handlear caso de error!
    // final ex = ExcepcionCustom(
    //   titulo: 'ERROR DESCONOCIDO',
    //   mensaje: 'UNKNOWN ERROR',
    //   tipoDeError: TipoExcepcion.desconocido,
    //   codigoError: 570,
    // );

    // onDesconocido.call(st, ex);

    if (kDebugMode) debugger();
  }
}
