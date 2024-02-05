import 'package:collection/collection.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/widgets/seccion_cursos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolemissions/rolemissions.dart';

part 'bloc_perfil_usuario_pendiente_estado.dart';
part 'bloc_perfil_usuario_pendiente_evento.dart';

/// {@template BlocPerfilUsuarioPendiente}
/// Bloc que maneja los estados y logica de la pagina
/// [PaginaPerfilUsuarioPendiente]
/// {@endtemplate}
class BlocPerfilUsuarioPendiente extends Bloc<BlocPerfilUsuarioPendienteEvento,
    BlocPerfilUsuarioPendienteEstado> {
  /// {@macro BlocPerfilUsuarioPendiente}
  BlocPerfilUsuarioPendiente()
      : super(const BlocPerfilUsuarioPendienteEstadoInicial()) {
    on<BlocPerfilUsuarioPendienteEventoTraerUsuarioPendiente>(
      _onTraerUsuarioPendiente,
    );
    on<BlocPerfilUsuarioPendienteEventoAceptarSolicitud>(
      _onAceptarSolicitud,
    );
  }

  /// Evento que trae un uduario pendiente con lista de roles
  Future<void> _onTraerUsuarioPendiente(
    BlocPerfilUsuarioPendienteEventoTraerUsuarioPendiente event,
    Emitter<BlocPerfilUsuarioPendienteEstado> emit,
  ) async {
    emit(BlocPerfilUsuarioPendienteEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        final listaRoles = await client.rol.obtenerRoles();
        final usuarioPendiente =
            await client.usuario.obtenerUsuarioPendientePorId(
          idUsuarioPendiente: event.idUsuarioPendiente ?? 0,
        );

        emit(
          BlocPerfilUsuarioPendienteEstadoExitosoAlTraerUsuario.desde(
            state,
            usuarioPendiente: usuarioPendiente,
            listaRoles: listaRoles,
          ),
        );
      },
      onError: (e, st) {
        emit(BlocPerfilUsuarioPendienteEstadoError.desde(state));
      },
    );
  }

/// Acepta la solicitud de un usuario pendiente 
  Future<void> _onAceptarSolicitud(
    BlocPerfilUsuarioPendienteEventoAceptarSolicitud event,
    Emitter<BlocPerfilUsuarioPendienteEstado> emit,
  ) async {
    emit(BlocPerfilUsuarioPendienteEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        final usuarioPendiente = state.usuarioPendiente;

        if (usuarioPendiente == null) {
          return emit(BlocPerfilUsuarioPendienteEstadoError.desde(state));
        } else {
          await client.usuario.responderSolicitudDeRegistro(
            estadoDeSolicitud: EstadoDeSolicitud.aprobado,
            idUsuarioPendiente: usuarioPendiente.id ?? 0,
          );
        }
        emit(BlocPerfilUsuarioPendienteEstadoUsuarioAceptado.desde(state));
      },
      onError: (e, st) {
        emit(BlocPerfilUsuarioPendienteEstadoError.desde(state));
      },
    );
  }
}
