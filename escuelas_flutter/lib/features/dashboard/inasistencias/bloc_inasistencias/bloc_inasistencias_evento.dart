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
  const BlocInasistenciasEventoInicializar({required this.fecha});

  /// Fecha de la fecha a tomar del calendario
  final DateTime fecha;
}

/// {@template BlocInasistenciasEventoFinalizarInasistencias}
/// Evento que finaliza la asistencia del dia de dicho curso
/// {@endtemplate}
class BlocInasistenciasEventoFinalizarInasistencias
    extends BlocInasistenciasEvento {
  /// {@macro BlocInasistenciasEventoFinalizarInasistencias}
  const BlocInasistenciasEventoFinalizarInasistencias({
    required this.idComision,
  });

  /// Id del curso  a modificar si se tomo asistencia.
  final int idComision;
}

/// {@template BlocAsistenciaEventoCambiarInasistenciaEstudiante}
/// Evento para cambiar la inasistencia de un estudiante
/// {@endtemplate}
class BlocAsistenciaEventoCambiarInasistenciaEstudiante
    extends BlocInasistenciasEvento {
  /// {@macro BlocAsistenciaEventoCambiarInasistenciaEstudiante}
  const BlocAsistenciaEventoCambiarInasistenciaEstudiante({
    required this.idComision,
    required this.idEstudiante,
    required this.fecha,
    required this.estadoInasistencia,
  });

  /// Id del curso  a modificar si se tomo asistencia.
  final int idComision;

  /// Id del estudiante a modificar la inasistencia
  final int idEstudiante;

  /// Fecha para saber su ultima modificación.
  final DateTime fecha;

  /// Asistencia de estudiante a modificar
  final EstadoDeAsistencia estadoInasistencia;
}
