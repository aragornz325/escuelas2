import 'package:bloc/bloc.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:flutter/material.dart';

part 'bloc_calificaciones_mensuales_evento.dart';
part 'bloc_calificaciones_mensuales_estado.dart';

/// {@template BlocCalificacionesMensuales}
/// BLoC que maneja el estado y la lógica general de la pagina
///  'CalificacionesMensuales'
/// {@endtemplate}
class BlocCalificacionesMensuales extends Bloc<
    BlocCalificacionesMensualesEvento, BlocCalificacionesMensualesEstado> {
  /// {@macro BlocCalificacionesMensuales}
  BlocCalificacionesMensuales({required this.fecha})
      : super(BlocCalificacionesMensualesEstadoInicial(fecha: fecha)) {
    on<BlocCalificacionesMensualesEventoInicializar>(_onInicializar);
  }

  /// Fecha de la pantalla anterior
  final DateTime fecha;

  /// Al inicializar trae los cursos para tomar CalificacionesMensuales.
  Future<void> _onInicializar(
    BlocCalificacionesMensualesEventoInicializar event,
    Emitter<BlocCalificacionesMensualesEstado> emit,
  ) async {
    emit(BlocCalificacionesMensualesEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        // TODO(ANYONE): Promedio todavia no esta, viene del back Hardcodeado

        final fecha = event.fecha ?? state.fecha;

        if (fecha == null) {
          return emit(BlocCalificacionesMensualesEstadoFallido.desde(state));
        }

        final listaCalificacionesMensuales =
            await client.calificacion.listarMisCalificacionesMensualesPorMes(
          mes: fecha.month,
          anio: fecha.year,
        );

        emit(
          BlocCalificacionesMensualesEstadoExitoso.desde(
            state,
            listaCalificacionesPorMateria: listaCalificacionesMensuales,
          ),
        );
      },
      onError: (e, st) =>
          emit(BlocCalificacionesMensualesEstadoFallido.desde(state)),
    );
  }
}
