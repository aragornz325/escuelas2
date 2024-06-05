import 'package:bloc/bloc.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/inasistencias/modelos/comision_con_asistencias.dart';
import 'package:flutter/material.dart';

part 'bloc_inasistencias_evento.dart';
part 'bloc_inasistencias_estado.dart';

/// {@template BlocInasistencias}
/// BLoC que maneja el estado y la lógica general de la pagina 'Inasistencias'
/// {@endtemplate}
class BlocInasistencias
    extends Bloc<BlocInasistenciasEvento, BlocInasistenciasEstado> {
  /// {@macro BlocInasistencias}
  BlocInasistencias() : super(const BlocInasistenciasEstadoInicial()) {
    on<BlocInasistenciasEventoInicializar>(_onInicializar);
    on<BlocInasistenciasEventoCrearInasistencias>(_onCrearInasistencias);
    on<BlocInasistenciasEventoEditarInasistencias>(_onEditarInasistencias);
  }

  /// Al inicializar trae los cursos para tomar inasistencias.
  Future<void> _onInicializar(
    BlocInasistenciasEventoInicializar event,
    Emitter<BlocInasistenciasEstado> emit,
  ) async {
    emit(BlocInasistenciasEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        final comisiones = await client.comision.obtenerComisiones();

        final inasistencias = await client.asistencia.traerAsistenciaPorDia(
          fecha: event.fecha,
        );

        if (inasistencias.isNotEmpty) {
          final listaDeInasistencias = _obtenerInasistenciasPorComision(
            comisiones,
            inasistencias,
            event.fecha,
          );

          return emit(
            BlocInasistenciasEstadoExitoso.desde(
              state,
              fechaActual: event.fecha,
              comisionesConAsistencias: listaDeInasistencias,
            ),
          );
        }

        final comisionesConAsistencias = <ComisionConAsistencias>[];

        for (final comision in comisiones) {
          final listaAsistenciaDiaria = comision.estudiantes?.map(
            (relacionComisionUsuario) {
              return AsistenciaDiaria(
                estudianteId: relacionComisionUsuario.usuario?.id ?? 0,
                estudiante: relacionComisionUsuario.usuario,
                comisionId: comision.id ?? 0,
                comision: comision,
                estadoDeAsistencia: EstadoDeAsistencia.sinEstado,
                fecha: event.fecha,
              );
            },
          ).toList();

          comisionesConAsistencias.add(
            ComisionConAsistencias(
              comisionDeCurso: comision,
              inasistenciasDelCurso: listaAsistenciaDiaria ?? [],
            ),
          );
        }

        emit(
          BlocInasistenciasEstadoExitoso.desde(
            state,
            fechaActual: event.fecha,
            comisionesConAsistencias: comisionesConAsistencias,
          ),
        );
      },
      onError: (e, st) => emit(BlocInasistenciasEstadoFallido.desde(state)),
    );
  }

  /// Cuando se pasa inasistencia en dicho curso cambia el estado si se paso
  /// asistencia
  Future<void> _onCrearInasistencias(
    BlocInasistenciasEventoCrearInasistencias event,
    Emitter<BlocInasistenciasEstado> emit,
  ) async {
    emit(BlocInasistenciasEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        if (event.inasistencias.isEmpty) {
          return emit(BlocInasistenciasEstadoExitoso.desde(state));
        }

        final asistenciasCreadas =
            await client.asistencia.crearAsistenciasEnLote(
          asistencias: event.inasistencias,
        );

        final comisionesConAsistencias = List<ComisionConAsistencias>.from(
          state.comisionesConAsistencias.map(
            (comisionConAsistencias) {
              return comisionConAsistencias.comisionDeCurso.id ==
                      event.idComision
                  ? ComisionConAsistencias(
                      comisionDeCurso: comisionConAsistencias.comisionDeCurso,
                      inasistenciasDelCurso: asistenciasCreadas,
                    )
                  : comisionConAsistencias;
            },
          ),
        );

        return emit(
          BlocInasistenciasEstadoExitoso.desde(
            state,
            comisionesConAsistencias: comisionesConAsistencias,
          ),
        );
      },
      onError: (e, st) => emit(BlocInasistenciasEstadoFallido.desde(state)),
    );
  }

  Future<void> _onEditarInasistencias(
    BlocInasistenciasEventoEditarInasistencias event,
    Emitter<BlocInasistenciasEstado> emit,
  ) async {
    emit(BlocInasistenciasEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        if (event.inasistencias.isEmpty) {
          return emit(BlocInasistenciasEstadoExitoso.desde(state));
        }

        final asistencias = await client.asistencia.actualizarAsistenciasEnLote(
          asistencias: event.inasistencias,
        );

        final asistenciasConEstudiante = asistencias.map((asistencia) {
          final asistenciaOriginal = event.inasistencias.firstWhere(
            (e) => e.estudianteId == asistencia.estudianteId,
          );
          if (asistenciaOriginal.id == null) {
            asistencia
              ..estudiante = asistenciaOriginal.estudiante
              ..id = asistenciaOriginal.id;
          }
          asistencia.estudiante = asistenciaOriginal.estudiante;

          return asistencia;
        }).toList();

        final comisionesConAsistencias = List<ComisionConAsistencias>.from(
          state.comisionesConAsistencias.map(
            (comisionConAsistencias) {
              return comisionConAsistencias.comisionDeCurso.id ==
                      event.idComision
                  ? ComisionConAsistencias(
                      comisionDeCurso: comisionConAsistencias.comisionDeCurso,
                      inasistenciasDelCurso: asistenciasConEstudiante,
                    )
                  : comisionConAsistencias;
            },
          ),
        );

        return emit(
          BlocInasistenciasEstadoExitoso.desde(
            state,
            comisionesConAsistencias: comisionesConAsistencias,
          ),
        );
      },
      onError: (e, st) => emit(BlocInasistenciasEstadoFallido.desde(state)),
    );
  }
}

