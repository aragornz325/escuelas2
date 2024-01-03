import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:flutter/material.dart';

class Colores {
  const Colores(
    this.context,
  );

  final BuildContext context;

  ColorScheme get colores => context.colores;

  Color segunVencimientoSegunFecha({required int dia}) {
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
  Color segunProporcionDeMateriasCargadas({required double proporcion}) {
    if (proporcion == 1) {
      return colores.verdeConfirmar;
    } else if (proporcion > 0.7 && proporcion < 1) {
      return colores.naranjaMediaFalta;
    } else {
      return colores.error;
    }
  }
}
