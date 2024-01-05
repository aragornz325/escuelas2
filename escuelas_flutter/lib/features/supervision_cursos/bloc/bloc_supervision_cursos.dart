import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:escuelas_flutter/features/modelos_temporales.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_supervision_cursos_estado.dart';
part 'bloc_supervision_cursos_evento.dart';

/// {@template BlocSupervisionCursos}
/// Bloc que maneja los estados y lógica de la pagina de 'Inicio'
/// {@endtemplate}
class BlocSupervisionCursos
    extends Bloc<BlocSupervisionCursosEvento, BlocSupervisionCursosEstado> {
  /// {@macro BlocSupervisionCursos}
  BlocSupervisionCursos() : super(const BlocSupervisionCursosEstadoInicial()) {
    on<BlocSupervisionCursosEventoInicializar>(_inicializar);
  }

  Future<void> _inicializar(
    BlocSupervisionCursosEventoInicializar event,
    Emitter<BlocSupervisionCursosEstado> emit,
  ) async {
    emit(BlocSupervisionCursosEstadoCargando.desde(state));
    await operacionBloc(
      callback: () {
// TODO(anyone): traer data del backend
        emit(
          BlocSupervisionCursosEstadoExitoso.desde(
            state,
            listaCursos: [
              Curso(
                nombre: 'asd',
                id: 1,
              ),
              Curso(
                nombre: '222',
                id: 2,
              ),
              Curso(
                nombre: 'a333sd',
                id: 3,
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
