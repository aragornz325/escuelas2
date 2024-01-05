import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:escuelas_flutter/features/modelos_temporales.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_perfil_usuario_estado.dart';
part 'bloc_perfil_usuario_evento.dart';

/// {@template BlocPerfilUsuario}
/// Bloc que maneja los estados y lógica de la pagina de 'Inicio'
/// {@endtemplate}
class BlocPerfilUsuario
    extends Bloc<BlocPerfilUsuarioEvento, BlocPerfilUsuarioEstado> {
  /// {@macro BlocPerfilUsuario}
  BlocPerfilUsuario() : super(const BlocPerfilUsuarioEstadoInicial()) {
    on<BlocPerfilUsuarioEventoInicializar>(_inicializar);
  }

  /// Evento inicial donde trae todos usuarios pendientes de asignar un rol
  Future<void> _inicializar(
    BlocPerfilUsuarioEventoInicializar event,
    Emitter<BlocPerfilUsuarioEstado> emit,
  ) async {
    emit(BlocPerfilUsuarioEstadoCargando.desde(state));
    await operacionBloc(
      callback: (
          // client
          ) async {
        // TODO(Gon): Eliminar hardcodeo y usar endpoint
        // final usuario = await traerDatosUsuario(event.idUsuario);
        emit(
          BlocPerfilUsuarioEstadoExitoso.desde(
            state,
            // TODO(Gon): Usar el usuario del back
            usuario: listaUsuariosPendientes
                .where((element) => element.id == event.idUsuario)
                .first,
          ),
        );
      },
      onError: (e, st) {
        emit(
          BlocPerfilUsuarioEstadoError.desde(
            state,
          ),
        );
      },
    );
  }
}
