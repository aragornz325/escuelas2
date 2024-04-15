import 'package:collection/collection.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_commons/manejo_de_calificaciones/manejo_de_calificaciones.dart';
import 'package:escuelas_flutter/features/dashboard/supervision/supervision_asignatura/bloc/bloc_supervision_asignatura.dart';
import 'package:escuelas_flutter/features/dashboard/supervision/supervision_asignatura/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ListaTarjetaCargaCalificacion}
/// Lista de tarjetas de Supervision de asignatura con calificaciones
/// {@endtemplate}
class ListaTarjetaCargaCalificacion extends StatelessWidget {
  /// {@macro ListaTarjetaCargaCalificacion}
  const ListaTarjetaCargaCalificacion({
    required this.listaEstudiantes,
    required this.listaCalificacionesMesActual,
    required this.listaCalificacionesMesesRestantes,
    super.key,
  });

  /// Lista de Estudiantes
  final List<RelacionComisionUsuario> listaEstudiantes;

  /// Lista de Calificaciones del mes actual
  final List<CalificacionMensual> listaCalificacionesMesActual;

  /// Lista de Calificaciones de meses anteriores al actual
  final List<List<CalificacionMensual>> listaCalificacionesMesesRestantes;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<BlocSupervisionAsignatura,
        BlocSupervisionAsignaturaEstado>(
      builder: (context, state) {
        if (state is BlocSupervisionAsignaturaEstadoCargando) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: listaEstudiantes.map(
                (relacionComisionUsuario) {
                  final calificacion = listaCalificacionesMesActual
                      .firstWhereOrNull(
                        (calificacionMensual) =>
                            calificacionMensual.calificacion?.estudianteId ==
                            relacionComisionUsuario.usuario?.id,
                      )
                      ?.calificacion;

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5.ph,
                      horizontal: 15.pw,
                    ),
                    child: TarjetaCargaCalificacion(
                      listaCalificacionesMesesRestantes:
                          listaCalificacionesMesesRestantes,
                      alumno: relacionComisionUsuario.usuario,
                      calificacion: calificacion == null
                          ? l10n.commonUnrated
                          : ManejadorDeCalificaciones
                              .obtenerValorDeCalificacion(
                              calificacion.tipoCalificacion,
                              calificacion.index,
                            ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        );
      },
    );
  }
}
