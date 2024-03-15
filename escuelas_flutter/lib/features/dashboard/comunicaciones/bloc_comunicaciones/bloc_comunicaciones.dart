import 'package:bloc/bloc.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:flutter/material.dart';

part 'bloc_comunicaciones_evento.dart';
part 'bloc_comunicaciones_estado.dart';

/// {@template BlocComunicaciones}
/// BLoC que maneja el estado y la lógica general de la pagina 'Comunicaciones'
/// {@endtemplate}
class BlocComunicaciones
    extends Bloc<BlocComunicacionesEvento, BlocComunicacionesEstado> {
  /// {@macro BlocComunicaciones}
  BlocComunicaciones() : super(const BlocComunicacionesEstadoInicial()) {
    on<BlocComunicacionesEventoInicializar>(_onInicializar);
  }

  /// Al inicializar trae la informacion necesaria de Comunicaciones.
  Future<void> _onInicializar(
    BlocComunicacionesEventoInicializar event,
    Emitter<BlocComunicacionesEstado> emit,
  ) async {
    emit(BlocComunicacionesEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        final solicitudesNotificacionesPendientes = await client
            .solicitudNotificacion
            .obtenerSolicitudesNotificacionesPendientes();

        emit(
          BlocComunicacionesEstadoExitoso.desde(
            state,
            cantidadNotificacionesPendientes:
                solicitudesNotificacionesPendientes.length,
          ),
        );
      },
      onError: (e, st) => emit(BlocComunicacionesEstadoFallido.desde(state)),
    );
  }
}
