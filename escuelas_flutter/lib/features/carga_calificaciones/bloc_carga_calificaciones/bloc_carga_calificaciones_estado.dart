part of 'bloc_carga_calificaciones.dart';

/// {@template BlocCargaCalificacionesEstado}
/// Maneja el estado del bloc de las calificaciones de los alumnos dependiendo
/// del rol del usuario.
/// {@endtemplate}
class BlocCargaCalificacionesEstado {
  /// {@macro BlocCargaCalificacionesEstado}
  const BlocCargaCalificacionesEstado._({
    this.rolDelUsuario,
    this.listaCalificaciones = const [],
    this.calificacion,
    this.periodo,
  });

  BlocCargaCalificacionesEstado.desde(
    BlocCargaCalificacionesEstado otro, {
    List<ModeloCalificacion>? listaCalificaciones,
    RolDeUsuario? rolDelUsuario,
    ModeloCalificacion? calificacion,
    PeriodoDelSelector? periodo,
  }) : this._(
          listaCalificaciones: listaCalificaciones ?? otro.listaCalificaciones,
          rolDelUsuario: rolDelUsuario ?? otro.rolDelUsuario,
          calificacion: calificacion ?? otro.calificacion,
          periodo: periodo ?? otro.periodo,
        );

  /// Lista de listas de los alumnos
  final List<ModeloCalificacion> listaCalificaciones;

  /// Lista de los alumnos
  final ModeloCalificacion? calificacion;

  /// Rol del usuario //TODO(anyone): reemplazar por el modelo del rol
  final RolDeUsuario? rolDelUsuario;

  /// Periodo actual del calendaio
  final PeriodoDelSelector? periodo;

  /// Indica si el estado es
  /// [BlocCargaCalificacionesEstadoFallidoAlEnviarCalificaciones]
  bool get falloAlEnviarCalificaciones =>
      this is BlocCargaCalificacionesEstadoFallidoAlEnviarCalificaciones;

  /// Indica si el estado es
  /// [BlocCargaCalificacionesEstadoCalificacionesEnviadasCorrectamente]
  bool get exitoAlEnviarCalificaciones =>
      this is BlocCargaCalificacionesEstadoCalificacionesEnviadasCorrectamente;

  List<Object?> get props => [
        listaCalificaciones,
        rolDelUsuario,
        calificacion,
        periodo,
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
    super.listaCalificaciones,
    super.rolDelUsuario,
    super.calificacion,
    super.periodo,
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
