import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/features/dashboard/alumno-calificaciones/calificaciones-mensuales/bloc_calificaciones_mensuales/bloc_calificaciones_mensuales.dart';
import 'package:escuelas_flutter/features/dashboard/alumno-calificaciones/calificaciones-mensuales/widgets/tarjeta_calificacion_asignatura.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ListaTarjetaCalificaciones}
/// Lista de tarjetas de desempeño del alumno, donde puede visualizar
/// sus Asignaturas y respectivas calificaciones.
/// {@endtemplate}
class ListaTarjetaCalificaciones extends StatelessWidget {
  /// {@macro ListaTarjetaCalificaciones}
  const ListaTarjetaCalificaciones({
    required this.listaCalificacionesPorAsignatura,
    super.key,
  });

  /// Lista de Calificaciones del mes actual
  final List<CalificacionMensual> listaCalificacionesPorAsignatura;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocCalificacionesMensuales,
        BlocCalificacionesMensualesEstado>(
      builder: (context, state) {
        if (state is BlocCalificacionesMensualesEstadoCargando) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        final l10n = context.l10n;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 22.ph,
            ),
            child: listaCalificacionesPorAsignatura.isEmpty
                ? Center(
                    child: Text(
                    l10n.pageGradesNoGrades,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ))
                : SingleChildScrollView(
                    child: Column(
                      children: listaCalificacionesPorAsignatura.map(
                        (calificacion) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.sh,
                              horizontal: 15.pw,
                            ),
                            child: TarjetaCalificacionAsignatura(
                              calificacion: calificacion,
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
