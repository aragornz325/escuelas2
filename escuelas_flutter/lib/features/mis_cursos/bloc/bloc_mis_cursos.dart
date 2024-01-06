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
      callback: () async {
        // final materias = await client.traermaterias;
        // TODO(Gon): Eliminar hardcodeo y usar endpoint
        final materias = [
          Asignatura(
            nombre: 'MATEMMATEMATICAMATEMATICAMATEMATICAATICA',
            id: 0,
            idCurso: 0,
            docentes: [],
            fechaCreacion: DateTime.now(),
            ultimaModificacion: DateTime.now(),
          ),
          Asignatura(
            nombre: 'LENGUALENGUALENGUALENGUALENGUALENGUALENGUALENGUA',
            id: 1,
            idCurso: 1,
            docentes: [],
            fechaCreacion: DateTime.now(),
            ultimaModificacion: DateTime.now(),
          ),
          Asignatura(
            nombre:
                'SOCIALESSOCIALESSOCIALESSOCIALESSOCIALESSOCIALESSOCIALESSOCIA',
            id: 2,
            idCurso: 1,
            docentes: [],
            fechaCreacion: DateTime.now(),
            ultimaModificacion: DateTime.now(),
          ),
        ];

        final cursos = <int, List<Asignatura>>{};

        for (final materia in materias) {
          cursos.putIfAbsent(materia.idCurso, () => []);
          cursos[materia.idCurso]!.add(materia);
        }

        emit(
          BlocMisCursosEstadoExitoso.desde(
            state,
            listaCursosConMaterias: cursos,
          ),
        );
      },
      onError: (e, st) {
        emit(BlocMisCursosEstadoError.desde(state));
      },
    );
  }
}
