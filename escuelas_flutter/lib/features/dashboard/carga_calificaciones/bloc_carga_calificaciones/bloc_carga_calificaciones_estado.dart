part of 'bloc_carga_calificaciones.dart';

/// {@template BlocCargaCalificacionesEstado}
/// Maneja el estado del bloc de las calificaciones de los alumnos dependiendo
/// del rol del usuario.
/// {@endtemplate}
class BlocCargaCalificacionesEstado {
  /// {@macro BlocCargaCalificacionesEstado}
  const BlocCargaCalificacionesEstado._({
    this.comision,
    this.calificacionesMensuales,
    this.fecha,
    this.listaCalificaciones = const [],
    this.asignatura,
  });

  BlocCargaCalificacionesEstado.desde(
    BlocCargaCalificacionesEstado otro, {
    CalificacionesMensuales? calificacionesMensuales,
    ComisionDeCurso? comision,
    Asignatura? asignatura,
    DateTime? fecha,
    List<CalificacionDeAlumno>? listaCalificaciones,
  }) : this._(
          fecha: fecha ?? otro.fecha,
          comision: comision ?? otro.comision,
          listaCalificaciones: listaCalificaciones ?? otro.listaCalificaciones,
          asignatura: asignatura ?? otro.asignatura,
          calificacionesMensuales:
              calificacionesMensuales ?? otro.calificacionesMensuales,
        );

  /// Comision con los alumnos.
  final ComisionDeCurso? comision;

  /// Asignatura del usuario
  final Asignatura? asignatura;

  /// Periodo actual del calendaio
  final DateTime? fecha;

  /// Contiene una lista de calificaciones mensuales y
  /// la solicitud de envio de notas si fue aprobada o no por el admin.
  final CalificacionesMensuales? calificacionesMensuales;

  final List<CalificacionDeAlumno> listaCalificaciones;

  /// Indica si el estado es
  /// [BlocCargaCalificacionesEstadoFallidoAlEnviarCalificaciones]
  bool get falloAlEnviarCalificaciones =>
      this is BlocCargaCalificacionesEstadoFallidoAlEnviarCalificaciones;

  /// Indica si el estado es
  /// [BlocCargaCalificacionesEstadoCalificacionesEnviadasCorrectamente]
  bool get exitoAlEnviarCalificaciones =>
      this is BlocCargaCalificacionesEstadoCalificacionesEnviadasCorrectamente;

  /// lista de estudiantes de una comision
  List<RelacionComisionUsuario> get estudiantes => comision?.estudiantes ?? [];

  List<Object?> get props => [
        comision,
        fecha,
        listaCalificaciones,
        calificacionesMensuales,
        asignatura,
      ];
}

/// {@template BlocCargaCalificacionesEstadoInicial}
/// Estado `inicial` de los componentes de la pantalla 'Carga de calificaciones'
/// {@endtemplate}
class BlocCargaCalificacionesEstadoInicial
    extends BlocCargaCalificacionesEstado {
  /// {@macro BlocCargaCalificacionesEstadoInicial}
  const BlocCargaCalificacionesEstadoInicial() : super._();
}

/// {@template BlocCargaCalificacionesEstadoCargando}
/// Estado `cargando` de los componentes en la pantalla de
/// 'Carga de calificaciones'
/// {@endtemplate}
class BlocCargaCalificacionesEstadoCargando
    extends BlocCargaCalificacionesEstado {
  /// {@macro BlocCargaCalificacionesEstadoCargando}
  BlocCargaCalificacionesEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocCargaCalificacionesEstadoExitoso}
/// Estado `exitoso` general de los componentes de la pantalla
/// 'Carga de calificaciones'
/// {@endtemplate}
class BlocCargaCalificacionesEstadoExitoso
    extends BlocCargaCalificacionesEstado {
  /// {@macro BlocCargaCalificacionesEstadoExitoso}
  BlocCargaCalificacionesEstadoExitoso.desde(
    super.otro, {
    super.comision,
    super.fecha,
    super.asignatura,
    super.calificacionesMensuales,
    super.listaCalificaciones,
  }) : super.desde();
}

/// {@template BlocCargaCalificacionesEstadoFallido}
/// Estado de `error general` de los componentes de la pantalla
/// 'Carga de calificaciones'
/// {@endtemplate}
class BlocCargaCalificacionesEstadoFallido
    extends BlocCargaCalificacionesEstado {
  /// {@macro BlocCargaCalificacionesEstadoFallido}
  BlocCargaCalificacionesEstadoFallido.desde(super.otro) : super.desde();
}

/// {@template BlocCargaCalificacionesEstadoCalificacionesEnviadasCorrectamente}
/// Estado de `enviadas correctamente` de los componentes de la pantalla
/// 'Carga de calificaciones' para que muestre un popup indicando que las
///  calificaciones fueron enviadas.
/// {@endtemplate}
class BlocCargaCalificacionesEstadoCalificacionesEnviadasCorrectamente
    extends BlocCargaCalificacionesEstado {
  /// {@macro BlocCargaCalificacionesEstadoCalificacionesEnviadasCorrectamente}
  BlocCargaCalificacionesEstadoCalificacionesEnviadasCorrectamente.desde(
    super.otro,
  ) : super.desde();
}

/// {@template BlocCargaCalificacionesEstadoFallidoAlEnviarCalificaciones}
/// Estado de `error al enviar notas` de los componentes de la pantalla
/// 'Carga de calificaciones' para que muestre un popup indicando que las
/// calificaciones no fueron enviadas.
/// {@endtemplate}
class BlocCargaCalificacionesEstadoFallidoAlEnviarCalificaciones
    extends BlocCargaCalificacionesEstado {
  /// {@macro BlocCargaCalificacionesEstadoFallidoAlEnviarCalificaciones}
  BlocCargaCalificacionesEstadoFallidoAlEnviarCalificaciones.desde(super.otro)
      : super.desde();
}

/// {@template BlocCargaCalificacionesEstadoExitosoAlBorrarCalificacionesCargadas}
/// Sirve para que muestre un popup indicando que las calificaciones fueron
/// borradas.
/// {@endtemplate}
class BlocCargaCalificacionesEstadoExitosoAlBorrarCalificacionesCargadas
    extends BlocCargaCalificacionesEstado {
  /// {@macro BlocCargaCalificacionesEstadoExitosoAlBorrarCalificacionesCargadas}
  BlocCargaCalificacionesEstadoExitosoAlBorrarCalificacionesCargadas.desde(
    super.otro, {
    super.listaCalificaciones,
  }) : super.desde();
}
