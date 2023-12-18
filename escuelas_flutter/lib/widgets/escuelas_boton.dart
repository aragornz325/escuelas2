import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
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

    /// Contexto para utilizar colores del tema
    required BuildContext context,

    /// Tamaño del texto
    int? fontSize,

    /// Ancho del boton, por defecto es 130
    double? width,
  }) {
    final colores = context.colores;
    return EscuelasBoton(
      width: width?.pw,
      estaHabilitado: estaHabilitado,
      onTap: onTap,
      color: color,
      //! TODO(Manu): fijarse si va a ser todo mayusculas o que
      child: Text(
        texto.toUpperCase(),
        style: TextStyle(
          fontSize: fontSize?.pf ?? 16.pf,
          color: colores.background,
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
    final l10n = context.l10n;

    return EscuelasBoton(
      width: 210,
      height: max(30.sh, 30.ph),
      estaHabilitado: estaHabilitado,
      onTap: onTap,
      color: color,
      child: Row(
        children: [
          Text(
            l10n.loginPageLoginWithGoogle,
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

  /// Ancho del boton, por defecto es 130. Parametro con .pw aplicado.
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
        width: width?.pw ?? 130.pw,
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
