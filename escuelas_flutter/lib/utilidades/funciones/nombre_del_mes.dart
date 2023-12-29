import 'package:intl/intl.dart';

/// Devuelve el nombre de un mes segun la fecha en formato [DateTime] recibida.
String nombreDelMesSegunFecha({required DateTime fecha}) {
  return DateFormat('MMMM', 'es').format(fecha);
}
