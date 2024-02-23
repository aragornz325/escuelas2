import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:flutter/material.dart';

/// Devuelve el color de acuerdo a la calificacion del alumno.
Color getColorFromCalificacion({
  required double? calificacion,
  required BuildContext context,
}) {
  final colores = context.colores;

  if (calificacion == null) {
    return colores.tooltipBackground;
  }

  switch (calificacion) {
    case >= 0 && <= 4:
      return colores.rojoTED;

    case > 4 && <= 6:
      return colores.amarilloCalificacionMediocre;

    case > 6 && < 10:
      return colores.verdeCalificacionAprobada;

    case 10:
      return colores.verdeTEA;

    default:
      return colores.tooltipBackground;
  }   
}
