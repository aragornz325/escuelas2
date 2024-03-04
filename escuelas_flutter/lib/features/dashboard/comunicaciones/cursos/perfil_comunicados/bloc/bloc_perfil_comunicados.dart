import 'package:bloc/bloc.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:meta/meta.dart';

part 'bloc_perfil_comunicados_evento.dart';
part 'bloc_perfil_comunicados_estado.dart';

/// {@template BlocPerfilComunicados}
// Bloc que maneja la lógica de la pagina de 'Perfil de Comunicados'.
/// {@endtemplate}
class BlocPerfilComunicados
    extends Bloc<BlocPerfilComunicadosEvento, BlocPerfilComunicadosEstado> {
  /// {@macro BlocPerfilComunicados}
  BlocPerfilComunicados({
    required int idUsuario,
    required String nombreUsuario,
  }) : super(
          BlocPerfilComunicadosEstadoInicial(
            idUsuario: idUsuario,
            nombreUsuario: nombreUsuario,
          ),
        ) {
    on<BlocPerfilComunicadosEventoInicializar>(_onInicializar);
    on<BlocPerfilComunicadosEventoCrearNotificacion>(_onCrearNotificacion);
    on<BlocPerfilComunicadosEventoMarcarNotificacionComoLeidas>(
      _onMarcarComoLeidaUnaNotificacion,
    );
    on<BlocPerfilComunicadosEventoCrearComentario>(_onCrearComentario);
    on<BlocPerfilComunicadosEventoNotificacionMarcarTodasComoLeidas>(
      _onMarcarComoLeidasTodasLasNotificaciones,
    );
  }

  /// Al inicializar trae las notificaciones y las plantillas
  Future<void> _onInicializar(
    BlocPerfilComunicadosEventoInicializar event,
    Emitter<BlocPerfilComunicadosEstado> emit,
  ) async {
    emit(BlocPerfilComunicadosEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        /// TODO(mati) llamar a las notificaciones y a las plantillas por defecto
        // await client.getNotificacionesPorIdUsuario(idUsuario:
        // state.idUsuario);

        emit(BlocPerfilComunicadosEstadoExitoso.desde(state));
      },
      onError: (e, st) => emit(
        BlocPerfilComunicadosEstadoFallido.desde(state),
      ),
    );
  }

  /// Crea una nueva notificacion.
  Future<void> _onCrearNotificacion(
    BlocPerfilComunicadosEventoCrearNotificacion event,
    Emitter<BlocPerfilComunicadosEstado> emit,
  ) async {
    emit(BlocPerfilComunicadosEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        /// TODO(mati) llamar a crear notificacion
        /// await client.crearNotificacion();

        emit(
          BlocPerfilComunicadosEstadoExitosoAlCrearNotificacion.desde(
            state,
            tituloPlantilla: event.tituloPlantilla,
          ),
        );
      },
      onError: (e, st) => emit(
        BlocPerfilComunicadosEstadoFallido.desde(state),
      ),
    );
  }

  /// Marcar una notificacion como leida.
  Future<void> _onMarcarComoLeidaUnaNotificacion(
    BlocPerfilComunicadosEventoMarcarNotificacionComoLeidas event,
    Emitter<BlocPerfilComunicadosEstado> emit,
  ) async {
    emit(BlocPerfilComunicadosEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        /// TODO(mati) llamar marcar o modificar una notificacion
        /// await client.moficarNotificacion();

        emit(BlocPerfilComunicadosEstadoExitoso.desde(state));
      },
      onError: (e, st) => emit(
        BlocPerfilComunicadosEstadoFallido.desde(state),
      ),
    );
  }

  /// Crea un nuevo Comentario en una notificacion.
  Future<void> _onCrearComentario(
    BlocPerfilComunicadosEventoCrearComentario event,
    Emitter<BlocPerfilComunicadosEstado> emit,
  ) async {
    emit(BlocPerfilComunicadosEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        /// TODO(mati) Crear Comentario para una notificacion
        /// await client.CrearComentarioEnNotificacion();

        emit(BlocPerfilComunicadosEstadoExitoso.desde(state));
      },
      onError: (e, st) => emit(
        BlocPerfilComunicadosEstadoFallido.desde(state),
      ),
    );
  }

  /// Marcar todas las notificaciones como leidas
  Future<void> _onMarcarComoLeidasTodasLasNotificaciones(
    BlocPerfilComunicadosEventoNotificacionMarcarTodasComoLeidas event,
    Emitter<BlocPerfilComunicadosEstado> emit,
  ) async {
    emit(BlocPerfilComunicadosEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        /// TODO(mati) Marcar como leidas todas las notificaciones que tenga el
        /// usuario
        /// await client.CrearComentarioEnNotificacion();

        emit(BlocPerfilComunicadosEstadoExitoso.desde(state));
      },
      onError: (e, st) => emit(
        BlocPerfilComunicadosEstadoFallido.desde(state),
      ),
    );
  }
}
