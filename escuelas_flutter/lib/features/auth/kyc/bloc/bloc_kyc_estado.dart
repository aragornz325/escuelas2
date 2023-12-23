part of 'bloc_kyc.dart';

/// {@template BlocKycEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocKycEstado {
  /// {@macro BlocKycEstado}
  const BlocKycEstado._({
    this.listaCursos = const [],
    this.listaMaterias = const [],
  });

  BlocKycEstado.desde(
    BlocKycEstado otro, {
    List<Curso>? listaCursos,
    List<Materia>? listaMaterias,
  }) : this._(
          listaCursos: listaCursos ?? otro.listaCursos,
          listaMaterias: listaMaterias ?? otro.listaMaterias,
        );

  final List<Curso> listaCursos;
  final List<Materia> listaMaterias;
}

/// {@template BlocKycEstadoInicial}
/// Estado inicial de los componentes de la pantalla 'Inicio'
/// {@endtemplate}
class BlocKycEstadoInicial extends BlocKycEstado {
  /// {@macro BlocKycEstadoInicial}
  const BlocKycEstadoInicial() : super._();
}

/// {@template BlocKycEstadoCargando}
/// Estado de cargando de los componentes de la pantalla 'Inicio'
/// {@endtemplate}
class BlocKycEstadoCargando extends BlocKycEstado {
  /// {@macro BlocKycEstadoCargando}
  BlocKycEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocKycEstadoExitoso}
/// Estado exitoso general de los componentes de la pantalla 'Inicio'
/// {@endtemplate}
class BlocKycEstadoExitoso extends BlocKycEstado {
  /// {@macro BlocKycEstadoExitoso}
  BlocKycEstadoExitoso.desde(
    super.otro, {
    super.listaCursos,
    super.listaMaterias,
  }) : super.desde();
}

/// {@template BlocKycEstadoFallido}
/// Estado de error de los componentes de la pantalla 'Inicio'
/// {@endtemplate}
class BlocKycEstadoError extends BlocKycEstado {
  /// {@macro BlocKycEstadoError}
  BlocKycEstadoError.desde(super.otro) : super.desde();
}
