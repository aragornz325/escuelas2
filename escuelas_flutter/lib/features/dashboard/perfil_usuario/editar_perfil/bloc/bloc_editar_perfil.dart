import 'package:bloc/bloc.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:meta/meta.dart';

part 'bloc_editar_perfil_evento.dart';
part 'bloc_editar_perfil_estado.dart';

/// {@template BlocEditarPerfil}
/// Bloc para editar el perfil.
/// {@endtemplate}
class BlocEditarPerfil
    extends Bloc<BlocEditarPerfilEvento, BlocEditarPerfilEstado> {
  /// {@macro BlocEditarPerfil}
  BlocEditarPerfil() : super(const BlocEditarPerfilEstadoInitial()) {
    on<BlocEditarPerfilEventoTraerUsuario>(_ontraerUsuario);
    on<BlocEditarPerfilEventoGuardarCambios>(_onGuardarCambios);
    on<BlocEditarPerfilEventoConfirmarCambios>(_onConfirmarCambios);
    on<BlocEditarPerfilEventoEditarPassword>(_onEditarPassword);
  }

  /// Funciona para traer la info de un usuario
  Future<void> _ontraerUsuario(
    BlocEditarPerfilEventoTraerUsuario event,
    Emitter<BlocEditarPerfilEstado> emit,
  ) async {
    emit(BlocEditarPerfilEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        // TODO (anyone) : implementar endpoint para traer la info del usuario
        final usuario =
            await client.usuario.obtenerUsuario(idUsuario: event.idUsuario);

        emit(
          BlocEditarPerfilEstadoExitoso.desde(
            state,
            usuario: usuario,
            nombreUsuario: event.nombreUsuario,
          ),
        );
      },
      onError: (e, st) => emit(BlocEditarPerfilEstadoError.desde(state)),
    );
  }

  /// Funcion para guardar los cambios en la base de datos de un usuario
  Future<void> _onGuardarCambios(
    BlocEditarPerfilEventoGuardarCambios event,
    Emitter<BlocEditarPerfilEstado> emit,
  ) async {
    emit(BlocEditarPerfilEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        emit(
          BlocEditarPerfilEstadoExitoso.desde(
            state,
            edad: event.edad,
            vinculo: event.vinculo,
            nombreTutor: event.nombreTutor,
            apellidoTutor: event.apellidoTutor,
            emailTutor: event.emailTutor,
            telefonoTutor: event.telefonoTutor,
            observaciones: event.observaciones,
            factorSanguineo: event.factorSanguineo,
            email: event.email,
            telefono: event.telefono,
          ),
        );
      },
      onError: (e, st) => emit(BlocEditarPerfilEstadoError.desde(state)),
    );
  }

  /// Funcion para confirmar los cambios en la base de datos de un usuario
  Future<void> _onConfirmarCambios(
    BlocEditarPerfilEventoConfirmarCambios event,
    Emitter<BlocEditarPerfilEstado> emit,
  ) async {
    emit(BlocEditarPerfilEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        // TODO (anyone) : implementar endpoint para confirmar los cambios
        emit(BlocEditarPerfilEstadoExitosoAlActualizar.desde(state));
      },
      onError: (e, st) => emit(BlocEditarPerfilEstadoError.desde(state)),
    );
  }

  /// Funciona para traer la info de un usuario
  Future<void> _onEditarPassword(
    BlocEditarPerfilEventoEditarPassword event,
    Emitter<BlocEditarPerfilEstado> emit,
  ) async {
    emit(BlocEditarPerfilEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        await client.userInfo.cambiarPasswordDelUsuario(
          nuevaPassword: event.nuevaPassword,
        );

        emit(
          BlocEditarPerfilEstadoExitosoEditarPassword.desde(
            state,
            nuevaPassword: event.nuevaPassword,
          ),
        );
      },
      onError: (e, st) => emit(BlocEditarPerfilEstadoError.desde(state)),
    );
  }
}
