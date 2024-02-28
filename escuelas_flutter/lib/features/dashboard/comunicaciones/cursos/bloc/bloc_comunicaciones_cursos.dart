import 'package:bloc/bloc.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:meta/meta.dart';

part 'bloc_comunicaciones_cursos_evento.dart';
part 'bloc_comunicaciones_cursos_estado.dart';

/// {@template BlocComunicacionesCursos}
// Bloc que maneja la lógica de la pagina de 'Comunicaciones de
// cursos'.
/// {@endtemplate}
class BlocComunicacionesCursos extends Bloc<BlocComunicacionesCursosEvento,
    BlocComunicacionesCursosEstado> {
  /// {@macro BlocComunicacionesCursos}
  BlocComunicacionesCursos()
      : super(const BlocComunicacionesCursosEstadoInicial()) {
    on<BlocComunicacionesCursosEventoInicializar>(_onInicializar);
  }

  /// Al inicializar trae todos los cursos con sus alumnos.
  Future<void> _onInicializar(
    BlocComunicacionesCursosEventoInicializar event,
    Emitter<BlocComunicacionesCursosEstado> emit,
  ) async {
    emit(BlocComunicacionesCursosEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        final comisiones = await client.comision.obtenerComisiones();

        emit(
          BlocComunicacionesCursosEstadoExitoso.desde(
            state,
            comisiones: comisiones,
          ),
        );
      },
      onError: (e, st) => emit(
        BlocComunicacionesCursosEstadoFallido.desde(state),
      ),
    );
  }
}
