import 'package:bloc/bloc.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/utilidades/funciones/funciones.dart';
import 'package:flutter/material.dart';

part 'bloc_asistencias_evento.dart';
part 'bloc_asistencias_estado.dart';

// TODO(GON/ANYONE): Renombrar a BlocInasistencias ? junto con sus referencias.

/// {@template BlocAsistencias}
/// BLoC que maneja el estado y la lógica general de la pagina 'Inasistencias'
/// {@endtemplate}
class BlocAsistencias
    extends Bloc<BlocAsistenciasEvento, BlocAsistenciasEstado> {
  /// {@macro BlocAsistencias}
  BlocAsistencias() : super(const BlocAsistenciasEstadoInicial()) {
    on<BlocAsistenciasEventoInicializar>(_onInicializar);
    on<BlocAsistenciasEventoCambiarEstadoAsistencia>(
      _onCambiarEstadoDeAsistencia,
    );
    on<BlocAsistenciasEventoAbrirCurso>(_onAbrirCurso);
    on<BlocAsistenciasFinalizarAsistencia>(_onFinalizarAsistencia);
  }

  /// Al inicializar trae los cursos para tomar asistencias.
  Future<void> _onInicializar(
    BlocAsistenciasEventoInicializar event,
    Emitter<BlocAsistenciasEstado> emit,
  ) async {
    // TODO(mati): agregar funcion del back de traer los cursos
    emit(BlocAsistenciasEstadoCargando.desde(state));
    await operacionBloc(
      callback: () async {
        final alumnos = [
          ModeloAlumno(
            id: 1,
            nombre: 'Gonzalo Miguel Rigoni',
            asistencia: EstadoAsistencia.sinAsistencia,
          ),
          ModeloAlumno(
            id: 2,
            nombre: 'Pipe Cortes',
            asistencia: EstadoAsistencia.sinAsistencia,
          ),
          ModeloAlumno(
            id: 3,
            nombre: 'andreas el louka',
            asistencia: EstadoAsistencia.sinAsistencia,
          ),
          ModeloAlumno(
            id: 4,
            nombre: 'chivardo ',
            asistencia: EstadoAsistencia.sinAsistencia,
          ),
          ModeloAlumno(
            id: 5,
            nombre: 'juanjo tira server ',
            asistencia: EstadoAsistencia.sinAsistencia,
          ),
          ModeloAlumno(
            id: 6,
            nombre: 'Sebas el montero',
            asistencia: EstadoAsistencia.sinAsistencia,
          ),
          ModeloAlumno(
            id: 7,
            nombre: 'Manu Monayano sindicato de nidus',
            asistencia: EstadoAsistencia.sinAsistencia,
          ),
          ModeloAlumno(
            id: 8,
            nombre: 'mati el sr alegría',
            asistencia: EstadoAsistencia.sinAsistencia,
          ),
        ];
        final alumnos2 = [
          ModeloAlumno(
            id: 9,
            nombre: 'Gonzalo Miguel Rigoni',
            asistencia: EstadoAsistencia.sinAsistencia,
          ),
          ModeloAlumno(
            id: 10,
            nombre: 'Pipe Cortes',
            asistencia: EstadoAsistencia.sinAsistencia,
          ),
          ModeloAlumno(
            id: 11,
            nombre: 'andreas el louka',
            asistencia: EstadoAsistencia.sinAsistencia,
          ),
          ModeloAlumno(
            id: 12,
            nombre: 'chivardo ',
            asistencia: EstadoAsistencia.sinAsistencia,
          ),
          ModeloAlumno(
            id: 13,
            nombre: 'juanjo tira server ',
            asistencia: EstadoAsistencia.sinAsistencia,
          ),
          ModeloAlumno(
            id: 14,
            nombre: 'Sebas el montero',
            asistencia: EstadoAsistencia.sinAsistencia,
          ),
          ModeloAlumno(
            id: 15,
            nombre: 'Manu Monayano sindicato de nidus',
            asistencia: EstadoAsistencia.sinAsistencia,
          ),
          ModeloAlumno(
            id: 16,
            nombre: 'mati el sr alegría',
            asistencia: EstadoAsistencia.sinAsistencia,
          ),
        ];
        final cursos = [
          ModeloCurso(
            id: 1,
            alumnos: [
              ...alumnos,
              ...alumnos,
              ...alumnos,
              ...alumnos,
              ...alumnos,
            ],
            nombre: 'Primero A',
            esVisible: true,
          ),
          ModeloCurso(
            id: 2,
            alumnos: alumnos2,
            nombre: 'Primero B',
            esVisible: true,
          ),
          ModeloCurso(
            id: 3,
            alumnos: alumnos2,
            nombre: 'Segundo',
            esVisible: true,
          ),
          ModeloCurso(
            id: 4,
            alumnos: alumnos,
            nombre: 'Tercero',
            esVisible: true,
          ),
          ModeloCurso(
            id: 5,
            alumnos: alumnos,
            nombre: 'Cuarto',
            esVisible: true,
          ),
          ModeloCurso(
            id: 6,
            alumnos: alumnos,
            nombre: 'Quinto',
            esVisible: true,
          ),
          ModeloCurso(
            id: 7,
            alumnos: alumnos,
            nombre: 'Sexto',
            esVisible: true,
          ),
        ];

        emit(
          BlocAsistenciasEstadoExitoso.desde(
            state,
            cursos: [
              ...cursos,
              ...cursos,
              ...cursos,
              ...cursos,
            ],
          ),
        );
      },
      onError: (e, st) => emit(BlocAsistenciasEstadoFallido.desde(state)),
    );
  }

  /// Cambia el estado de un alumno de un curso
  Future<void> _onCambiarEstadoDeAsistencia(
    BlocAsistenciasEventoCambiarEstadoAsistencia event,
    Emitter<BlocAsistenciasEstado> emit,
  ) async {
    await operacionBloc(
      callback: () async {
        // TODO(mati): agregar el evento del back que se le mande la lista con
        //todos los cursos a cambiar el estado de esos alumnos
        final cursos = state.cursos;
        final curso =
            cursos.firstWhere((element) => element.id == event.idCurso);

        curso.alumnos
            .firstWhere((element) => element.id == event.idAlumno)
            .asistencia = event.estado.cambiarEstado();

        emit(
          BlocAsistenciasEstadoExitoso.desde(
            state,
            cursos: cursos,
          ),
        );
      },
      onError: (e, st) => emit(BlocAsistenciasEstadoFallido.desde(state)),
    );
  }

  /// Abre el desplegable de un curso dependiendo del index.
  Future<void> _onAbrirCurso(
    BlocAsistenciasEventoAbrirCurso event,
    Emitter<BlocAsistenciasEstado> emit,
  ) async {
    state.cursos[event.index].esVisible = event.estaDesplegado;

    emit(
      BlocAsistenciasEstadoExitoso.desde(
        state,
        cursos: state.cursos,
        index: event.index,
      ),
    );
  }

  /// Cuando se pasa asistencia en dicho curso cambia el estado si se paso
  /// asistencia
  Future<void> _onFinalizarAsistencia(
    BlocAsistenciasFinalizarAsistencia event,
    Emitter<BlocAsistenciasEstado> emit,
  ) async {
    //TODO(mati): en caso de que el modelo tenga un parametro que diga si se
    //pasoasistencia o no, cambiarlo hacer un operacion bloc en dicho caso.

    final cursos = List<ModeloCurso>.from(state.cursos);
    cursos.firstWhere((curso) => curso.id == event.idCurso).sePasoAsistencia =
        true;
    emit(
      BlocAsistenciasEstadoExitoso.desde(
        state,
        cursos: cursos,
        index: state.index,
      ),
    );
  }
}

