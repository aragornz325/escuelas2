import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  /// Devuelve el nombre del mes. (Ej: Enero, Febrero, ...)
  String nombreMes(BuildContext context) =>
      DateFormat('MMMM', Localizations.localeOf(context).languageCode)
          .format(this);

  /// Devuelve la fecha formateada como xx/xx/xx.
  String get formatear => DateFormat('dd/MM/yy').format(this);

  /// Devuelve el numero del dia. (Ej: 01, 02, ...)
  String numeroDia(BuildContext context) =>
      DateFormat('dd', Localizations.localeOf(context).languageCode)
          .format(this);

  /// Devuelve el nombre del dia. (Ej: Lunes, Martes, ...)
  String nombreDia(BuildContext context) =>
      DateFormat('EEEE', Localizations.localeOf(context).languageCode)
          .format(this);

  /// TODO(mati) add docu
  String periodoFechaEnviada(BuildContext context) {
    final l10n = context.l10n;

    if (mismaFecha(this)) {
      final fecha =
          DateFormat('HH:mm', Localizations.localeOf(context).languageCode)
              .format(this);
      return '$fecha Hoy'; // TODO(mati):traducir${l10n.commonToday}';
    }
    return DateFormat('E dd/M', Localizations.localeOf(context).languageCode)
        .format(this);
  }

  /// Devuelve la hora formateada como xx:xx
  String horaFechaEnviada(BuildContext context) {
    return DateFormat('HH:mm', Localizations.localeOf(context).languageCode)
        .format(this);
  }

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

  /// Compara si dos fechas son iguales
  bool mismaFecha(DateTime other) =>
      year == other.year && month == other.month && day == other.day;
}
