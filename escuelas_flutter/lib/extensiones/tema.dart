import 'package:flutter/material.dart';

/// Extension util para declarar una variable y acceder al contenido ahorrando
/// codigo. Asignar nombre "COLORES" para utilizarla y mantener una
/// estructura consistente
extension ThemeDataX on BuildContext {
  ColorScheme get colores => Theme.of(this).colorScheme;
}
