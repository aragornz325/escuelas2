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
        final usuario = state.usuario;
        final yaTieneTelefono = usuario?.numerosDeTelefono?.firstOrNull;

        if (yaTieneTelefono?.numeroDeTelefono == event.telefono &&
            yaTieneTelefono != null) {
          //ya tiene el numero en la lista
        } else {
          if (yaTieneTelefono != null) {
            usuario?.numerosDeTelefono!
                .removeWhere((numero) => numero == yaTieneTelefono);
          }
          usuario?.numerosDeTelefono!.add(
            NumeroDeTelefono(
              numeroDeTelefono: event.telefono ?? '',
              tipoDeTelefono: TipoDeTelefono.celular,
            ),
          );
        }
        final yaTieneMail = usuario?.direccionesDeEmail?.firstOrNull;

        if (yaTieneMail?.direccionDeEmail == event.email &&
            yaTieneMail != null) {
          //ya tiene el email en la lista
        } else {
          if (yaTieneMail != null) {
            usuario?.direccionesDeEmail!
                .removeWhere((email) => email == yaTieneMail);
          }
          usuario?.direccionesDeEmail!.add(
            DireccionDeEmail(
              usuarioId: state.usuario?.id ?? 0,
              direccionDeEmail: event.email ?? '',
            ),
          );
        }

        final usuarioEditado = Usuario(
          id: usuario?.id,
          idUserInfo: event.usuario?.idUserInfo ?? 0,
          nombre: state.usuario?.nombre ?? '',
          apellido: state.usuario?.apellido ?? '',
          urlFotoDePerfil: state.usuario?.urlFotoDePerfil ?? '',
          necesitaCambiarPassword:
              state.usuario?.necesitaCambiarPassword ?? false,
          numerosDeTelefono: usuario?.numerosDeTelefono ?? [],
          direccionesDeEmail: usuario?.direccionesDeEmail ?? [],
          dni: event.dni ?? '',
        );

        await client.usuario.actualizarUsuario(usuario: usuarioEditado);
        emit(
          BlocEditarPerfilEstadoExitosoAlActualizar.desde(
            state,
            usuario: usuarioEditado,
          ),
        );
      },
      onError: (e, st) => emit(BlocEditarPerfilEstadoError.desde(state)),
    );
  }

  /// Funcion para cambiar la contraseña de un tercero
  Future<void> _onEditarPassword(
    BlocEditarPerfilEventoEditarPassword event,
    Emitter<BlocEditarPerfilEstado> emit,
  ) async {
    emit(BlocEditarPerfilEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        await client.userInfo.cambiarPasswordDeOtroUsuario(
          idUsuario: state.usuario?.idUserInfo ?? 0,
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
