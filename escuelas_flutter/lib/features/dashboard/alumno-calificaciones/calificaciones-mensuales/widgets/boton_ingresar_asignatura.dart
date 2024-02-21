import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/utilidades/funciones/calcular_color_segun_calificacion.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ElementoCalificacion}
/// Permite ver la calificacion del alumno de cierta materia y
/// su color de background cambia de acuerdo a los requisitos de aprobacion.
/// {@endtemplate}
class ElementoCalificacion extends StatelessWidget {
  /// {@macro ElementoCalificacion}
  const ElementoCalificacion({
    this.calificacion,
    super.key,
  });

  /// Calificacion del alumno a mostrarse
  final int? calificacion;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    final l10n = context.l10n;

    return Padding(
      padding: EdgeInsets.only(left: 4.pw),
      child: Container(
        width: 55.sw,
        height: 55.sh,
        decoration: BoxDecoration(
          color: getColorFromCalificacion(
            calificacion: calificacion?.toDouble(),
            context: context,
          ),
          borderRadius: BorderRadius.circular(100.sw),
        ),
        child: Center(
          child: Text(
            calificacion?.toString() ?? l10n.commonUnrated,
            style: TextStyle(
              color: colores.onBackground,
              fontWeight: FontWeight.w700,
              fontSize: 20.pf,
            ),
          ),
        ),
      ),
    );
  }
}
