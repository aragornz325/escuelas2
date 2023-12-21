import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:flutter/material.dart';

/// Enumerador con los valores del RITE y funciones relacionadas(color y el
/// texto valorativo)
enum RITE {
  tea('TEA'),
  tep('TEP'),
  ted('TED'),
  sinCalificaciones('S/C');

  const RITE(this.siglas);

  /// Siglas del RITE
  final String siglas;

  /// Devuelve el valorativo del alumno segun el RITE
  String valorativoSegunRITE() {
    switch (this) {
      case RITE.tea:
        return 'El alumno presenta buen nivel de compromiso y participación frecuente en las propuestas de la materia. Logró de manera satisfactoria apropiarse de los contenidos curriculares.';
      case RITE.tep:
        return 'El alumno presentó un bajo nivel de compromiso y participación en las propuestas de la materia. No logró todavía la apropiación de los contenidos curriculares y otros saberes esperados.';
      case RITE.ted:
        return 'El alumno no logró sostener el vínculo pedagógico, demostrando escaso compromiso y no participando de las propuestas de la materia. No logró apropiarse de los contenidos curriculares y otros saberes esperados. Se lo/la alienta a acercarse al docente para recibir orientación, a comprometerse y participar de manera activa para revertir su situación.';
      case RITE.sinCalificaciones:
        return 'SIN CALIFICACIONES';
    }
  }

  /// Devuelve el color del RITE correspondiente
  Color colorSegunRITE(BuildContext context) {
    final colores = context.colores;

    switch (this) {
      case RITE.tea:
        return colores.verdeTEA;
      case RITE.tep:
        return colores.naranjaTEP;
      case RITE.ted:
        return colores.rojoTED;
      case RITE.sinCalificaciones:
        return colores.grisSC;
    }
  }
}

/// Devuelve el RITE correspondiente
RITE devolverRITE(double promedio) {
  if (promedio >= 1 && promedio < 5) {
    return RITE.ted;
  } else if (promedio >= 5 && promedio < 7) {
    return RITE.tep;
  } else if (promedio >= 7 && promedio <= 10) {
    return RITE.tea;
  } else {
    return RITE.sinCalificaciones;
  }
}
