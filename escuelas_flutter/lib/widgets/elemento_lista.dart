import 'dart:math';

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
    this.widgetTrasero,
    super.key,
  });

  /// Texto alineado a la izquierda
  final String titulo;

  /// Funcion que se ejecuta al presionar
  final VoidCallback? onTap;

  /// Color del background
  final Color? colorFondo;

  /// Altura con .ph
  final double altura;

  /// Ancho con .pw
  final double ancho;

  /// Indica si esta habilitado para presionarse o no el boton
  final bool estaHabilitado;

  /// Tamanio de la fuente, ya tiene .pf
  final double fontSize;

  /// Componente que se agrega al final del elemento lista, permitiendo
  /// que sea mas customizable
  final Widget? widgetTrasero;

  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    return InkWell(
      onTap: estaHabilitado ? onTap : () {},
      child: Container(
        height: max(altura.sh, altura.ph),
        width: ancho.pw,
        decoration: BoxDecoration(
          color: estaHabilitado
              ? colorFondo ?? colores.tertiary
              : colores.secondary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(20.sw),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    fontWeight: fontWeight,
                    fontSize: fontSize.pf,
                  ),
                ),
                if (widgetTrasero != null) ...[
                  widgetTrasero!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
