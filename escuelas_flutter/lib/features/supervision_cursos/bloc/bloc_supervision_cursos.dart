import 'package:escuelas_flutter/extensiones/extension_bloc.dart';
import 'package:escuelas_flutter/features/modelos_temporales.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_supervision_cursos_estado.dart';
part 'bloc_supervision_cursos_evento.dart';

/// {@template BlocSupervisionCursos}
/// Bloc que maneja los estados y lógica de la pagina de 'Inicio'
/// {@endtemplate}
class BlocSupervisionCursos
    extends Bloc<BlocSupervisionCursosEvento, BlocSupervisionCursosEstado> {
  /// {@macro BlocInicio}
  BlocSupervisionCursos() : super(const BlocSupervisionCursosEstadoInicial()) {
    on<BlocSupervisionCursosEventoInicializar>(_inicializar);
    add(BlocSupervisionCursosEventoInicializar());
  }

  Future<void> _inicializar(
    BlocSupervisionCursosEventoInicializar event,
    Emitter<BlocSupervisionCursosEstado> emit,
  ) async {
    emit(BlocSupervisionCursosEstadoCargando.desde(state));
    await operacionBloc(
      callback: () {
        // final listaCursos = await client.traercursos;
        emit(
          BlocSupervisionCursosEstadoExitoso.desde(
            state,
            listaCursos: [
              CursosPorPeriodo(
                desde: DateTime.now().copyWith(month: DateTime.now().month - 1),
                hasta: DateTime.now(),
                cursos: [
                  Curso(nombre: 'Primero', id: 0),
                  Curso(nombre: 'Segundo', id: 1),
                  Curso(nombre: 'Tercero', id: 2),
                  Curso(nombre: 'Cuarto', id: 3),
                  Curso(nombre: 'Quinto', id: 4),
                  Curso(nombre: 'Sexto', id: 5),
                ],
              ),
              CursosPorPeriodo(
                desde: DateTime.now(),
                hasta: DateTime.now().copyWith(month: DateTime.now().month + 1),
                cursos: [
                  Curso(nombre: 'Primero', id: 0),
                  Curso(nombre: 'Segundo', id: 1),
                  Curso(nombre: 'Tercero', id: 2),
                  Curso(nombre: 'Cuarto', id: 3),
                  Curso(nombre: 'Quinto', id: 4),
                  Curso(nombre: 'Sexto', id: 5),
                ],
              ),
            ],
          ),
        );
      },
      onError: (e, st) => emit(
        BlocSupervisionCursosEstadoError.desde(state),
      ),
    );
  }
}

class CursosPorPeriodo {
  CursosPorPeriodo({
    required this.desde,
    required this.hasta,
    required this.cursos,
  });

  final DateTime desde;
  final DateTime hasta;
  final List<Curso> cursos;
}
