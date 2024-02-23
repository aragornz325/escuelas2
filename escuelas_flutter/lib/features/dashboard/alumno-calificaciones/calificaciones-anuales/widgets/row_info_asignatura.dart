import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/alumno-calificaciones/calificaciones-anuales/bloc_calificaciones_anuales/bloc_calificaciones_anuales.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/utilidades/enums/textos_valorativos.dart';

import 'package:escuelas_flutter/widgets/elemento_lista.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template RowInfoAsignatura}
/// Row que contiene el nombre de la asignatura, rite y promedio.
/// {@endtemplate}
class RowInfoAsignatura extends StatelessWidget {
  /// {@macro RowInfoAsignatura}
  const RowInfoAsignatura({
    required this.listaCalificacionesAnuales,
    super.key,
  });

  /// Lista de calificaciones mensuales de un año entero de un alumno para una
  /// asignatura determinada.
  final List<CalificacionMensual?> listaCalificacionesAnuales;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final state = context.read<BlocCalificacionesAnuales>().state;

    final rite = devolverRITE(state.promedioAsignaturaAnual);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.pw),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                state.nombreAsignatura.capitalize,
                style: TextStyle(
                  fontSize: 24.pf,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 8),
              Tooltip(
                message: rite.valorativoSegunRITE(),
                margin: EdgeInsets.symmetric(horizontal: 80.pw),
                decoration: BoxDecoration(
                  color: colores.tooltipBackground,
                  borderRadius: BorderRadius.circular(
                    10.sw,
                  ),
                ),
                textStyle: TextStyle(
                  fontSize: 11.pf,
                  fontWeight: FontWeight.w500,
                  color: colores.grisSC,
                ),
                child: Row(
                  children: [
                    Text(
                      rite.siglas,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 16.pf,
                        fontWeight: FontWeight.w500,
                        color: colores.onBackgroundOpacidadCincuenta,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.sw),
                      child: Icon(
                        Icons.info_outline,
                        size: 20.sw,
                        color: colores.onBackgroundOpacidadCincuenta,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              ElementoLista.promedioAlumno(
                context: context,
                promedio: state.promedioAsignaturaAnual,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
