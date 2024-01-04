import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String nombreMes(BuildContext context) =>
      DateFormat('MMMM', Localizations.localeOf(context).languageCode)
          .format(this);

  String numeroDia(BuildContext context) =>
      DateFormat('dd', Localizations.localeOf(context).languageCode)
          .format(this);

  String nombreDia(BuildContext context) =>
      DateFormat('EEEE', Localizations.localeOf(context).languageCode)
          .format(this);

  // TODO(anyone): En algun momento hacer que soporte
  // formato de fecha segun el pais.
  /// Devuelve la fecha formateada como dd/MM/yy.
  String get formatear => DateFormat('dd/MM/yy').format(this);

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
