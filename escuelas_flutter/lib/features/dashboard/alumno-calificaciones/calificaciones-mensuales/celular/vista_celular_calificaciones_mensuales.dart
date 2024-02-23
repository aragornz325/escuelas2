import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/alumno-calificaciones/calificaciones-mensuales/bloc_calificaciones_mensuales/bloc_calificaciones_mensuales.dart';
import 'package:escuelas_flutter/features/dashboard/alumno-calificaciones/calificaciones-mensuales/widgets/widgets.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/delegates/periodo_delegate.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/delegates/periodo_mensual_delegate.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/selector_de_periodo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularCalificacionesMensuales}
/// Vista para celular de la pagina 'CalificacionesMensuales'
/// {@endtemplate}
class VistaCelularCalificacionesMensuales extends StatelessWidget {
  /// {@macro VistaCelularCalificacionesMensuales}
  const VistaCelularCalificacionesMensuales({super.key});
  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return BlocBuilder<BlocCalificacionesMensuales,
        BlocCalificacionesMensualesEstado>(
      builder: (context, state) {
        final etiqueta = state.fecha != null
            ? state.fecha!.nombreMes(context).toUpperCase()
            : '';

        final fechaDesde =
            state.fecha?.copyWith(day: 1) ?? DateTime.now().copyWith(day: 1);

        final fechaHasta = DateTime(
          DateTime.now().year,
          DateTime.now().month + 1,
        ).subtract(const Duration(days: 1));

        return Column(
          children: [
            SelectorDePeriodo(
              delegate: PeriodoMensualDelegate(
                context,
                periodo: PeriodoDelSelector(
                  etiqueta: etiqueta,
                  fechaDesde: fechaDesde,
                  fechaHasta: fechaHasta,
                ),
              ),
              onSeleccionarPeriodo: (periodo) =>
                  context.read<BlocCalificacionesMensuales>().add(
                        BlocCalificacionesMensualesEventoInicializar(
                          fecha: periodo.fechaDesde,
                        ),
                      ),
              decoration: BoxDecoration(
                color: colores.tertiary,
                borderRadius: BorderRadius.circular(40.sw),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20.pw),
            ),
            ListaTarjetaCalificaciones(
              listaCalificacionesPorAsignatura:
                  state.listaCalificacionesPorMateria,
            ),
          ],
        );
      },
    );
  }
}
