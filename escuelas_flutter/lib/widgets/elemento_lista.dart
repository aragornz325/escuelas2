import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ElementoLista}
/// Componente reutilizable usado en listas generalmente que permite presionarlo
/// para ejecutar determinada accion.
/// {@endtemplate}
class ElementoLista extends StatelessWidget {
  /// {@macro ElementoLista}
  const ElementoLista({
    required this.texto,
    this.colorFondo,
    this.tieneBoxShadow = false,
    this.estaHabilitado = true,
    this.onTap,
    this.altura = 65,
    this.ancho = 329,
    this.borderRadius = 20,
    this.widgetLateralDerecho,
    this.colorTitulo,
    this.widgetLateralIzquierdo,
    super.key,
  });
  factory ElementoLista.rol({
    /// Indica si esta presionado o no
    required bool estaPresionado,

    /// Funcion a realizarse accionando el boton.
    required VoidCallback onTap,

    /// Nombre del rol.
    required Text nombreRol,

    /// Contexto para utilizar colores del tema
    required BuildContext context,
  }) {
    final colores = context.colores;

    return ElementoLista(
      texto: nombreRol,
      altura: 65.ph,
      ancho: 330.pw,
      borderRadius: 20.sw,
      colorFondo:
          estaPresionado ? colores.grisBotonPresionado : colores.tertiary,
      onTap: onTap,
      tieneBoxShadow: estaPresionado,
    );
  }
  factory ElementoLista.usuario({
    /// Funcion a realizarse accionando el boton.
    required VoidCallback onTap,

    /// Nombre del rol.
    required Text nombreUsuario,

    /// Contexto para utilizar colores del tema
    required BuildContext context,
  }) {
    final colores = context.colores;

    return ElementoLista(
      texto: nombreUsuario,
      altura: 50.ph,
      ancho: 300.pw,
      borderRadius: 40.sw,
      colorFondo: colores.tertiary,
      onTap: onTap,
    );
  }

  /// Texto alineado a la izquierda
  final Text texto;

  /// Funcion que se ejecuta al presionar
  final VoidCallback? onTap;

  /// Color del background
  final Color? colorFondo;

  /// Altura
  final double altura;

  /// Ancho
  final double ancho;

  /// Indica si esta habilitado para presionarse o no el boton
  final bool estaHabilitado;

  /// Radio del borde del [ElementoLista]
  final double borderRadius;

  /// Componente que se agrega al final del [ElementoLista] a la derecha
  /// del titulo, permitiendo que sea mas customizable
  final Widget? widgetLateralDerecho;

  /// Componente que se agrega al principio del [ElementoLista] a la izquierda
  /// del titulo, permitiendo que sea mas customizable
  final Widget? widgetLateralIzquierdo;

  /// En caso de ser true agrega box shadow al presionar el elemento.
  final bool tieneBoxShadow;

  final Color? colorTitulo;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return GestureDetector(
      onTap: estaHabilitado ? onTap : null,
      child: Container(
        height: altura,
        width: ancho,
        decoration: BoxDecoration(
          color: estaHabilitado
              ? colorFondo ?? colores.tertiary
              : colores.secondary,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: tieneBoxShadow
              ? [
                  BoxShadow(
                    blurRadius: 50,
                    offset: const Offset(0, -4),
                    color: colores.grisClaroSombreado,
                    inset: true,
                  ),
                  BoxShadow(
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                    inset: true,
                    color: colores.grisSC,
                  ),
                ]
              : [],
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.pw,
              vertical: 5.ph,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (widgetLateralIzquierdo != null) widgetLateralIzquierdo!,
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: texto,
                    ),
                  ],
                ),
                if (widgetLateralDerecho != null) widgetLateralDerecho!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
