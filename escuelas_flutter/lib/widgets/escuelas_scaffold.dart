import 'package:flutter/material.dart';

/// {@template EscuelasScaffold}
/// Scaffold General que se va a utilizar en el proyecto escuelas para los
/// Callback de las pantallas de la app.
/// {@endtemplate}
class EscuelasScaffold extends StatelessWidget {
  /// {@macro EscuelasScaffold}
  const EscuelasScaffold({
    required this.cuerpo,
    this.colorDeFondo,
    super.key,
  });

  /// Componente a dibujar.
  final Widget cuerpo;

  /// Color de fondo,por defecto va a tener el color de background del theme.
  final Color? colorDeFondo;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Scaffold(
      backgroundColor: colorDeFondo ?? colores.background,
      body: cuerpo,
    );
  }
}
