import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ElementoLista}
/// Componente reutilizable usado en listas generalmente que permite presionarlo
/// para ejecutar determinada accion.
/// {@endtemplate}
class ElementoLista extends StatelessWidget {
  /// {@macro ElementoLista}
  const ElementoLista({
    required this.titulo,
    this.colorFondo,
    this.estaHabilitado = true,
    this.onTap,
    this.altura = 65,
    this.ancho = 329,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.borderRadius = 20,
    this.widgetLateralDerecho,
    this.widgetLateralIzquierdo,
    super.key,
  });
// TODO(SAM): Ver que hacer con el sombreado del boton al presionarse.

  /// Texto alineado a la izquierda
  final String titulo;

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

  /// Tamanio de la fuente
  final double fontSize;

  /// Radio del borde del [ElementoLista]
  final double borderRadius;

  /// Componente que se agrega al final del [ElementoLista] a la derecha
  /// del titulo, permitiendo que sea mas customizable
  final Widget? widgetLateralDerecho;

  /// Componente que se agrega al principio del [ElementoLista] a la izquierda
  /// del titulo, permitiendo que sea mas customizable
  final Widget? widgetLateralIzquierdo;

  /// Peso de la fuente, grosor
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    return InkWell(
      onTap: estaHabilitado ? onTap : null,
      child: Container(
        height: altura,
        width: ancho,
        decoration: BoxDecoration(
          color: estaHabilitado
              ? colorFondo ?? colores.tertiary
              : colores.secondary,
          borderRadius: BorderRadius.circular(borderRadius.sw),
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
                      child: Text(
                        titulo,
                        style: TextStyle(
                          fontWeight: fontWeight,
                          fontSize: fontSize,
                        ),
                      ),
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
