import 'dart:developer' as developer;
import 'dart:io';

import 'package:logging/logging.dart';

/// Funcion para inicializar el logger del servidor.
void inicializarLogger({
  bool modoDebugging = false,
  bool colores = true,
  bool marcaDeTiempo = true,
}) {
  Logger.root.level = Level.ALL;

  hierarchicalLoggingEnabled = true;

  Logger.root.onRecord.listen((record) {
    String mensaje;
    String tiempo = marcaDeTiempo ? '${record.time}:' : '';
    if (colores) {
      var inicio = '\x1b[90m';
      const fin = '\x1b[0m';
      const blanco = '\x1b[37m';

      switch (record.level.name) {
        case 'INFO':
          inicio = '\x1b[37m';
        case 'FINE':
          inicio = '\x1B[32m';
        case 'FINER':
          inicio = '\x1B[34m';
        case 'FINEST':
          inicio = '\x1B[36m';
        case 'SEVERE':
          inicio = '\x1b[103m\x1b[31m';
        case 'SHOUT':
          inicio = '\x1b[41m\x1b[93m';
      }

      mensaje = '$blanco$tiempo$fin$inicio [${record.level.name}]: '
          '[${record.loggerName}] ${record.message} $fin';
    } else {
      mensaje = '$tiempo [${record.level.name}]: ${record.message}';
    }
    if (record.error != null) {
      mensaje += '\n${record.error}';
      if (record.stackTrace != null) {
        mensaje += '\n${record.stackTrace}';
      }
    }
    if (modoDebugging) {
      developer.log(
        mensaje,
        name: record.loggerName.padRight(25),
        level: record.level.value,
        time: record.time,
      );
    } else {
      stdout.writeln(mensaje);
    }
  });
}
