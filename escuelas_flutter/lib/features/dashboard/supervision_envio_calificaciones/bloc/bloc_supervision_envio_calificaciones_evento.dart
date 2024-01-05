part of 'bloc_supervision_envio_calificaciones.dart';

/// {@template BlocSupervisionEnvioCalificacionesEvento}
/// AGREGAR DOCUMENTACION GENERADA
/// {@endtemplate}
abstract class BlocSupervisionEnvioCalificacionesEvento {
  /// {@macro BlocSupervisionEnvioCalificacionesEvento}
  const BlocSupervisionEnvioCalificacionesEvento();
}

class BlocSupervisionEnvioCalificacionesEventoInicializar
    extends BlocSupervisionEnvioCalificacionesEvento {
  /// {@macro BlocSupervisionEnvioCalificacionesEventoCargar}
  const BlocSupervisionEnvioCalificacionesEventoInicializar({
    required this.idCurso,
    required this.fecha,
  });
  final int idCurso;
  final DateTime fecha;
}
