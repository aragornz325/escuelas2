import 'package:bloc/bloc.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:meta/meta.dart';

part 'bloc_comunicaciones_lista_cursos_evento.dart';
part 'bloc_comunicaciones_lista_cursos_estado.dart';

/// {@template BlocComunicacionesCursos}
// Bloc que maneja la lógica de la pagina de 'Comunicaciones de
// cursos'.
/// {@endtemplate}
class BlocComunicacionesListaCursos extends Bloc<
    BlocComunicacionesListaCursosEvento, BlocComunicacionesListaCursosEstado> {
  /// {@macro BlocComunicacionesCursos}
  BlocComunicacionesListaCursos()
      : super(const BlocComunicacionesListaCursosEstadoInicial()) {
    on<BlocComunicacionesListaCursosEventoInicializar>(_onInicializar);
  }

  /// Al inicializar trae todos los cursos con sus alumnos.
  Future<void> _onInicializar(
    BlocComunicacionesListaCursosEventoInicializar event,
    Emitter<BlocComunicacionesListaCursosEstado> emit,
  ) async {
    emit(BlocComunicacionesListaCursosEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        final comisiones = await client.comision.obtenerComisiones();

        emit(
          BlocComunicacionesListaCursosEstadoExitoso.desde(
            state,
            comisiones: comisiones,
          ),
        );
      },
      onError: (e, st) => emit(
        BlocComunicacionesListaCursosEstadoFallido.desde(state),
      ),
    );
  }
}