/// Obtiene las inasistencias de cada comision para la fecha dada
List<ComisionConAsistencias> _obtenerInasistenciasPorComision(
  List<ComisionDeCurso> comisiones,
  List<AsistenciaDiaria> inasistencias,
  DateTime fecha,
) {
  // Crear una lista para almacenar las asistencias por comisión
  final asistenciasPorComision = <ComisionConAsistencias>[];

  // Iterar a través de cada comisión
  for (final comision in comisiones) {
    // Obtener las asistencias de esa comisión para la fecha dada
    final estudiantes = comision.estudiantes;
    if (estudiantes != null) {
      final asistenciasComision = <AsistenciaDiaria>[];

      for (final relacionComisionUsuario in estudiantes) {
        final asistenciaEnFecha = inasistencias.firstWhere(
          (asistencia) =>
              asistencia.fecha.year == fecha.year &&
              asistencia.fecha.month == fecha.month &&
              asistencia.fecha.day == fecha.day &&
              asistencia.estudiante?.id == relacionComisionUsuario.usuario?.id,
          orElse: () {
            // Crear una asistencia predeterminada si no se encuentra una
            // asistencia
            return AsistenciaDiaria(
              estudianteId: relacionComisionUsuario.usuario?.id ?? 0,
              estudiante: relacionComisionUsuario.usuario,
              comisionId: comision.id ?? 0,
              comision: comision,
              estadoDeAsistencia: EstadoDeAsistencia.sinEstado,
              fecha: fecha,
            );
          },
        );

        // Agregar la asistencia al resultado
        asistenciasComision.add(asistenciaEnFecha);
      }

      // Agregar las asistencias a la lista
      asistenciasPorComision.add(
        ComisionConAsistencias(
          comisionDeCurso: comision,
          inasistenciasDelCurso: asistenciasComision,
        ),
      );
    }
  }

  return asistenciasPorComision;
}
