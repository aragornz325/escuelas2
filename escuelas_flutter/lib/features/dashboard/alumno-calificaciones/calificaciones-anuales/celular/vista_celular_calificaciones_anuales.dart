import 'package:escuelas_flutter/features/dashboard/alumno-calificaciones/calificaciones-anuales/bloc_calificaciones_anuales/bloc_calificaciones_anuales.dart';
import 'package:escuelas_flutter/features/dashboard/alumno-calificaciones/calificaciones-anuales/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template VistaCelularCalificacionesAnuales}
/// Vista para celular de la pagina 'CalificacionesAnuales'
/// {@endtemplate}
class VistaCelularCalificacionesAnuales extends StatelessWidget {
  /// {@macro VistaCelularCalificacionesAnuales}
  const VistaCelularCalificacionesAnuales({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocCalificacionesAnuales,
        BlocCalificacionesAnualesEstado>(
      builder: (context, state) {
        if (state is BlocCalificacionesAnualesEstadoCargando) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final listaCalificacionesAnuales = state.listaCalificacionesAnuales;

        return Column(
          children: [
            RowInfoAsignatura(
              listaCalificacionesAnuales: listaCalificacionesAnuales,
            ),
            ListaTarjetaCalificacionesAnuales(
              listaCalificacionesAnuales: listaCalificacionesAnuales,
            ),
          ],
        );
      },
    );
  }
}
