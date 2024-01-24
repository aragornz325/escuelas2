import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolemissions/rolemissions.dart';

part 'bloc_usuarios_pendientes_estado.dart';
part 'bloc_usuarios_pendientes_evento.dart';

/// {@template BlocUsuariosPendientes}
/// Bloc que maneja los estados y lógica de la pagina de 'Usuarios Pendientes'
/// {@endtemplate}
class BlocUsuariosPendientes
    extends Bloc<BlocUsuariosPendientesEvento, BlocUsuariosPendientesEstado> {
  /// {@macro BlocUsuariosPendientes}
  BlocUsuariosPendientes()
      : super(const BlocUsuariosPendientesEstadoInicial()) {
    on<BlocUsuariosPendientesEventoInicializar>(_inicializar);
  }

  /// Evento inicial donde trae todos usuarios pendientes de asignar un rol
  Future<void> _inicializar(
    BlocUsuariosPendientesEventoInicializar event,
    Emitter<BlocUsuariosPendientesEstado> emit,
  ) async {
    emit(BlocUsuariosPendientesEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        final usuariosPendientesYRoles = await Future.wait(
          [
            client.usuario.obtenerUsuariosPendientes(),
            client.rol.obtenerRoles(),
          ],
        );
        final listaUsuariosPendientes =
            List<UsuarioPendiente>.from(usuariosPendientesYRoles[0]);

        final listaRoles = List<Role>.from(usuariosPendientesYRoles[1]);

        emit(
          BlocUsuariosPendientesEstadoExitoso.desde(
            state,
            listaUsuariosPendientes: listaUsuariosPendientes,
            listaRoles: listaRoles,
          ),
        );
      },
      onError: (e, st) => emit(BlocUsuariosPendientesEstadoError.desde(state)),
    );
  }
}
