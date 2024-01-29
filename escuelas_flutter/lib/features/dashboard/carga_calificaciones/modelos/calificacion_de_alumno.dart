/// {@template CalificacionDeAlumno}}
/// Modelo para relacionar un alumno a una calificación
/// {@endtemplate
class CalificacionDeAlumno {
  /// {@macro CalificacionDeAlumno}
  const CalificacionDeAlumno({
    required this.idAlumno,
    required this.calificacion,
  });
  final int idAlumno;
  final String calificacion;
}
