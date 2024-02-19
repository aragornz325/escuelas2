import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_mis_cursos_estado.dart';
part 'bloc_mis_cursos_evento.dart';

/// {@template BlocMisCursos}
/// Bloc que maneja los estados y lógica de la pagina de 'Mis Cursos'
/// {@endtemplate}
class BlocMisCursos extends Bloc<BlocMisCursosEvento, BlocMisCursosEstado> {
  /// {@macro BlocMisCursos}
  BlocMisCursos() : super(const BlocMisCursosEstadoInicial()) {
    on<BlocMisCursosEventoInicializar>(_inicializar);
    on<BlocMisCursosEventoCambiarMes>(_cambiarMes);

    on<BlocMisCursosEventoInicializarDirectivo>(_inicializarDirectivo);
  }

  /// Trae las materias asignadas al usuario y las ordena por curso
  Future<void> _inicializar(
    BlocMisCursosEventoInicializar event,
    Emitter<BlocMisCursosEstado> emit,
  ) async {
    emit(BlocMisCursosEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        final comisiones = await client.calificacion
            .obtenerInformacionDeVistaGeneralDeComisiones(
          numeroDeMes: DateTime.now().month,
          idUsuario: event.usuarioId,
        );

        emit(
          BlocMisCursosEstadoExitoso.desde(
            state,
            comisiones: comisiones,
          ),
        );
      },
      onError: (e, st) {
        emit(BlocMisCursosEstadoError.desde(state));
      },
    );
  }

  /// Trae las materias asignadas al usuario y las ordena por curso
  Future<void> _cambiarMes(
    BlocMisCursosEventoCambiarMes event,
    Emitter<BlocMisCursosEstado> emit,
  ) async {
    emit(BlocMisCursosEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        final comisiones = await client.calificacion
            .obtenerInformacionDeVistaGeneralDeComisiones(
          numeroDeMes: event.periodoSeleccionada.month,
          idUsuario: event.usuarioId,
        );

        emit(
          BlocMisCursosEstadoExitoso.desde(
            state,
            comisiones: comisiones,
          ),
        );
      },
      onError: (e, st) {
        emit(BlocMisCursosEstadoError.desde(state));
      },
    );
  }

  /// Trae las materias asignadas al usuario y las ordena por curso
  Future<void> _inicializarDirectivo(
    BlocMisCursosEventoInicializarDirectivo event,
    Emitter<BlocMisCursosEstado> emit,
  ) async {
    emit(BlocMisCursosEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        final comisionesConAsignaturas =
            await client.comision.listarComisionesConAsignaturas();

        emit(
          BlocMisCursosEstadoExitoso.desde(
            state,
            comisionesConAsignaturas: comisionesConAsignaturas,
          ),
        );
      },
      onError: (e, st) {
        emit(BlocMisCursosEstadoError.desde(state));
      },
    );
  }
}
