part of 'bloc_asistencias.dart';

/// {@template BlocAsistenciaEvento}
/// Bloc que maneja los eventos generales de la pagina 'Asistencias'
/// {@endtemplate}
abstract class BlocAsistenciasEvento {
  /// {@macro BlocAsistenciaEvento}
  const BlocAsistenciasEvento();
}

/// {@template BlocAsistenciaEventoInicializar}
/// Evento Inicial que obtiene todos los cursos para tomar asistencias
/// {@endtemplate}
class BlocAsistenciasEventoInicializar extends BlocAsistenciasEvento {
  /// {@macro BlocAsistenciaEventoInicializar}
  const BlocAsistenciasEventoInicializar();
}

/// {@template BlocAsistenciasEventoCambiarEstadoAsistencia}
/// Evento que cambia el estado de la asistencias de un alumno de dicho curso
/// {@endtemplate}
class BlocAsistenciasEventoCambiarEstadoAsistencia
    extends BlocAsistenciasEvento {
  /// {@macro BlocAsistenciasEventoCambiarEstadoAsistencia}
  const BlocAsistenciasEventoCambiarEstadoAsistencia({
    required this.idAlumno,
    required this.idCurso,
    required this.estado,
  });

  /// Estado de la asistencia del alumno
  final EstadoAsistencia estado;

  /// Id del alumno a modificar
  final int idAlumno;

  /// Id del curso del alumno a modificar
  final int idCurso;
}

/// {@template BlocAsistenciasEventoAbrirCurso}
/// Evento que abre el curso
/// {@endtemplate}
class BlocAsistenciasEventoAbrirCurso extends BlocAsistenciasEvento {
  /// {@macro BlocAsistenciasEventoAbrirCurso}
  const BlocAsistenciasEventoAbrirCurso({
    required this.estaDesplegado,
    required this.index,
  });

  /// Indica si el curso se encuentra desplegado
  final bool estaDesplegado;

  /// Indice del curso
  final int index;
}

/// {@template BlocAsistenciasFinalizarAsistencia}
/// evento que finaliza la asistencia del dia de dicho curso
/// {@endtemplate}
class BlocAsistenciasFinalizarAsistencia extends BlocAsistenciasEvento {
  /// {@macro BlocAsistenciasFinalizarAsistencia}
  const BlocAsistenciasFinalizarAsistencia({
    required this.idCurso,
  });

  /// Id del curso  a modificar si se tomo asistencia.
  final int idCurso;
}
