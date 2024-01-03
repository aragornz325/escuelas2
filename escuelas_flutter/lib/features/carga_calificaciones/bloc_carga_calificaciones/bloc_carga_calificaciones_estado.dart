part of 'bloc_carga_calificaciones.dart';

/// {@template BlocCargaCalificacionesEstado}
/// Maneja el estado del bloc de las calificaciones de los alumnos dependiendo
/// del rol del usuario.
/// {@endtemplate}
@immutable
class BlocCargaCalificacionesEstado {
  /// {@macro BlocCargaCalificacionesEstado}
  const BlocCargaCalificacionesEstado._({
    this.rolDelUsuario,
    this.listaCalificaciones = const [],
    this.calificacion,
  });

  BlocCargaCalificacionesEstado.desde(
    BlocCargaCalificacionesEstado otro, {
    List<ModeloCalificacion>? listaCalificaciones,
    Rol? rolDelUsuario,
    ModeloCalificacion? calificacion,
  }) : this._(
          listaCalificaciones: listaCalificaciones ?? otro.listaCalificaciones,
          rolDelUsuario: rolDelUsuario ?? otro.rolDelUsuario,
          calificacion: calificacion ?? otro.calificacion,
        );

  /// Lista de listas de los alumnos
  final List<ModeloCalificacion> listaCalificaciones;

  /// Lista de los alumnos
  final ModeloCalificacion? calificacion;

  /// Rol del usuario //TODO(anyone): reemplazar por el modelo del rol
  final Rol? rolDelUsuario;

  List<Object?> get props => [
        listaCalificaciones,
        rolDelUsuario,
        calificacion,
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

/// {@template BlocCargaCalificacionesEstadoEnviadasCorrectamente}
/// Estado de `enviadas correctamente` de los componentes de la pantalla
/// 'Carga de calificaciones' para que muestre un popup indicando que las
///  calificaciones fueron enviadas.
/// {@endtemplate}
class BlocCargaCalificacionesEstadoEnviadasCorrectamente
    extends BlocCargaCalificacionesEstado {
  /// {@macro BlocCargaCalificacionesEstadoEnviadasCorrectamente}
  BlocCargaCalificacionesEstadoEnviadasCorrectamente.desde(super.otro)
      : super.desde();
}

/// {@template BlocCargaCalificacionesEstadoFallidoAlEnviarNotas}
/// Estado de `error al enviar notas` de los componentes de la pantalla
/// 'Carga de calificaciones' para que muestre un popup indicando que las
/// calificaciones no fueron enviadas.
/// {@endtemplate}
class BlocCargaCalificacionesEstadoFallidoAlEnviarNotas
    extends BlocCargaCalificacionesEstado {
  /// {@macro BlocCargaCalificacionesEstadoFallidoAlEnviarNotas}
  BlocCargaCalificacionesEstadoFallidoAlEnviarNotas.desde(super.otro)
      : super.desde();
}
