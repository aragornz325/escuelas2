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
        final alumnos = [
          Usuario(
            idUserInfo: 1,
            roles: [],
            dni: '1',
            ultimaModificacion: DateTime.now(),
            fechaCreacion: DateTime.now(),
            nombre: 'gonzalo',
            apellido: 'higuain',
            urlFotoDePerfil: 'https://picsum.photos/200/300',
          ),
          Usuario(
            idUserInfo: 2,
            roles: [],
            dni: '2',
            ultimaModificacion: DateTime.now(),
            fechaCreacion: DateTime.now(),
            nombre: 'gonzalo',
            apellido: 'higuain',
            urlFotoDePerfil: 'https://picsum.photos/200/300',
          ),
          Usuario(
            idUserInfo: 3,
            roles: [],
            dni: '3',
            ultimaModificacion: DateTime.now(),
            fechaCreacion: DateTime.now(),
            nombre: 'gonzalo',
            apellido: 'higuain',
            urlFotoDePerfil: 'https://picsum.photos/200/300',
          ),
          Usuario(
            idUserInfo: 4,
            roles: [],
            dni: '4',
            ultimaModificacion: DateTime.now(),
            fechaCreacion: DateTime.now(),
            nombre: 'gonzalo',
            apellido: 'higuain',
            urlFotoDePerfil: 'https://picsum.photos/200/300',
          ),
          Usuario(
            idUserInfo: 5,
            roles: [],
            dni: '5',
            ultimaModificacion: DateTime.now(),
            fechaCreacion: DateTime.now(),
            nombre: 'gonzalo',
            apellido: 'higuain',
            urlFotoDePerfil: 'https://picsum.photos/200/300',
          ),
          Usuario(
            idUserInfo: 6,
            roles: [],
            dni: '6',
            ultimaModificacion: DateTime.now(),
            fechaCreacion: DateTime.now(),
            nombre: 'gonzalo',
            apellido: 'higuain',
            urlFotoDePerfil: 'https://picsum.photos/200/300',
          ),
        ];

        final cursos = [
          ComisionDeCurso(
            nombre: 'Primero',
            idCurso: 1,
            anioLectivo: 2023,
            estudiantes: alumnos,
            ultimaModificacion: DateTime(2024, 1, 4),
            fechaCreacion: DateTime.now(),
          ),
          ComisionDeCurso(
            nombre: 'Segundo',
            idCurso: 2,
            anioLectivo: 2023,
            estudiantes: alumnos,
            ultimaModificacion: DateTime(2024, 1, 4),
            fechaCreacion: DateTime.now(),
          ),
          ComisionDeCurso(
            nombre: 'Tercero',
            idCurso: 3,
            anioLectivo: 2023,
            estudiantes: alumnos,
            ultimaModificacion: DateTime(2024, 1, 4),
            fechaCreacion: DateTime.now(),
          ),
          ComisionDeCurso(
            nombre: 'Cuarto',
            idCurso: 5,
            anioLectivo: 2023,
            estudiantes: alumnos,
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

        for (var curso in cursos) {
          final listaAsistenciaDiaria = curso.estudiantes.map(
            (estudiante) {
              return AsistenciaDiaria(
                idEstudiante: estudiante.idUserInfo,
                idAsignatura: 0,
                idComision:
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
              (lista) => lista.where((e) => e.idComision == event.idCurso),
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
          (lista) => lista.where((e) => e.idComision == curso.idCurso),
        )
        .toList()
        .firstWhere(
          (asistencia) => asistencia.idEstudiante == event.idAlumno,
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
