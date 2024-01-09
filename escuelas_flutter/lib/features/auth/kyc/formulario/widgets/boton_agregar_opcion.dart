import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template BotonAgregarOpcion}
/// Botón para agregar una opcion al formulario
/// {@endtemplate}
class BotonAgregarOpcion extends StatelessWidget {
  /// {@macro BotonAgregarOpcion}
  const BotonAgregarOpcion({
    required this.textoBoton,
    required this.onPressed,
    super.key,
  });

  /// Funcion a ejecutar al confirmar
  final void Function() onPressed;

  /// Texto del boton
  final String textoBoton;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        Icons.add_circle_outline_outlined,
        color: colores.onBackground,
        size: 18.pw,
      ),
      label: Text(
        textoBoton.toUpperCase(),
        style: TextStyle(
          color: colores.onBackground,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.w700,
          fontSize: 15.pf,
        ),
      ),
    );
  }
}
