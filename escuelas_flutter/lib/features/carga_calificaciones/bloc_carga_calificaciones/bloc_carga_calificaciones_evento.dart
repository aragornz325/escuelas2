part of 'bloc_carga_calificaciones.dart';

/// {@template BlocCargaCalificacionesEvento}
/// Maneja los eventos generales de la pantalla 'Carga de calificaciones'
/// {@endtemplate}
@immutable
class BlocCargaCalificacionesEvento {
  /// {@macro BlocCargaCalificacionesEvento}
  const BlocCargaCalificacionesEvento();

  List<Object> get props => [];
}

/// {@template BlocCargaCalificacionesEventoInicializar}
/// Evento para inicializar la pantalla de 'Carga de calificaciones'.
/// {@endtemplate}
@immutable
class BlocCargaCalificacionesEventoInicializar
    extends BlocCargaCalificacionesEvento {
  /// {@macro BlocCargaCalificacionesEventoInicializar}
  const BlocCargaCalificacionesEventoInicializar({required this.fecha});

  /// Fecha utilizada para iniciar la pantalla de carga de calificaciones
  final DateTime fecha;
}

/// {@template BlocCargaCalificacionesEventoFiltrarListaPorFecha}
/// Evento que filtra la lista de los alumnos para buscar entre listas de listas
/// de calificaciones por una fecha en especifica.
/// {@endtemplate}
@immutable
class BlocCargaCalificacionesEventoFiltrarListaPorFecha
    extends BlocCargaCalificacionesEvento {
  /// {@macro BlocCargaCalificacionesEventoFiltrarListaPorFecha}
  const BlocCargaCalificacionesEventoFiltrarListaPorFecha({
    required this.fecha,
  });

  /// Fecha para hacer la búsqueda entre listas
  final DateTime fecha;
}

/// {@template BlocCargaCalificacionesEventoCambiarCalificacionAlumno}
/// Evento para cambiarle una calificación a un alumno
/// {@endtemplate}
@immutable
class BlocCargaCalificacionesEventoCambiarCalificacionAlumno
    extends BlocCargaCalificacionesEvento {
  /// {@macro BlocCargaCalificacionesEventoCambiarCalificacionAlumno}
  const BlocCargaCalificacionesEventoCambiarCalificacionAlumno({
    required this.calificacion,
    required this.fecha,
    required this.idAlumno,
  });

  /// Fecha para la calificación
  final DateTime fecha;

  /// Calificación nueva para el alumno
  final int? calificacion;

  /// Id del alumno a modificar la nota
  final int idAlumno;
}

/// {@template BlocCargaCalificacionesEventoVaciarCalificaciones}
/// Evento para vaciar las calificaciones cargadas
/// {@endtemplate}
@immutable
class BlocCargaCalificacionesEventoVaciarCalificaciones
    extends BlocCargaCalificacionesEvento {
  /// {@macro BlocCargaCalificacionesEventoVaciarCalificaciones}
  const BlocCargaCalificacionesEventoVaciarCalificaciones();
}

/// {@template BlocCargaCalificacionesEventoEnviarCalificaciones}
/// Evento para enviar todas las calificaciones cargadas
/// {@endtemplate}
@immutable
class BlocCargaCalificacionesEventoEnviarCalificaciones
    extends BlocCargaCalificacionesEvento {
  /// {@macro BlocCargaCalificacionesEventoEnviarCalificaciones}
  const BlocCargaCalificacionesEventoEnviarCalificaciones();
}
