import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
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
      callback: (client) async {
// TODO(anyone): traer data del backend
        // final respuesta = await client.curso.obtenerCursos();

        // ignore: unused_local_variable
        final respuesta = [
          ComisionDeCurso(
            cursoId: 1,
            curso: Curso(
              nombre: 'nombre',
            ),
            anioLectivo: 2024,
            nombre: 'primero',
            ultimaModificacion: DateTime(2, 01, 2024),
          ),
          ComisionDeCurso(
            cursoId: 1,
            curso: Curso(
              nombre: 'nombre',
            ),
            anioLectivo: 2024,
            nombre: 'segundo',
            ultimaModificacion: DateTime(2, 01, 2024),
          ),
          ComisionDeCurso(
            cursoId: 1,
            curso: Curso(
              nombre: 'nombre',
            ),
            anioLectivo: 2024,
            nombre: 'tercero',
            ultimaModificacion: DateTime(2, 01, 2024),
          ),
          ComisionDeCurso(
            cursoId: 1,
            curso: Curso(
              nombre: 'nombre',
            ),
            anioLectivo: 2024,
            nombre: 'cuarto',
            ultimaModificacion: DateTime(2, 01, 2024),
          ),
          ComisionDeCurso(
            cursoId: 1,
            curso: Curso(
              nombre: 'nombre',
            ),
            anioLectivo: 2024,
            nombre: 'quinto',
            ultimaModificacion: DateTime(2, 01, 2024),
          ),
          ComisionDeCurso(
            cursoId: 1,
            anioLectivo: 2024,
            curso: Curso(
              nombre: 'nombre',
            ),
            nombre: 'sexto',
            ultimaModificacion: DateTime(2, 01, 2024),
          ),
        ];
        emit(
          BlocSupervisionCursosEstadoExitoso.desde(
            state,
            listaCursos: [
              ComisionDeCurso(
                cursoId: 1,
                curso: Curso(
                  nombre: 'nombre',
                ),
                anioLectivo: 2024,
                ultimaModificacion: DateTime.now(),
                nombre: 'asd',
                id: 1,
              ),
              ComisionDeCurso(
                cursoId: 1,
                nombre: '222',
                id: 2,
                curso: Curso(
                  nombre: 'nombre',
                ),
                anioLectivo: 2024,
                ultimaModificacion: DateTime.now(),
              ),
              ComisionDeCurso(
                cursoId: 1,
                nombre: 'a333sd',
                id: 3,
                curso: Curso(
                  nombre: 'nombre',
                ),
                anioLectivo: 2024,
                ultimaModificacion: DateTime.now(),
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
