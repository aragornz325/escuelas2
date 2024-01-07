part of 'bloc_carga_calificaciones.dart';

/// {@template BlocCargaCalificacionesEstado}
/// Maneja el estado del bloc de las calificaciones de los alumnos dependiendo
/// del rol del usuario.
/// {@endtemplate}
class BlocCargaCalificacionesEstado {
  /// {@macro BlocCargaCalificacionesEstado}
  const BlocCargaCalificacionesEstado._({
    this.rolDelUsuario,
    this.curso,
    this.fecha,
    this.listaCalificacionesCompensadas = const [],
    this.listaCalificaciones = const [],
  });

  BlocCargaCalificacionesEstado.desde(
    BlocCargaCalificacionesEstado otro, {
    ComisionDeCurso? curso,
    RolDeUsuario? rolDelUsuario,
    Asignatura? asignatura,
    List<CalificacionCompensacion>? listaCalificacionesCompensadas,
    DateTime? fecha,
    List<Calificacion>? listaCalificaciones,
  }) : this._(
          fecha: fecha ?? otro.fecha,
          curso: curso ?? otro.curso,
          rolDelUsuario: rolDelUsuario ?? otro.rolDelUsuario,
          listaCalificacionesCompensadas: listaCalificacionesCompensadas ??
              otro.listaCalificacionesCompensadas,
          listaCalificaciones: listaCalificaciones ?? otro.listaCalificaciones,
        );

  /// Curso con los alumnos.
  final ComisionDeCurso? curso;

  /// Rol del usuario
  final RolDeUsuario? rolDelUsuario;

  /// Periodo actual del calendaio
  final DateTime? fecha;

  final List<CalificacionCompensacion> listaCalificacionesCompensadas;

  final List<Calificacion> listaCalificaciones;

  /// Indica si el estado es
  /// [BlocCargaCalificacionesEstadoFallidoAlEnviarCalificaciones]
  bool get falloAlEnviarCalificaciones =>
      this is BlocCargaCalificacionesEstadoFallidoAlEnviarCalificaciones;

  /// Indica si el estado es
  /// [BlocCargaCalificacionesEstadoCalificacionesEnviadasCorrectamente]
  bool get exitoAlEnviarCalificaciones =>
      this is BlocCargaCalificacionesEstadoCalificacionesEnviadasCorrectamente;

  List<Object?> get props => [
        curso,
        fecha,
        rolDelUsuario,
        listaCalificaciones,
        listaCalificacionesCompensadas,
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
    super.curso,
    super.fecha,
    super.asignatura,
    super.rolDelUsuario,
    super.listaCalificaciones,
    super.listaCalificacionesCompensadas,
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
