import 'package:escuelas_client/escuelas_client.dart';
import 'package:flutter/material.dart';


/// {@template BlocComunicacionesPendientesEstado}
/// Bloc que maneja el estado de las ComunicacionesPendientes
/// {@endtemplate}
@immutable
class BlocComunicacionesPendientesEstado {
  /// {@macro BlocComunicacionesPendientesEstado}
  const BlocComunicacionesPendientesEstado._({
    this.listaNotificacionesPendientes = const <SolicitudEnvioNotificacion>[],
  });

  BlocComunicacionesPendientesEstado.desde(
    BlocComunicacionesPendientesEstado otro, {
    List<SolicitudEnvioNotificacion>? listaNotificacionesPendientes,
  }) : this._(
          listaNotificacionesPendientes: listaNotificacionesPendientes ??
              otro.listaNotificacionesPendientes,
        );

  /// Lista de solicitudes de notificaciones pendientes a resolver.
  final List<SolicitudEnvioNotificacion> listaNotificacionesPendientes;

  /// Devuelve la lista de nombre de comisiones a las cuales pertenecen
  /// las notificaciones.
  List<ComisionDeCurso?> get listaComisiones => listaNotificacionesPendientes
      .map((solicitud) => solicitud.comision)
      .toList();

  List<Object?> get props => [
        listaNotificacionesPendientes,
      ];
}

/// {@template BlocComunicacionesPendientesEstadoInicial}
/// Estado Inicial de la pagina de 'ComunicacionesPendientes'
/// {@endtemplate}
class BlocComunicacionesPendientesEstadoInicial
    extends BlocComunicacionesPendientesEstado {
  /// {@macro BlocComunicacionesPendientesEstadoInicial}
  const BlocComunicacionesPendientesEstadoInicial() : super._();
}

/// {@template BlocComunicacionesPendientesEstadoCargando}
/// Estado Cargando de la pagina de 'ComunicacionesPendientes'
/// {@endtemplate}
class BlocComunicacionesPendientesEstadoCargando
    extends BlocComunicacionesPendientesEstado {
  /// {@macro BlocComunicacionesPendientesEstadoCargando}
  BlocComunicacionesPendientesEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocComunicacionesPendientesEstadoExitoso}
/// Estado Exitoso de la pagina de 'ComunicacionesPendientes'
/// {@endtemplate}
class BlocComunicacionesPendientesEstadoExitoso
    extends BlocComunicacionesPendientesEstado {
  /// {@macro BlocComunicacionesPendientesEstadoExitoso}
  BlocComunicacionesPendientesEstadoExitoso.desde(
    super.otro, {
    super.listaNotificacionesPendientes,
  }) : super.desde();
}

/// {@template BlocComunicacionesPendientesEstadoAprobacionExitosa}
/// Estado Exitoso de la aprobacion de una solicitud de notificacion pendiente
/// de la pagina de 'ComunicacionesPendientes'
/// {@endtemplate}
class BlocComunicacionesPendientesEstadoAprobacionExitosa
    extends BlocComunicacionesPendientesEstado {
  /// {@macro BlocComunicacionesPendientesEstadoAprobacionExitosa}
  BlocComunicacionesPendientesEstadoAprobacionExitosa.desde(
    super.otro, {
    super.listaNotificacionesPendientes,
  }) : super.desde();
}

/// {@template BlocComunicacionesPendientesEstadoFallido}
/// Estado Fallido de la pagina de 'ComunicacionesPendientes'
/// {@endtemplate}
class BlocComunicacionesPendientesEstadoFallido
    extends BlocComunicacionesPendientesEstado {
  /// {@macro BlocComunicacionesPendientesEstadoFallido}
  BlocComunicacionesPendientesEstadoFallido.desde(super.otro) : super.desde();
}
