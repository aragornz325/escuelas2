import 'package:escuelas_flutter/extensiones/extension_bloc.dart';
import 'package:escuelas_flutter/features/modelos_temporales.dart';
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
          Materia(
              nombre: 'MATEMMATEMATICAMATEMATICAMATEMATICAATICA',
              id: 0,
              idCurso: 0),
          Materia(
              nombre: 'LENGUALENGUALENGUALENGUALENGUALENGUALENGUALENGUA',
              id: 1,
              idCurso: 1),
          Materia(
              nombre:
                  'SOCIALESSOCIALESSOCIALESSOCIALESSOCIALESSOCIALESSOCIALESSOCIALESSOCIALESSOCIALESSOCIALES',
              id: 2,
              idCurso: 1),
          Materia(nombre: 'NATURALES', id: 3, idCurso: 0),
          Materia(nombre: 'NATURALES', id: 3, idCurso: 2),
          Materia(nombre: 'LATIN', id: 3, idCurso: 2),
          Materia(nombre: 'NATURALES', id: 3, idCurso: 2),
          Materia(nombre: 'LENGUA', id: 1, idCurso: 1),
          Materia(nombre: 'SOCIALES', id: 2, idCurso: 1),
          Materia(nombre: 'NATURALES', id: 3, idCurso: 0),
          Materia(nombre: 'NATURALES', id: 3, idCurso: 2),
          Materia(nombre: 'LATIN', id: 3, idCurso: 2),
          Materia(nombre: 'NATURALES', id: 3, idCurso: 2),
          Materia(nombre: 'LENGUA', id: 1, idCurso: 1),
          Materia(nombre: 'SOCIALES', id: 2, idCurso: 1),
          Materia(nombre: 'NATURALES', id: 3, idCurso: 0),
          Materia(nombre: 'NATURALES', id: 3, idCurso: 2),
          Materia(nombre: 'LATIN', id: 3, idCurso: 2),
          Materia(nombre: 'NATURALES', id: 3, idCurso: 2),
          Materia(nombre: 'LATIN', id: 3, idCurso: 2),
        ];

        final cursos = <int, List<Materia>>{};

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
