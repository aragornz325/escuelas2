part of 'bloc_supervision_envio_calificaciones.dart';

/// {@template BlocSupervisionEnvioCalificacionesEvento}
/// Maneja los distintos eventos que se pueden dar en la pantalla
/// 'Supervision de envio de Calificaciones'
/// {@endtemplate}
abstract class BlocSupervisionEnvioCalificacionesEvento {
  /// {@macro BlocSupervisionEnvioCalificacionesEvento}
  const BlocSupervisionEnvioCalificacionesEvento();
}

/// {@template BlocSupervisionEnvioCalificacionesEventoInicializar}
/// Evento para inicializar la pantalla 'Supervision de envio de Calificaciones'
/// {@endtemplate}
class BlocSupervisionEnvioCalificacionesEventoInicializar
    extends BlocSupervisionEnvioCalificacionesEvento {
  /// {@macro BlocSupervisionEnvioCalificacionesEventoCargar}
  const BlocSupervisionEnvioCalificacionesEventoInicializar({
    required this.idCurso,
    required this.fecha,
  });

  /// Id del curso a supervisar
  final int idCurso;

  /// Fecha del periodo a supervisar
  final DateTime fecha;
}
