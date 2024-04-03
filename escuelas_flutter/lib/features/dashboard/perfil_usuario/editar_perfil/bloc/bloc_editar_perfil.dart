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
    on<BlocEditarPerfilEventoEditarPassword>(_onEditarPassword);
  }

  // / Funciona para traer la info de un usuario
  Future<void> _ontraerUsuario(
    BlocEditarPerfilEventoTraerUsuario event,
    Emitter<BlocEditarPerfilEstado> emit,
  ) async {
    emit(BlocEditarPerfilEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        final usuario =
            await client.usuario.obtenerUsuario(idUsuario: event.idUsuario);

        emit(
          BlocEditarPerfilEstadoExitoso.desde(
            state,
            usuario: usuario,
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
        final telefonoeditado = state.usuario?.numerosDeTelefono?.firstOrNull
          ?..numeroDeTelefono = event.telefono ?? '';
        final emaileditado = state.usuario?.direccionesDeEmail?.firstOrNull
          ?..direccionDeEmail = event.email ?? '';

        final usuarioEditado = Usuario(
          idUserInfo: event.usuario?.idUserInfo ?? 0,
          nombre: state.usuario?.nombre ?? '',
          apellido: state.usuario?.apellido ?? '',
          urlFotoDePerfil: state.usuario?.urlFotoDePerfil ?? '',
          necesitaCambiarPassword:
              state.usuario?.necesitaCambiarPassword ?? false,
          numerosDeTelefono: [
            telefonoeditado ??
                NumeroDeTelefono(
                  numeroDeTelefono: 'pepe',
                  tipoDeTelefono: TipoDeTelefono.celular,
                ),
          ],
          direccionesDeEmail: [
            emaileditado ??
                DireccionDeEmail(
                  usuarioId: state.usuario?.id ?? 0,
                  direccionDeEmail: 'direccionDeEmail',
                ),
          ],
          dni: event.usuario?.dni ?? '',
        );

        final usuarioModificado =
            await client.usuario.actualizarUsuario(usuario: usuarioEditado);
        emit(
          BlocEditarPerfilEstadoExitosoAlActualizar.desde(
            state,
            usuario: usuarioModificado,
          ),
        );
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
        await client.userInfo.cambiarPasswordDeOtroUsuario(
          idUsuario: event.idUsuario,
          nuevaPassword: event.nuevaPassword,
          conRequerimientoDeCambioDePassword:
              event.conRequerimientoDeCambioDePassword,
        );
        emit(
          BlocEditarPerfilEstadoExitosoEditarPassword.desde(
            state,
            nuevaPassword: event.nuevaPassword,
            conRequerimientoDeCambioDePassword:
                event.conRequerimientoDeCambioDePassword,
          ),
        );
      },
      onError: (e, st) => emit(BlocEditarPerfilEstadoError.desde(state)),
    );
  }
}
