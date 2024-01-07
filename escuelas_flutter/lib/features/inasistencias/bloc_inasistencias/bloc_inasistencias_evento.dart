part of 'bloc_inasistencias.dart';

/// {@template BlocInasistenciasEvento}
/// Bloc que maneja los eventos generales de la pagina 'Asistencias'
/// {@endtemplate}
abstract class BlocInasistenciasEvento {
  /// {@macro BlocInasistenciasEvento}
  const BlocInasistenciasEvento();
}

/// {@template BlocInasistenciasEventoInicializar}
/// Evento Inicial que obtiene todos los cursos para tomar asistencias
/// {@endtemplate}
class BlocInasistenciasEventoInicializar extends BlocInasistenciasEvento {
  /// {@macro BlocInasistenciasEventoInicializar}
  const BlocInasistenciasEventoInicializar();
}

/// {@template BlocInasistenciasEventoFinalizarInasistencias}
/// Evento que finaliza la asistencia del dia de dicho curso
/// {@endtemplate}
class BlocInasistenciasEventoFinalizarInasistencias
    extends BlocInasistenciasEvento {
  /// {@macro BlocInasistenciasEventoFinalizarInasistencias}
  const BlocInasistenciasEventoFinalizarInasistencias({
    required this.idCurso,
    required this.fecha,
  });

  /// Id del curso  a modificar si se tomo asistencia.
  final int idCurso;

  /// Fecha para saber su ultima modificación.
  final DateTime fecha;
}

/// {@template BlocAsistenciaEventoCambiarInasistenciaAlumno}
/// Evento para cambiar la inasistencia de un alumno
/// {@endtemplate}
class BlocAsistenciaEventoCambiarInasistenciaAlumno
    extends BlocInasistenciasEvento {
  /// {@macro BlocAsistenciaEventoCambiarInasistenciaAlumno}
  const BlocAsistenciaEventoCambiarInasistenciaAlumno({
    required this.idCurso,
    required this.idAlumno,
    required this.fecha,
    required this.asistenciaDiaria,
  });

  /// Id del curso  a modificar si se tomo asistencia.
  final int idCurso;

  /// Id del alumno a modificar la inasistencia
  final int idAlumno;

  /// Fecha para saber su ultima modificación.
  final DateTime fecha;

  /// Asistencia de Alumno a modificar
  final EstadoDeAsistencia asistenciaDiaria;
}
