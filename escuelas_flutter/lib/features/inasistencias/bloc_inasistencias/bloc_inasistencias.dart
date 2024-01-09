import 'package:bloc/bloc.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:flutter/material.dart';

part 'bloc_inasistencias_evento.dart';
part 'bloc_inasistencias_estado.dart';

// TODO(anyone): Renombrar a BlocInasistencias ? junto con sus referencias.

/// {@template BlocInasistencias}
/// BLoC que maneja el estado y la lógica general de la pagina 'Inasistencias'
/// {@endtemplate}
class BlocInasistencias
    extends Bloc<BlocInasistenciasEvento, BlocInasistenciasEstado> {
  /// {@macro BlocInasistencias}
  BlocInasistencias() : super(const BlocInasistenciasEstadoInicial()) {
    on<BlocInasistenciasEventoInicializar>(_onInicializar);
    on<BlocAsistenciaEventoCambiarInasistenciaAlumno>(
      _onCambiarInasistenciaAlumno,
    );

    on<BlocInasistenciasEventoFinalizarInasistencias>(_onFinalizarAsistencia);
  }

  /// Al inicializar trae los cursos para tomar asistencias.
  Future<void> _onInicializar(
    BlocInasistenciasEventoInicializar event,
    Emitter<BlocInasistenciasEstado> emit,
  ) async {
    // TODO(mati): agregar funcion del back de traer los cursos ver que no te devuelva la lista de inasistencias
    emit(BlocInasistenciasEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        ///TODO(anyone): llamar al endpoint de traer cursos

        final cursos = [
          ComisionDeCurso(
            nombre: 'Primero',
            idCurso: 1,
            anioLectivo: 2023,
            estudiantes: [],
            ultimaModificacion: DateTime(2024, 1, 4),
            fechaCreacion: DateTime.now(),
          ),
          ComisionDeCurso(
            nombre: 'Segundo',
            idCurso: 2,
            anioLectivo: 2023,
            estudiantes: [],
            ultimaModificacion: DateTime(2024, 1, 4),
            fechaCreacion: DateTime.now(),
          ),
          ComisionDeCurso(
            nombre: 'Tercero',
            idCurso: 3,
            anioLectivo: 2023,
            estudiantes: [],
            ultimaModificacion: DateTime(2024, 1, 4),
            fechaCreacion: DateTime.now(),
          ),
          ComisionDeCurso(
            nombre: 'Cuarto',
            idCurso: 5,
            anioLectivo: 2023,
            estudiantes: [],
            ultimaModificacion: DateTime(2024, 1, 4),
            fechaCreacion: DateTime.now(),
          ),
          ComisionDeCurso(
            nombre: 'Quinto',
            idCurso: 5,
            anioLectivo: 2023,
            estudiantes: [],
            ultimaModificacion: DateTime(2024, 1, 4),
            fechaCreacion: DateTime.now(),
          ),
        ];

        final listasDeAsistencia = <List<AsistenciaDiaria>>[];

        for (final curso in cursos) {
          final estudiantes = curso.estudiantes ?? [];
          final listaAsistenciaDiaria = estudiantes.map(
            (estudiante) {
              return AsistenciaDiaria(
                estudianteId: estudiante.usuarioId,
                comisionId:
                    curso.idCurso, // Usar el ID del curso como identificador
                estadoDeAsistencia: EstadoDeAsistencia.sinEstado,
                fecha: DateTime.now(),
                idJustificacion: 0,
                ultimaModificacion: DateTime.now(),
                fechaCreacion: DateTime.now(),
              );
            },
          ).toList();

          listasDeAsistencia.add(listaAsistenciaDiaria);
        }

        emit(
          BlocInasistenciasEstadoExitoso.desde(
            state,
            asistencias: listasDeAsistencia,
            cursos: cursos,
          ),
        );
      },
      onError: (e, st) => emit(BlocInasistenciasEstadoFallido.desde(state)),
    );
  }

  /// Cuando se pasa asistencia en dicho curso cambia el estado si se paso
  /// asistencia
  Future<void> _onFinalizarAsistencia(
    BlocInasistenciasEventoFinalizarInasistencias event,
    Emitter<BlocInasistenciasEstado> emit,
  ) async {
    await operacionBloc(
      callback: (client) async {
        final asistenciasDiarias = state.asistencias
            .expand(
              (lista) => lista.where((e) => e.comisionId == event.idCurso),
            )
            .toList();

        await client.asistencia
            .crearAsistenciasEnLote(asistencias: asistenciasDiarias);

        final cursos = List<ComisionDeCurso>.from(state.cursos);

        cursos
            .firstWhere(
              (curso) => curso.idCurso == event.idCurso,
            )
            .ultimaModificacion = event.fecha;

        emit(
          BlocInasistenciasEstadoExitoso.desde(
            state,
            cursos: cursos,
            index: state.index,
          ),
        );
      },
      onError: (e, st) => emit(BlocInasistenciasEstadoFallido.desde(state)),
    );
  }

  /// Cambia la inasistencia de un alumno
  void _onCambiarInasistenciaAlumno(
    BlocAsistenciaEventoCambiarInasistenciaAlumno event,
    Emitter<BlocInasistenciasEstado> emit,
  ) {
    final cursos = List<ComisionDeCurso>.from(state.cursos);

    final curso = cursos.firstWhere((curso) => curso.idCurso == event.idCurso);

    state.asistencias
        .expand(
          (lista) => lista.where((e) => e.comisionId == curso.idCurso),
        )
        .toList()
        .firstWhere(
          (asistencia) => asistencia.estudianteId == event.idAlumno,
        )
        .estadoDeAsistencia = event.asistenciaDiaria;

    emit(
      BlocInasistenciasEstadoExitoso.desde(
        state,
        cursos: cursos,
        index: state.index,
        asistencias: state.asistencias,
      ),
    );
  }
}

// TODO(seba/gon): sacar los modelos estan super hard y reemplazar por los del back

class ModeloAlumno {
  ModeloAlumno({
    required this.id,
    required this.nombre,
    this.calificacion,
  });
  final String nombre;
  final int id;
  int? calificacion;
}

class ModeloCalificacion {
  ModeloCalificacion({
    required this.id,
    required this.fecha,
    this.alumnos = const [],
  });

  final DateTime fecha;
  List<ModeloAlumno> alumnos;
  final int id;
}
