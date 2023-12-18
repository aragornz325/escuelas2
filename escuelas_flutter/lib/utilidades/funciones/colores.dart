import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:flutter/material.dart';

class Colores {
  const Colores(this.context);
  final BuildContext context;

  Color segunVencimientoSegunFecha({
    required int dia,
  }) {
    final colores = context.colores;
    if (dia > 0 && dia <= 4) {
      return colores.verdeConfirmar;
    } else if (dia > 4 && dia <= 6) {
      return Colors.green;
    } else if (dia > 6 && dia <= 8) {
      return colores.amarilloCuartoFalta;
    } else if (dia > 8 && dia >= 9) {
      return colores.error;
    } else {
      return colores.onSecondary;
    }
  }

  /// Devuelve un color segun la proporcion de materias cargadas (la proporcion
  /// debe ser un valor entre 0 y 1)
  Color segunProporcionDeMateriasCargadas({
    required double proporcion,
  }) {
    final colores = context.colores;
    if (proporcion >= 0 && proporcion <= .4) {
      return colores.error;
    } else if (proporcion > 0.4 && proporcion <= .7) {
      return colores.naranjaMediaFalta;
    } else {
      return colores.verdeConfirmar;
    }
  }
}
