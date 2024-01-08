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
  }

  /// Trae las materias asignadas al usuario y las ordena por curso
  Future<void> _inicializar(
    BlocMisCursosEventoInicializar event,
    Emitter<BlocMisCursosEstado> emit,
  ) async {
    emit(BlocMisCursosEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        // final materias = await client.traermaterias;
        // TODO(Gon): Eliminar hardcodeo y usar endpoint
        //TODO ver si son estos
        // final cursos = await client.curso.obtenerCursos();

        final asignaturas = [
          Asignatura(
            id: 1,
            nombre: 'matematica',
            fechaCreacion: DateTime.now(),
            idCurso: 1,
            ultimaModificacion: DateTime.now(),
            fechaEliminacion: DateTime.now(),
          ),
          Asignatura(
            id: 2,
            nombre: 'ingenieria',
            fechaCreacion: DateTime.now(),
            idCurso: 1,
            ultimaModificacion: DateTime.now(),
            fechaEliminacion: DateTime.now(),
          ),
        ];
        final asignaturas2 = [
          Asignatura(
            id: 3,
            nombre: 'inglish',
            fechaCreacion: DateTime.now(),
            idCurso: 2,
            ultimaModificacion: DateTime.now(),
            fechaEliminacion: DateTime.now(),
          ),
          Asignatura(
            id: 4,
            nombre: 'comunicacion',
            fechaCreacion: DateTime.now(),
            idCurso: 2,
            ultimaModificacion: DateTime.now(),
            fechaEliminacion: DateTime.now(),
          ),
        ];

        final cursos = [
          Curso(
            nombre: 'Primero',
            asignaturas: asignaturas,
            fechaCreacion: DateTime.now(),
            ultimaModificacion: DateTime.now(),
            fechaEliminacion: DateTime.now(),
            id: 1,
          ),
          Curso(
            nombre: 'segundo',
            asignaturas: asignaturas2,
            fechaCreacion: DateTime.now(),
            ultimaModificacion: DateTime.now(),
            fechaEliminacion: DateTime.now(),
            id: 2,
          ),
        ];
        emit(
          BlocMisCursosEstadoExitoso.desde(
            state,
            cursos: cursos,
          ),
        );
      },
      onError: (e, st) {
        emit(BlocMisCursosEstadoError.desde(state));
      },
    );
  }
}
