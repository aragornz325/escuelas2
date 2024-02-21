import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/utilidades/enums/enum_meses.dart';
import 'package:flutter/material.dart';

/// Extension del enum [Meses] con sus funciones respectivas
extension MesesX on Meses {
  /// Devuelve el nombre del mes traducido.
  String obtenerNombreMes(BuildContext context) {
    final l10n = context.l10n;

    switch (this) {
      case Meses.enero:
        return l10n.commonJanuary;
      case Meses.febrero:
        return l10n.commonFebruary;
      case Meses.marzo:
        return l10n.commonMarch;
      case Meses.abril:
        return l10n.commonApril;
      case Meses.mayo:
        return l10n.commonMay;
      case Meses.junio:
        return l10n.commonJune;
      case Meses.julio:
        return l10n.commonJuly;
      case Meses.agosto:
        return l10n.commonAugust;
      case Meses.septiembre:
        return l10n.commonSeptember;
      case Meses.octubre:
        return l10n.commonOctober;
      case Meses.noviembre:
        return l10n.commonNovember;
      case Meses.diciembre:
        return l10n.commonDecember;
    }
  }
}
