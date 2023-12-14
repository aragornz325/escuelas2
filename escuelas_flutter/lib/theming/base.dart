import 'package:flutter/material.dart';

/// ColorScheme base donde se agregan los colores adicionales al tema light.
extension EscuelasColorScheme on ColorScheme {
  /// Color verde utilizado para confirmar accion.
  Color get verdeConfirmar => const Color(0xff62B446);

  /// Color utilizado para el estado de cuarto de falta.
  Color get amarilloCuartoFalta => const Color(0xffE0CA01);

  /// Color utilizado para el estado de media falta.
  Color get naranjaMediaFalta => const Color(0xffFF7E21);

  /// Color utilizado en list tile de materias, alumnos, etc.
  Color get violetaListTile => const Color(0xffB250FF);

  /// Color a utilizarse en botones de asistencia, datos personales,modificacion
  /// de cursos, etc.
  Color get coralBotones => const Color(0xffFF7B5E);

  /// Color utilizado de fondo en version Desktop.
  Color get marfilBackgroundDesktop => const Color(0xffe8e8e8);

  /// Color utilizado en el promedio TEA
  Color get verdeTEA => const Color(0xff62B446);

  /// Color utilizado en el promedio TEP
  Color get naranjaTEP => const Color(0xffFF7E21);

  /// Color utilizado en el promedio TED
  Color get rojoTED => const Color(0xffFF4444);
}
