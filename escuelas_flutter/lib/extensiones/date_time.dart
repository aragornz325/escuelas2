import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  /// Devuelve el nombre del mes. (Ej: Enero, Febrero, ...)
  String nombreMes(BuildContext context) =>
      DateFormat('MMMM', Localizations.localeOf(context).languageCode)
          .format(this);

  /// Devuelve la fecha formateada como xx/xx/xx.
  String formatear(BuildContext context) =>
      DateFormat('dd/MM/yy', Localizations.localeOf(context).languageCode)
          .format(this);

  /// Devuelve el numero del dia. (Ej: 01, 02, ...)
  String numeroDia(BuildContext context) =>
      DateFormat('dd', Localizations.localeOf(context).languageCode)
          .format(this);

  /// Devuelve el nombre del dia. (Ej: Lunes, Martes, ...)
  String nombreDia(BuildContext context) =>
      DateFormat('EEEE', Localizations.localeOf(context).languageCode)
          .format(this);

  // TODO(anyone): Agregar traducciones.
  String devolverEtiqueta() {
    if (month >= 1 && month <= 3) {
      return '1er Cuat.';
    } else if (month >= 4 && month <= 6) {
      return '2do Cuat.';
    } else if (month >= 7 && month <= 9) {
      return '3er Cuat.';
    } else {
      return '4to Cuat.';
    }
  }
}
