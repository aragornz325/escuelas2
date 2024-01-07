import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:escuelas_flutter/features/perfil_usuario/pagina_perfil_usuario.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_perfil_usuario_estado.dart';
part 'bloc_perfil_usuario_evento.dart';

/// {@template BlocPerfilUsuario}
/// Bloc que maneja los estados y lógica de la pagina de [PaginaPerfilUsuario]
/// {@endtemplate}
class BlocPerfilUsuario
    extends Bloc<BlocPerfilUsuarioEvento, BlocPerfilUsuarioEstado> {
  /// {@macro BlocPerfilUsuario}
  BlocPerfilUsuario() : super(const BlocPerfilUsuarioEstadoInicial()) {
    on<BlocPerfilUsuarioEventoInicializar>(_inicializar);
    on<BlocPerfilUsuarioEventoAceptarSolicitud>(_onAceptarSolicitud);
  }

  /// Evento inicial donde trae todos usuarios pendientes de asignar un rol
  Future<void> _inicializar(
    BlocPerfilUsuarioEventoInicializar event,
    Emitter<BlocPerfilUsuarioEstado> emit,
  ) async {
    emit(BlocPerfilUsuarioEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        // TODO(Gon): Eliminar hardcodeo y usar endpoint
        final usuarioPendiente =
            await client.usuario.obtenerUsuarioPendiente(idUsuarioPendiente: 2);
        final usuario = await client.usuario
            .obtenerUsuario(idUsuario: usuarioPendiente?.idUserInfo ?? 0);
        emit(
          BlocPerfilUsuarioEstadoExitoso.desde(
            state,
            usuario: usuario,
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

  /// Evento inicial donde trae todos usuarios pendientes de asignar un rol
  Future<void> _onAceptarSolicitud(
    BlocPerfilUsuarioEventoAceptarSolicitud event,
    Emitter<BlocPerfilUsuarioEstado> emit,
  ) async {
    emit(BlocPerfilUsuarioEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        final usuario = await client.usuario.obtenerUsuarioPendiente(
          idUsuarioPendiente: state.usuario?.id ?? 0,
        );

        if (usuario == null) {
          throw Exception('No hay usuarios pendientes');
        } else {
          await client.usuario.actualizarUsuarioPendiente(
            usuarioPendiente: usuario
              ..estadoDeSolicitud = EstadoDeSolicitud.aprobado,
          );
        }

        emit(BlocPerfilUsuarioEstadoExitoso.desde(state));
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
