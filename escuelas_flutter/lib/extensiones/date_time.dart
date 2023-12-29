import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String nombreMes(BuildContext context) =>
      DateFormat('MMMM', Localizations.localeOf(context).languageCode)
          .format(this);
  String get formatear => DateFormat('dd/MM/yy').format(this);
}
