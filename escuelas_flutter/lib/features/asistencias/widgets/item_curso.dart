import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/asistencias/bloc_asistencias/bloc_asistencias.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ItemCurso}
/// Un curso cuando no esta desplegado.
/// {@endtemplate}
class ItemCurso extends StatelessWidget {
  /// {@macro ItemCurso}
  const ItemCurso({
    required this.onTap,
    required this.curso,
    this.ancho,
  });

  /// OnTap del item.
  final VoidCallback onTap;

  /// Lista de cursos a mostrar
  final ModeloCurso curso;

  /// ancho modificable en caso de que quiera cambiarlo
  final double? ancho;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: max(7.ph, 7.sh),
        horizontal: 15.pw,
      ),
      child: InkWell(
        onTap: onTap,
        child: ElementoLista(
          ancho: ancho ?? 300.pw,
          borderRadius: 50,
          texto: Text(
            curso.nombre.toUpperCase(),
            style: TextStyle(
              color: curso.sePasoAsistencia
                  ? colores.onBackground
                  : colores.onSecondary,
              fontSize: 16.pf,
              fontWeight: FontWeight.w800,
            ),
          ),
          widgetLateralDerecho: Text(
            '${curso.cantidadDeNoAusentes()}'
            '/${curso.alumnos.length}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colores.onSecondary,
              fontSize: 16.pf,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
