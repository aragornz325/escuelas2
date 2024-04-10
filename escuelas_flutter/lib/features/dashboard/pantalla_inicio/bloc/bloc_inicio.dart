import 'package:bloc/bloc.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_commons/permisos/permisos.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:escuelas_flutter/extensiones/usuario.dart';
part 'bloc_inicio_estado.dart';
part 'bloc_inicio_evento.dart';

/// {@template BlocInicio}
/// Administra la logica de la página que muestra la información general
/// de la pagina Inicio.
/// {@endtemplate}
class BlocInicio extends Bloc<BlocInicioEvento, BlocInicioEstado> {
  /// {@macro BlocInicio}
  BlocInicio({required Usuario usuario})
      : super(BlocInicioEstadoInicial(usuario)) {
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
        final usuarioLogueado = await client.usuario.obtenerDatosDelUsuario();

        final idUsuario = usuarioLogueado.id.toString();

        final usuariosPendientes =
            await client.usuario.obtenerUsuariosPendientes();

        var solicitudesNotificacionesPendientes =
            <SolicitudEnvioNotificacion>[];

        // TODO(mati): se puede mejorar
        if (state.usuario != null &&
            state.usuario!.tienePermisos(PermisoDeSolicitud.verSolicitud)) {
          solicitudesNotificacionesPendientes = await client
              .solicitudNotificacion
              .obtenerSolicitudesNotificacionesPendientes(
            userId: idUsuario,
          );
        }

        emit(
          BlocInicioEstadoExitoso.desde(
            state,
            hayUsuariosPendientes: usuariosPendientes.isNotEmpty,
            cantidadNotificacionesPendientes:
                solicitudesNotificacionesPendientes.length,
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
