part of 'bloc_supervision_asignatura.dart';

/// {@template BlocSupervisionAsignaturaEvento}
/// Maneja los eventos generales de la pantalla 'supervision de asignatura'
/// {@endtemplate}
class BlocSupervisionAsignaturaEvento {
  /// {@macro BlocSupervisionAsignaturaEvento}
  const BlocSupervisionAsignaturaEvento();

  List<Object> get props => [];
}

/// {@template BlocSupervisionAsignaturaEventoInicializar}
/// Evento para inicializar la pantalla de 'supervision de asignatura'.
/// {@endtemplate}
class BlocSupervisionAsignaturaEventoInicializar
    extends BlocSupervisionAsignaturaEvento {
  /// {@macro BlocSupervisionAsignaturaEventoInicializar}
  const BlocSupervisionAsignaturaEventoInicializar({
    required this.idComision,
    required this.idAsignatura,
    required this.idAutor,
    this.fecha,
  });

  /// Fecha utilizada para iniciar la pantalla de supervision de asignatura
  final DateTime? fecha;

  /// Id de la comision.
  final int idComision;

  /// Id de la asignatura.
  final int idAsignatura;

  /// Id del autor de la supervision de asignatura.
  final int idAutor;
}

/// {@template BlocSupervisionAsignaturaEnviarEmailAEstudiante}
/// Evento para enviar los mails de calificaciones al estudiante.
/// {@endtemplate}
class BlocSupervisionAsignaturaEnviarEmailAEstudiante
    extends BlocSupervisionAsignaturaEvento {
  /// {@macro BlocSupervisionAsignaturaEnviarEmailAEstudiante}
  const BlocSupervisionAsignaturaEnviarEmailAEstudiante(this.estudiante);

  /// Estudiante que se envia el mail.
  final Usuario? estudiante;
}

/// {@template BlocSupervisionAsignaturaEnviarEmailsAsingatura}
/// Evento para enviar los mails de calificaciones a la asignatura.
/// {@endtemplate}
class BlocSupervisionAsignaturaEnviarEmailsAsingatura
    extends BlocSupervisionAsignaturaEvento {
  /// {@macro BlocSupervisionAsignaturaEnviarEmailsAsingatura}
  const BlocSupervisionAsignaturaEnviarEmailsAsingatura();
}

/// {@template BlocSupervisionAsignaturaActualizarCalificaciones}
/// Evento para actualizar las calificaciones de los estudiantes.
/// {@endtemplate}
class BlocSupervisionAsignaturaActualizarCalificaciones
    extends BlocSupervisionAsignaturaEvento {
  /// {@macro BlocSupervisionAsignaturaActualizarCalificaciones}
  const BlocSupervisionAsignaturaActualizarCalificaciones();
}

/// {@template BlocCargaCalificacionesEventoAgregarCalificacion}
/// Evento para agregar una calificación a un alumno
/// {@endtemplate}
class BlocCargaCalificacionesEventoAgregarCalificacion
    extends BlocSupervisionAsignaturaEvento {
  /// {@macro BlocCargaCalificacionesEventoAgregarCalificacion}
  const BlocCargaCalificacionesEventoAgregarCalificacion({
    required this.calificacion,
    required this.idAlumno,
  });

  final String calificacion;
  final int idAlumno;
}
