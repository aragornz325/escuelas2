part of 'bloc_calificaciones_anuales.dart';

/// {@template BlocCalificacionesAnualesEvento}
/// Bloc que maneja los eventos generales de la pagina calificaciones anuales
/// {@endtemplate}
abstract class BlocCalificacionesAnualesEvento {
  /// {@macro BlocCalificacionesAnualesEvento}
  const BlocCalificacionesAnualesEvento();
}

/// {@template BlocCalificacionesAnualesEventoInicializar}
/// Evento Inicial que obtiene todas las calificaciones del año
/// asignatura especifica para un alumno especifico.
/// {@endtemplate}
class BlocCalificacionesAnualesEventoInicializar
    extends BlocCalificacionesAnualesEvento {
  /// {@macro BlocCalificacionesAnualesEventoInicializar}
  const BlocCalificacionesAnualesEventoInicializar({
    required this.idAsignatura,
    required this.anio,
  });

  /// Id de la asignatura para mostrar el historial de calificaciones en el año.
  final int idAsignatura;

  /// Año utilizado para traer todas las calificaciones anuales de un alumno.
  final int anio;
}
