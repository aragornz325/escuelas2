import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/pagina_perfil_usuario.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/pagina_perfil_usuario_pendiente.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_perfil_usuario_estado.dart';
part 'bloc_perfil_usuario_evento.dart';

/// {@template BlocPerfilUsuario}
/// Bloc que maneja los estados y lógica de la pagina de [PaginaPerfilUsuario]
/// y [PaginaPerfilUsuarioPendiente]
/// {@endtemplate}
class BlocPerfilUsuario
    extends Bloc<BlocPerfilUsuarioEvento, BlocPerfilUsuarioEstado> {
  /// {@macro BlocPerfilUsuario}
  BlocPerfilUsuario() : super(const BlocPerfilUsuarioEstadoInicial()) {
    on<BlocPerfilUsuarioEventoTraerUsuarioPendiente>(_traerUsuarioPendiente);
    on<BlocPerfilUsuarioEventoTraerUsuario>(_traerUsuario);
    on<BlocPerfilUsuarioEventoAceptarSolicitud>(_onAceptarSolicitud);
  }

  /// Trae un usuarios pendiente y la lista de roles
  Future<void> _traerUsuarioPendiente(
    BlocPerfilUsuarioEventoTraerUsuarioPendiente event,
    Emitter<BlocPerfilUsuarioEstado> emit,
  ) async {
    emit(BlocPerfilUsuarioEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        final listaRoles = await client.rol.obtenerRoles();

        final usuarioPendiente = await client.usuario.obtenerUsuarioPendiente(
          idUsuarioPendiente: event.idUsuarioPendiente ?? 0,
        );

        emit(
          BlocPerfilUsuarioEstadoExitosoAltraerUsuarioPendiente.desde(
            state,
            usuarioPendiente: usuarioPendiente,
            listaRoles: listaRoles,
          ),
        );
      },
      onError: (e, st) {
        emit(
          BlocPerfilUsuarioEstadoError.desde(state),
        );
      },
    );
  }

  /// Evento inicial donde trae todos usuarios pendientes de asignar un rol
  Future<void> _traerUsuario(
    BlocPerfilUsuarioEventoTraerUsuario event,
    Emitter<BlocPerfilUsuarioEstado> emit,
  ) async {
    emit(BlocPerfilUsuarioEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        final listaRoles = await client.rol.obtenerRoles();
        final usuario = await client.usuario
            .obtenerUsuario(idUsuario: event.idUsuario ?? 0);
        emit(
          BlocPerfilUsuarioEstadoExitosoAltraerUsuario.desde(
            state,
            usuario: usuario,
            listaRoles: listaRoles,
          ),
        );
      },
      onError: (e, st) {
        emit(
          BlocPerfilUsuarioEstadoError.desde(state),
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
        final usuarioPendiente = await client.usuario.obtenerUsuarioPendiente(
          idUsuarioPendiente: state.usuario?.id ?? 0,
        );

        if (usuarioPendiente == null) {
          emit(BlocPerfilUsuarioEstadoError.desde(state));
        } else {
          await client.usuario.actualizarUsuarioPendiente(
            usuarioPendiente: usuarioPendiente
              ..estadoDeSolicitud = EstadoDeSolicitud.aprobado,
          );
        }

        emit(BlocPerfilUsuarioEstadoExitoso.desde(state));
      },
      onError: (e, st) {
        emit(BlocPerfilUsuarioEstadoError.desde(state));
      },
    );
  }
}
