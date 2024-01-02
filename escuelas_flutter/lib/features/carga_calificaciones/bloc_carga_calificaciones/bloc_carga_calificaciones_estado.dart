part of 'bloc_carga_calificaciones.dart';

/// {@template PaginaInicio}
/// Todo agregar docu
/// {@endtemplate}
@immutable
class BlocCargaCalificacionesEstado {
  /// {@macro PaginaInicio}
  const BlocCargaCalificacionesEstado._({
    this.rolDelUsuario,
    this.alumnos = const [],
  });

  BlocCargaCalificacionesEstado.desde(
    BlocCargaCalificacionesEstado otro, {
    List<ModeloAlumno>? alumnos,
    Rol? rolDelUsuario,
  }) : this._(
          alumnos: alumnos ?? otro.alumnos,
          rolDelUsuario: rolDelUsuario ?? otro.rolDelUsuario,
        );

  /// Lista de alumnos toda hard
  final List<ModeloAlumno> alumnos;

  final Rol? rolDelUsuario;

  List<Object?> get props => [
        alumnos,
        rolDelUsuario,
      ];
}

/// {@template BlocKycEstadoInicial}
/// Estado inicial de los componentes de la pantalla 'Kyc'
/// {@endtemplate}
class BlocCargaCalificacionesEstadoInicial
    extends BlocCargaCalificacionesEstado {
  /// {@macro BlocKycEstadoInicial}
  const BlocCargaCalificacionesEstadoInicial() : super._();
}

/// {@template BlocKycEstadoCargando}
/// Todo agregar docu
/// {@endtemplate}
class BlocCargaCalificacionesEstadoCargando
    extends BlocCargaCalificacionesEstado {
  /// {@macro BlocKycEstadoCargando}
  BlocCargaCalificacionesEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocKycEstadoExitoso}
/// Estado exitoso general de los componentes de la pantalla 'Kyc'
/// {@endtemplate}
class BlocCargaCalificacionesEstadoExitoso
    extends BlocCargaCalificacionesEstado {
  /// {@macro BlocKycEstadoExitoso}
  BlocCargaCalificacionesEstadoExitoso.desde(
    super.otro, {
    super.alumnos,
    super.rolDelUsuario,
  }) : super.desde();
}

/// {@template BlocKycEstadoFallido}
/// Todo agregar docu
/// {@endtemplate}
class BlocCargaCalificacionesEstadoError extends BlocCargaCalificacionesEstado {
  /// {@macro BlocKycEstadoError}
  BlocCargaCalificacionesEstadoError.desde(super.otro) : super.desde();
}
