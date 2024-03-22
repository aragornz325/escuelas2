// ignore_for_file: lines_longer_than_80_chars

part of 'bloc_comunicaciones_pendientes.dart';

/// {@template BlocComunicacionesPendientesEvento}
/// Bloc que maneja los eventos generales de la pagina
/// 'ComunicacionesPendientes'
/// {@endtemplate}
abstract class BlocComunicacionesPendientesEvento {
  /// {@macro BlocComunicacionesPendientesEvento}
  const BlocComunicacionesPendientesEvento();
}

/// {@template BlocComunicacionesPendientesEventoInicializar}
/// Evento Inicial que obtiene las ComunicacionesPendientes pertinentes
/// {@endtemplate}
class BlocComunicacionesPendientesEventoInicializar
    extends BlocComunicacionesPendientesEvento {
  /// {@macro BlocComunicacionesPendientesEventoInicializar}
  const BlocComunicacionesPendientesEventoInicializar();
}

/// {@template BlocComunicacionesPendientesEventoEditarNotificaciones}
/// Evento para editar notificaciones y agregarlas al estado.
/// {@endtemplate}
class BlocComunicacionesPendientesEventoEditarNotificaciones
    extends BlocComunicacionesPendientesEvento {
  /// {@macro BlocComunicacionesPendientesEventoEditarNotificaciones}
  const BlocComunicacionesPendientesEventoEditarNotificaciones({
    required this.tituloNotificacionEditada,
    required this.cuerpoNotificacionEditada,
    required this.notificacionId,
  });

  /// Titulo de la notificacion editada para guardarlas en el estado.
  final String tituloNotificacionEditada;

  /// Cuerpo de la notificacion editada para guardarlas en el estado.
  final String cuerpoNotificacionEditada;

  /// Id de la notificacion editada para guardarlas en el estado.
  final int notificacionId;
}

/// {@template BlocComunicacionesPendientesEventoEnviarNotificacionesSegunEstado}
/// Evento para enviar notificaciones con un estado específico
/// ya sea aprobado o rechazado
/// {@endtemplate}
class BlocComunicacionesPendientesEventoEnviarEstadoNotificaciones
    extends BlocComunicacionesPendientesEvento {
  /// {@macro BlocComunicacionesPendientesEventoEnviarNotificacionesSegunEstado}
  const BlocComunicacionesPendientesEventoEnviarEstadoNotificaciones({
    required this.estadoSolicitud,
    required this.solicitudId,
  });

  /// Estado de las notificaciones a enviar
  final EstadoDeSolicitud estadoSolicitud;

  /// Id de la solicitud editada para guardarlas en el estado.
  final int solicitudId;
}
