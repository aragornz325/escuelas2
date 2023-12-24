import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/gen/assets.gen.dart';
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
    this.esOutlined = false,
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
    double? fontSize,

    /// Ancho del boton, por defecto es 130
    double? width,
  }) {
    final colores = context.colores;
    return EscuelasBoton(
      width: width ?? 130.pw,
      estaHabilitado: estaHabilitado,
      onTap: onTap,
      color: color,
      child: Text(
        texto,
        style: TextStyle(
          fontSize: fontSize ?? 16.pf,
          color: colores.background,
        ),
      ),
    );
  }

  factory EscuelasBoton.loginGoogle({
    /// Funcion a realizarse accionando el boton.
    required VoidCallback onTap,

    /// Contexto para utilizar l10n y colores del tema
    required BuildContext context,
  }) {
    final colores = context.colores;
    final l10n = context.l10n;

    return EscuelasBoton(
      width: 210.pw,
      height: max(30.sh, 30.ph),
      estaHabilitado: true,
      onTap: onTap,
      color: colores.primaryContainer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Assets.images.gGoogle.path,
            width: 20.sw,
          ),
          SizedBox(width: 5.pw),
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

  factory EscuelasBoton.outlined({
    /// Funcion a realizarse accionando el boton.
    required VoidCallback onTap,

    /// Contexto para utilizar l10n y colores del tema
    required BuildContext context,

    /// Da funcionalidad al boton dependiendo de condicionales a cumplir.
    required bool estaHabilitado,

    /// Texto interno del boton
    required String texto,

    /// Ancho del boton
    required double width,

    /// Altura del boton
    required double height,

    /// Color del boton
    Color? color,
  }) {
    final colores = context.colores;

    return EscuelasBoton(
      esOutlined: true,
      estaHabilitado: estaHabilitado,
      height: height,
      width: width,
      onTap: onTap,
      color: color ?? colores.background,
      child: Center(
        child: Text(
          texto,
          style: TextStyle(
            color: colores.onSecondary,
            fontSize: 12.pf,
          ),
        ),
      ),
    );
  }

  /// Da funcionalidad al boton dependiendo de condicionales a cumplir.
  final bool estaHabilitado;

  /// Da diseño dependiendo si es outlined o fill.
  final bool esOutlined;

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
        width: width ?? 130.pw,
        height: max(height?.sh ?? 40.sh, height?.ph ?? 40.ph),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.sw),
          color: esOutlined
              ? colores.background
              : estaHabilitado
                  ? color
                  : colores.secondary,
          border: esOutlined ? Border.all(color: colores.onSecondary) : null,
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