// TODO(seba/gon): sacar los modelos estan super hard y reemplazar por los del back
class ModeloCurso {
  ModeloCurso({
    required this.id,
    required this.nombre,
    required this.alumnos,
    this.sePasoAsistencia = false,
    this.esVisible,
  });

  final int id;
  final String nombre;
  final List<ModeloAlumno> alumnos;
  bool? esVisible;
  bool sePasoAsistencia;

  int cantidadDeNoAusentes() {
    return alumnos
        .where(
          (element) =>
              element.asistencia != EstadoAsistencia.ausente &&
              element.asistencia != EstadoAsistencia.sinAsistencia,
        )
        .length;
  }

  bool alumnosSinAsistencias() {
    return alumnos
            .where(
              (element) => element.asistencia != EstadoAsistencia.sinAsistencia,
            )
            .length ==
        alumnos.length;
  }
}

class ModeloAlumno {
  ModeloAlumno({
    required this.id,
    required this.nombre,
    required this.asistencia,
    this.calificacion,
  });
  final String nombre;
  final int id;
  EstadoAsistencia asistencia;
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

enum EstadoAsistencia {
  presente,
  ausente,
  mediaFalta,
  cuartoFalta,
  sinAsistencia;

  Color colorEstado(BuildContext context) {
    final colores = context.colores;

    return switch (this) {
      EstadoAsistencia.presente => colores.verdeConfirmar,
      EstadoAsistencia.mediaFalta => colores.amarilloCuartoFalta,
      EstadoAsistencia.cuartoFalta => colores.naranjaTEP,
      EstadoAsistencia.ausente => colores.rojoTED,
      _ => colores.grisSC,
    };
  }

  String nombreEstado(BuildContext context) {
    final l10n = context.l10n;

    return switch (this) {
      EstadoAsistencia.presente => l10n.commonPresent,
      EstadoAsistencia.ausente => l10n.commonAbsent,
      EstadoAsistencia.mediaFalta => l10n.commonHalfAbsence,
      EstadoAsistencia.cuartoFalta => l10n.commonFourthMissing,
      _ => l10n.commonUndefined,
    };
  }

  EstadoAsistencia cambiarEstado() {
    return switch (this) {
      EstadoAsistencia.sinAsistencia => EstadoAsistencia.presente,
      EstadoAsistencia.presente => EstadoAsistencia.mediaFalta,
      EstadoAsistencia.mediaFalta => EstadoAsistencia.cuartoFalta,
      EstadoAsistencia.cuartoFalta => EstadoAsistencia.ausente,
      EstadoAsistencia.ausente => EstadoAsistencia.presente,
    };
  }
}
