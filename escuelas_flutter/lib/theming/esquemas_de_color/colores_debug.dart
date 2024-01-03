import 'package:flutter/material.dart';

/// ColorScheme a utilizarse en el theme de debugeo.
/// Este tema es necesario para reconocer los colores que seran utilizados por
/// los componentes. Asi, sera más fácil identificar el color a cambiar.

const coloresDebug = ColorScheme(
  brightness: Brightness.light,
  primary: Color.fromARGB(255, 255, 191, 0),
  onPrimary: Color.fromARGB(255, 255, 207, 62),
  primaryContainer: Color.fromARGB(255, 138, 103, 0),
  onPrimaryContainer: Color.fromARGB(255, 77, 57, 0),
  secondary: Color.fromARGB(255, 0, 255, 8),
  onSecondary: Color.fromARGB(255, 60, 255, 67),
  secondaryContainer: Color.fromARGB(255, 0, 128, 4),
  onSecondaryContainer: Color.fromARGB(255, 0, 49, 2),
  tertiary: Color.fromARGB(255, 0, 140, 255),
  onTertiary: Color.fromARGB(255, 67, 170, 255),
  tertiaryContainer: Color.fromARGB(255, 0, 74, 134),
  onTertiaryContainer: Color.fromARGB(255, 0, 41, 75),
  error: Color.fromARGB(255, 255, 17, 0),
  onError: Color.fromARGB(255, 255, 70, 56),
  errorContainer: Color.fromARGB(255, 148, 10, 0),
  onErrorContainer: Color.fromARGB(255, 53, 4, 0),
  background: Color.fromARGB(255, 217, 0, 255),
  onBackground: Color.fromARGB(255, 226, 61, 255),
  surface: Color.fromARGB(255, 255, 115, 0),
  onSurface: Color.fromARGB(255, 255, 132, 32),
  surfaceTint: Color.fromARGB(255, 138, 55, 0),
  surfaceVariant: Color.fromARGB(255, 94, 37, 0),
  shadow: Colors.grey,
  inversePrimary: Colors.black,
  inverseSurface: Colors.white,
  onInverseSurface: Colors.teal,
  onSurfaceVariant: Color.fromARGB(255, 0, 88, 80),
  outline: Colors.yellow,
  scrim: Colors.blueGrey,
  outlineVariant: Color.fromARGB(255, 0, 2, 121),
);
