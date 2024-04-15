part of 'bloc_supervision_asignatura.dart';

/// {@template BlocSupervisionAsignaturaEstado}
/// Maneja el estado del bloc de las supervisiones de asignatura
/// {@endtemplate}
class BlocSupervisionAsignaturaEstado {
  /// {@macro BlocSupervisionAsignaturaEstado}
  const BlocSupervisionAsignaturaEstado._({
    this.comision,
    this.listaCalificacionesMesActual = const [],
    this.fecha,
    this.listaCalificacionesMesesRestantes = const [],
    this.asignatura,
    this.calificacionesMensuales,
  });

  BlocSupervisionAsignaturaEstado.desde(
    BlocSupervisionAsignaturaEstado otro, {
    List<CalificacionMensual>? listaCalificacionesMesActual,
    ComisionDeCurso? comision,
    Asignatura? asignatura,
    DateTime? fecha,
    List<List<CalificacionMensual>>? listaCalificacionesMesesRestantes,
    CalificacionesMensuales? calificacionesMensuales,
  }) : this._(
          fecha: fecha ?? otro.fecha,
          comision: comision ?? otro.comision,
          listaCalificacionesMesesRestantes:
              listaCalificacionesMesesRestantes ??
                  otro.listaCalificacionesMesesRestantes,
          asignatura: asignatura ?? otro.asignatura,
          listaCalificacionesMesActual:
              listaCalificacionesMesActual ?? otro.listaCalificacionesMesActual,
          calificacionesMensuales:
              calificacionesMensuales ?? otro.calificacionesMensuales,
        );

  /// Comision con los alumnos.
  final ComisionDeCurso? comision;

  /// Asignatura del usuario
  final Asignatura? asignatura;

  /// Periodo actual del calendario
  final DateTime? fecha;

  /// Calificaciones mensuales de los alumnos contiene las calificaciones
  /// mensuales por periodo y la solicitud de envio de notas
  final CalificacionesMensuales? calificacionesMensuales;

  /// Contiene una lista de calificaciones mensuales del mes actual
  final List<CalificacionMensual> listaCalificacionesMesActual;

  /// Contiene las calificaciones mensuales de los meses restantes
  final List<List<CalificacionMensual>> listaCalificacionesMesesRestantes;

  /// lista de estudiantes de una comision
  List<RelacionComisionUsuario> get estudiantes => comision?.estudiantes ?? [];

  List<Object?> get props => [
        comision,
        fecha,
        listaCalificacionesMesesRestantes,
        listaCalificacionesMesActual,
        asignatura,
        calificacionesMensuales,
      ];
}

/// {@template BlocSupervisionAsignaturaEstadoInicial}
/// Estado `inicial` de los componentes de la pantalla
/// 'supervision de asignatura'
/// {@endtemplate}
class BlocSupervisionAsignaturaEstadoInicial
    extends BlocSupervisionAsignaturaEstado {
  /// {@macro BlocSupervisionAsignaturaEstadoInicial}
  const BlocSupervisionAsignaturaEstadoInicial({super.fecha}) : super._();
}

/// {@template BlocSupervisionAsignaturaEstadoCargando}
/// Estado `cargando` de los componentes en la pantalla de
/// 'supervision de asignatura'
/// {@endtemplate}
class BlocSupervisionAsignaturaEstadoCargando
    extends BlocSupervisionAsignaturaEstado {
  /// {@macro BlocSupervisionAsignaturaEstadoCargando}
  BlocSupervisionAsignaturaEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocSupervisionAsignaturaEstadoEnviandoEmail}
/// Estado `enviandoEmail` de los componentes de la pantalla.
/// {@endtemplate}
class BlocSupervisionAsignaturaEstadoEnviandoEmail
    extends BlocSupervisionAsignaturaEstado {
  /// {@macro BlocSupervisionAsignaturaEstadoEnviandoEmail}
  BlocSupervisionAsignaturaEstadoEnviandoEmail.desde(super.otro)
      : super.desde();
}

/// {@template BlocSupervisionAsignaturaEstadoExitoso}
/// Estado `exitoso` general de los componentes de la pantalla
/// 'supervision de asignatura'
/// {@endtemplate}
class BlocSupervisionAsignaturaEstadoExitoso
    extends BlocSupervisionAsignaturaEstado {
  /// {@macro BlocSupervisionAsignaturaEstadoExitoso}
  BlocSupervisionAsignaturaEstadoExitoso.desde(
    super.otro, {
    super.comision,
    super.fecha,
    super.asignatura,
    super.listaCalificacionesMesActual,
    super.listaCalificacionesMesesRestantes,
    super.calificacionesMensuales,
  }) : super.desde();
}

/// {@template BlocSupervisionAsignaturaEstadoExitosoAlEnviarEmail}
/// Estado `exitoso` Cuando se envia el email a un alumno
/// {@endtemplate}
class BlocSupervisionAsignaturaEstadoExitosoAlEnviarEmail
    extends BlocSupervisionAsignaturaEstado {
  /// {@macro BlocSupervisionAsignaturaEstadoExitosoAlEnviarEmail}
  BlocSupervisionAsignaturaEstadoExitosoAlEnviarEmail.desde(
    super.otro, {
    required this.nombreEstudiante,
  }) : super.desde();

  /// Nombre del estudiante al que se le envio el email.
  final String nombreEstudiante;
}

/// {@template BlocSupervisionAsignaturaEstadoFallido}
/// Estado de `error general` de los componentes de la pantalla
/// 'supervision de asignatura'
/// {@endtemplate}
class BlocSupervisionAsignaturaEstadoFallido
    extends BlocSupervisionAsignaturaEstado {
  /// {@macro BlocSupervisionAsignaturaEstadoFallido}
  BlocSupervisionAsignaturaEstadoFallido.desde(super.otro) : super.desde();
}
