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
    required this.fecha,
  });

  /// Fecha del periodo a supervisar
  final DateTime fecha;
}

/// {@template BlocSupervisionEnvioCalificacionesEventoCaliFaltantes}
/// Evento para enviar las carga de calificaciones a los profesores que le
/// faltan cargar las calificaciones.
/// {@endtemplate}
class BlocSupervisionEnvioCalificacionesEventoSolicitarCaliFaltantes
    extends BlocSupervisionEnvioCalificacionesEvento {
  /// {@macro BlocSupervisionEnvioCalificacionesEventoCaliFaltantes}
  const BlocSupervisionEnvioCalificacionesEventoSolicitarCaliFaltantes();
}

/// {@template BlocSupervisionEnvioCalificacionesEventoCaliFaltantes}
/// Evento para enviar las calificaciones a los padres/alumnos
/// {@endtemplate}
class BlocSupervisionEnvioCalificacionesEventoEnviarCalificaciones
    extends BlocSupervisionEnvioCalificacionesEvento {
  /// {@macro BlocSupervisionEnvioCalificacionesEventoCaliFaltantes}
  const BlocSupervisionEnvioCalificacionesEventoEnviarCalificaciones();
}
