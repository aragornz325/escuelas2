import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
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
    required this.color,
    required this.child,
    this.width,
    this.height,
    super.key,
  });

  factory EscuelasBoton.texto({
    /// Da funcionalidad al boton dependiendo de condicionales a cumplir.
    required bool estaHabilitado,

    /// Funcion a realizarse accionando el boton.
    required VoidCallback onTap,

    /// Color del boton.
    required Color color,

    /// Texto interno del boton.
    required String texto,

    /// Tamaño del texto
    required int fontSize,
  }) {
    return EscuelasBoton(
      estaHabilitado: estaHabilitado,
      onTap: onTap,
      color: color,
      //! TODO(Manu): fijarse si va a ser todo mayusculas o que
      child: Text(
        texto.toUpperCase(),
        style: TextStyle(
          fontSize: fontSize.pf,
        ),
      ),
    );
  }

  factory EscuelasBoton.loginGoogle({
    /// Da funcionalidad al boton dependiendo de condicionales a cumplir.
    required bool estaHabilitado,

    /// Funcion a realizarse accionando el boton.
    required VoidCallback onTap,

    /// Color del boton.
    required Color color,

    /// Contexto para utilizar l10n y colores del tema
    required BuildContext context,
  }) {
    final colores = context.colores;

    return EscuelasBoton(
      estaHabilitado: estaHabilitado,
      onTap: onTap,
      color: color,
      child: Row(
        children: [
          Text(
            //! TODO(MANU): l10n
            'Ingresar con Google',
            style: TextStyle(
              fontSize: 12.pf,
              color: colores.background,
            ),
          ),
        ],
      ),
    );
  }

  /// Da funcionalidad al boton dependiendo de condicionales a cumplir.
  final bool estaHabilitado;

  /// Funcion al presionar el boton
  final VoidCallback onTap;

  /// Ancho del boton, por defecto es 130
  final double? width;

  /// Altura del boton, por defecto es 40
  final double? height;

  /// Color del container cuando esta habilitado
  final Color color;

  /// Widget que va a contener el boton, puede ser un texto o texto e iconos
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return GestureDetector(
      onTap: estaHabilitado ? onTap : null,
      child: Container(
        width: width ?? 130.pw,
        height: height ?? max(40.sh, 40.ph),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.sw),
          color: estaHabilitado ? color : colores.secondary,
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
