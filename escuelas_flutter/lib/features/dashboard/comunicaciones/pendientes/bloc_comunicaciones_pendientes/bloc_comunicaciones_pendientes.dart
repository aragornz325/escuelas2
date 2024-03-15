import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:flutter/material.dart';

part 'bloc_comunicaciones_pendientes_evento.dart';
part 'bloc_comunicaciones_pendientes_estado.dart';

/// {@template BlocComunicacionesPendientes}
/// BLoC que maneja el estado y la lógica general de la pagina
/// 'ComunicacionesPendientes'
/// {@endtemplate}
class BlocComunicacionesPendientes extends Bloc<
    BlocComunicacionesPendientesEvento, BlocComunicacionesPendientesEstado> {
  /// {@macro BlocComunicacionesPendientes}
  BlocComunicacionesPendientes()
      : super(const BlocComunicacionesPendientesEstadoInicial()) {
    on<BlocComunicacionesPendientesEventoInicializar>(_onInicializar);
    on<BlocComunicacionesPendientesEventoEditarNotificaciones>(
      _onEditarNotificaciones,
    );
    on<BlocComunicacionesPendientesEventoEnviarEstadoNotificaciones>(
      _onEnviarNotificacionesSegunEstado,
    );
  }

  /// Al inicializar trae la informacion necesaria de ComunicacionesPendientes.
  Future<void> _onInicializar(
    BlocComunicacionesPendientesEventoInicializar event,
    Emitter<BlocComunicacionesPendientesEstado> emit,
  ) async {
    emit(BlocComunicacionesPendientesEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        final solicitudesNotificacionesPendientes = await client
            .solicitudNotificacion
            .obtenerSolicitudesNotificacionesPendientes();

        emit(
          BlocComunicacionesPendientesEstadoExitoso.desde(
            state,
            listaNotificacionesPendientes: solicitudesNotificacionesPendientes,
          ),
        );
      },
      onError: (e, st) =>
          emit(BlocComunicacionesPendientesEstadoFallido.desde(state)),
    );
  }

  /// Edita las notificaciones
  Future<void> _onEditarNotificaciones(
    BlocComunicacionesPendientesEventoEditarNotificaciones event,
    Emitter<BlocComunicacionesPendientesEstado> emit,
  ) async {
    emit(BlocComunicacionesPendientesEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        //? Tal vez se podria mejorar la logica pero anda.
        final listaNotificacionesPendientes =
            state.listaNotificacionesPendientes;

        // Obtener la notificacion a actualizar dentro de la lista del estado
        final notificacionAActualizar = listaNotificacionesPendientes
            .firstWhereOrNull(
              (solicitud) => solicitud.notificacionId == event.notificacionId,
            )
            ?.notificacion;

        if (notificacionAActualizar != null) {
          // Actualizar la notificacion
          final notificacionActualizada = notificacionAActualizar
            ..titulo = event.tituloNotificacionEditada
            ..fueEditada = true
            ..cuerpo = event.cuerpoNotificacionEditada;

          // Obtener la solicitud a actualizar
          final solicitudActualizada = listaNotificacionesPendientes.firstWhere(
            (solicitud) => solicitud.notificacionId == event.notificacionId,
          );

          // Conseguir index de la solicitud actualizada en la lista del estado.
          final solicitudActualizadaIndex =
              listaNotificacionesPendientes.indexWhere(
            (solicitud) => solicitud.notificacionId == event.notificacionId,
          );

          listaNotificacionesPendientes.remove(solicitudActualizada);

          // Actualizar la solicitud
          solicitudActualizada.notificacion = notificacionActualizada;

          // Insertar la solicitud en el index que corresponde.
          listaNotificacionesPendientes.insert(
            solicitudActualizadaIndex,
            solicitudActualizada,
          );

          await client.solicitudNotificacion
              .editarSolicitudNotificacionPendiente(
            notificacionPendiente: notificacionActualizada,
          );
        }

        emit(
          BlocComunicacionesPendientesEstadoExitoso.desde(
            state,
            listaNotificacionesPendientes: listaNotificacionesPendientes,
          ),
        );
      },
      onError: (e, st) =>
          emit(BlocComunicacionesPendientesEstadoFallido.desde(state)),
    );
  }

  /// Envia las notificaciones con su estado, aprobado o rechazado.
  Future<void> _onEnviarNotificacionesSegunEstado(
    BlocComunicacionesPendientesEventoEnviarEstadoNotificaciones event,
    Emitter<BlocComunicacionesPendientesEstado> emit,
  ) async {
    emit(BlocComunicacionesPendientesEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        //? Tal vez se podria mejorar la logica pero anda.
        final listaNotificacionesPendientes =
            state.listaNotificacionesPendientes;

        // Actualizar la solicitud dentro de la lista del estado con el estado
        // del evento.
        final solicitudNotificacionActualizada =
            listaNotificacionesPendientes.firstWhere(
          (solicitud) => solicitud.solicitudId == event.solicitudId,
        )..estado = event.estadoSolicitud;

        await client.solicitudNotificacion
            .responderSolicitudNotificacionPendiente(
          solicitudEnvioNotificacion: solicitudNotificacionActualizada,
        );

        listaNotificacionesPendientes.remove(solicitudNotificacionActualizada);

        if (event.estadoSolicitud == EstadoDeSolicitud.aprobado) {
          return emit(
            BlocComunicacionesPendientesEstadoAprobacionExitosa.desde(
              state,
              listaNotificacionesPendientes: listaNotificacionesPendientes,
            ),
          );
        } else {
          return emit(
            BlocComunicacionesPendientesEstadoExitoso.desde(
              state,
              listaNotificacionesPendientes: listaNotificacionesPendientes,
            ),
          );
        }
      },
      onError: (e, st) =>
          emit(BlocComunicacionesPendientesEstadoFallido.desde(state)),
    );
  }
}
