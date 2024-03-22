import 'package:bloc/bloc.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:meta/meta.dart';

part 'bloc_comisiones_evento.dart';
part 'bloc_comisiones_estado.dart';

/// {@template BlocComisiones}
/// Bloc que maneja los estados y lógica de la pagina de 'Comisiones'
/// {@endtemplate}
class BlocComisiones extends Bloc<BlocComisionesEvento, BlocComisionesEstado> {
  /// {@macro BlocComisiones}
  BlocComisiones() : super(const BlocComisionesEstadoInicial()) {
    on<BlocComisionesEventoInicializar>(_inicializar);
  }

  /// Trae las comisiones del intituto con sus asignaturas.
  Future<void> _inicializar(
    BlocComisionesEventoInicializar event,
    Emitter<BlocComisionesEstado> emit,
  ) async {
    emit(BlocComisionesEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        final comisionesConAsignaturas =
            await client.comision.listarComisionesConAsignaturas();

        emit(
          BlocComisionesEstadoExitoso.desde(
            state,
            comisionesConAsignaturas: comisionesConAsignaturas,
          ),
        );
      },
      onError: (e, st) {
        emit(BlocComisionesEstadoError.desde(state));
      },
    );
  }
}
