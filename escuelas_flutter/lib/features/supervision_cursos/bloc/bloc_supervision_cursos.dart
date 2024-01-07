import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:escuelas_flutter/features/supervision_cursos/pagina_supervision_cursos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_supervision_cursos_estado.dart';
part 'bloc_supervision_cursos_evento.dart';

/// {@template BlocSupervisionCursos}
/// Bloc que maneja los estados y lógica de la [PaginaSupervisionCursos]
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
      callback: (client) {
// TODO(anyone): traer data del backend
        emit(
          BlocSupervisionCursosEstadoExitoso.desde(
            state,
            listaCursos: [
              Curso(
                nombre: 'asd',
                id: 1,
                asignaturas: [],
                ultimaModificacion: DateTime.now(),
                fechaCreacion: DateTime.now(),
              ),
              Curso(
                nombre: '222',
                id: 2,
                asignaturas: [],
                ultimaModificacion: DateTime.now(),
                fechaCreacion: DateTime.now(),
              ),
              Curso(
                nombre: 'a333sd',
                id: 3,
                asignaturas: [],
                ultimaModificacion: DateTime.now(),
                fechaCreacion: DateTime.now(),
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
