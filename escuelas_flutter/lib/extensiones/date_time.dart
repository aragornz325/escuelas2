import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String nombreMes(BuildContext context) =>
      DateFormat('MMMM', Localizations.localeOf(context).languageCode)
          .format(this);
  String get formatear => DateFormat('dd/MM/yy').format(this);

  // TODO(anyomus): Agregar traducciones.
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
