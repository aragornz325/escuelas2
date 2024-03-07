import 'package:bloc/bloc.dart';
import 'package:escuelas_client/escuelas_client.dart';
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
        final plantillas =
            await client.plantillaComunicacion.listarPlantillasComunicacion();

        final notificaciones = await client.cuadernoDeComunicaciones
            .listarHilosDeNotificacionesPorUsuario(
          idUsuario: state.idUsuario,
        );

        emit(
          BlocPerfilComunicadosEstadoExitoso.desde(
            state,
            plantillas: plantillas,
            notificaciones: notificaciones,
          ),
        );
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
        final notificacion =
            await client.cuadernoDeComunicaciones.crearHiloDeNotificaciones(
          idEstudiante: state.idUsuario,
          titulo: event.tituloPlantilla ?? '',
          mensaje: event.descripcion,
          crearNuevaPlantilla: event.crearNuevaPlantilla,
          necesitaSupervision: event.necesitaSupervision,
        );

        state.notificaciones.add(notificacion);

        emit(
          BlocPerfilComunicadosEstadoExitosoAlCrearNotificacion.desde(
            state,
            tituloPlantilla: event.tituloPlantilla,
            notificaciones: state.notificaciones,
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
        // TODO(anyone): todavia no esta muy bien planteado como marcar las notificaciones como leidas
        // final notificacion = event.notificacion;

        // await client.cuadernoDeComunicaciones
        //     .modificarHiloDeNotificaciones(hiloDeNotificaciones: notificacion);

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
        final nuevoComentario = await client.cuadernoDeComunicaciones
            .agregarComentarioEnHiloDeNotificaciones(
          idHiloDeNotificaciones: event.idHiloDeNotificacion,
          comentario: event.comentario,
        );
        state.notificaciones
            .firstWhere(
              (notificaciones) =>
                  notificaciones.id == event.idHiloDeNotificacion,
            )
            .comentarios
            ?.add(nuevoComentario);

        emit(
          BlocPerfilComunicadosEstadoExitoso.desde(
            state,
            notificaciones: state.notificaciones,
          ),
        );
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
        // TODO(anyone): todavia no es muy bien planteado como marcar las notificaciones como leidas
        // final notificacion = await client.cuadernoDeComunicaciones
        //     .marcarTodosLosHilosDeNotificacionesesDelUsuarioComoLeidos(
        //   idUsuario: state.idUsuario,
        // );

        emit(
          BlocPerfilComunicadosEstadoExitoso.desde(
            state,
            // notificaciones: notificacion,
          ),
        );
      },
      onError: (e, st) => emit(
        BlocPerfilComunicadosEstadoFallido.desde(state),
      ),
    );
  }
}
