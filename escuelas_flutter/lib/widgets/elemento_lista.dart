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
    this.colorTitulo,
    this.padding,
    this.colorFondo,
    this.estaHabilitado = true,
    this.onTap,
    this.altura = 65,
    this.ancho,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.widgetTrasero,
    this.radioDelBorde = 20,
    super.key,
  });

  /// Texto alineado a la izquierda
  final String titulo;

  /// Funcion que se ejecuta al presionar
  final VoidCallback? onTap;

  /// Color del background
  final Color? colorFondo;
  final Color? colorTitulo;

  /// Altura con .ph
  final double altura;
  final double? padding;

  /// Ancho con .pw
  final double? ancho;

  /// Indica si esta habilitado para presionarse o no el boton
  final bool estaHabilitado;

  /// Tamanio de la fuente, ya tiene .pf
  final double fontSize;

  /// Componente que se agrega al final del elemento lista, permitiendo
  /// que sea mas customizable
  final Widget? widgetTrasero;

  final FontWeight fontWeight;

  final double radioDelBorde;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    return InkWell(
      onTap: estaHabilitado ? onTap : null,
      child: Expanded(
        child: Container(
          height: altura,
          width: ancho,
          decoration: BoxDecoration(
            color: estaHabilitado
                ? colorFondo ?? colores.tertiary
                : colores.secondary,
            borderRadius: BorderRadius.circular(radioDelBorde),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(padding ?? 20.pw),
                  child: Text(
                    titulo,
                    style: TextStyle(
                      fontWeight: fontWeight,
                      fontSize: fontSize,
                      color: colorTitulo,
                    ),
                  ),
                ),
                widgetTrasero ?? const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
