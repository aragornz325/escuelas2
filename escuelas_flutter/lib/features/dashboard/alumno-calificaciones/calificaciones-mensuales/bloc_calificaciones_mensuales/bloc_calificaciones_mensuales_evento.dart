part of 'bloc_calificaciones_mensuales.dart';

/// {@template BlocCalificacionesMensualesEvento}
/// Bloc que maneja los eventos generales de la pagina 'CalificacionesMensuales'
/// {@endtemplate}
abstract class BlocCalificacionesMensualesEvento {
  /// {@macro BlocCalificacionesMensualesEvento}
  const BlocCalificacionesMensualesEvento();
}

/// {@template BlocCalificacionesMensualesEventoInicializar}
/// Evento Inicial que obtiene todas las calificaciones mensuales del alumno
/// {@endtemplate}
class BlocCalificacionesMensualesEventoInicializar
    extends BlocCalificacionesMensualesEvento {
  /// {@macro BlocCalificacionesMensualesEventoInicializar}
  const BlocCalificacionesMensualesEventoInicializar({
    this.fecha,
  });

  /// Fecha utilizada para traer las calificaciones mensuales de un alumno.
  final DateTime? fecha;
}
