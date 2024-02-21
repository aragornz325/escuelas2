import 'package:bloc/bloc.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:flutter/material.dart';

part 'bloc_calificaciones_anuales_evento.dart';
part 'bloc_calificaciones_anuales_estado.dart';

/// {@template BlocCalificacionesAnuales}
/// BLoC que maneja el estado y la lógica general de la pagina
/// 'CalificacionesAnuales'
/// {@endtemplate}
class BlocCalificacionesAnuales extends Bloc<BlocCalificacionesAnualesEvento,
    BlocCalificacionesAnualesEstado> {
  /// {@macro BlocCalificacionesAnuales}
  BlocCalificacionesAnuales()
      : super(const BlocCalificacionesAnualesEstadoInicial()) {
    on<BlocCalificacionesAnualesEventoInicializar>(_onInicializar);
  }

  /// Al inicializar trae los cursos para tomar CalificacionesAnuales.
  Future<void> _onInicializar(
    BlocCalificacionesAnualesEventoInicializar event,
    Emitter<BlocCalificacionesAnualesEstado> emit,
  ) async {
    emit(BlocCalificacionesAnualesEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        final anio = event.anio;

        final idAsignatura = event.idAsignatura;

        final listaCalificacionesAnuales = await client.calificacion
            .listarMisCalificacionesAnualesPorAsignatura(
          anio: anio,
          idAsignatura: idAsignatura,
        );

        emit(
          BlocCalificacionesAnualesEstadoExitoso.desde(
            state,
            listaCalificacionesAnuales: listaCalificacionesAnuales,
          ),
        );
      },
      onError: (e, st) =>
          emit(BlocCalificacionesAnualesEstadoFallido.desde(state)),
    );
  }
}
