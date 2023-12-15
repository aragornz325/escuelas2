import 'dart:math';

import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@templates EscuelasBoton}
/// Boton personalizado para utilizar
/// {@endtemplates}
class EscuelasBoton extends StatelessWidget {
  /// {@macro EscuelasBoton}
  const EscuelasBoton({
    required this.estaHabilitado,
    required this.onTap,
    this.width,
    this.height,
    super.key,
  });

  /// Da funcionalidad al boton dependiendo de condicionales a cumplir.
  final bool estaHabilitado;

  /// Funcion al presionar el boton
  final VoidCallback onTap;

  /// Ancho del boton, por defecto es 130
  final double? width;

  /// Altura del boton, por defecto es 40
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: estaHabilitado ? onTap : null,
      child: Container(
        width: width ?? 130.pw,
        height: height ?? max(40.sh, 40.ph),
      ),
    );
  }
}
