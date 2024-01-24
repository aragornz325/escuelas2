import 'package:bloc/bloc.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';

part 'bloc_inicio_estado.dart';
part 'bloc_inicio_evento.dart';

/// {@template BlocInicio}
/// Administra la logica de la página que muestra la información general
/// de la pagina Inicio.
/// {@endtemplate}
class BlocInicio extends Bloc<BlocInicioEvento, BlocInicioEstado> {
  /// {@macro BlocInicio}
  BlocInicio() : super(const BlocInicioEstadoInicial()) {
    on<BlocInicioEventoInicializar>(_onInicializar);
  }

  /// Trae los roles de la institucion que luego se filtraran para mostrar
  Future<void> _onInicializar(
    BlocInicioEventoInicializar event,
    Emitter<BlocInicioEstado> emit,
  ) async {
    emit(BlocInicioEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        final listaUsuariosPendientes =
            await client.usuario.obtenerUsuariosPendientes();

        emit(
          BlocInicioEstadoExitoso.desde(
            state,
            hayUsuariosPendientes: listaUsuariosPendientes.isNotEmpty,
          ),
        );
      },
      onError: (e, st) {
        emit(
          BlocInicioEstadoFallido.desde(
            state,
          ),
        );
      },
    );
  }
}
