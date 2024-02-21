part of 'bloc_comisiones.dart';

/// {@template BlocComisionesEstado}
/// Estado general de los componentes de la pantalla 'Comisiones'
/// {@endtemplate}
@immutable
class BlocComisionesEstado {
  /// {@macro BlocComisionesEstado}
  const BlocComisionesEstado._({
    this.comisionesConAsignaturas = const [],
  });

  BlocComisionesEstado.desde(
    BlocComisionesEstado otro, {
    List<ComisionConAsignaturas>? comisionesConAsignaturas,
  }) : this._(
          comisionesConAsignaturas:
              comisionesConAsignaturas ?? otro.comisionesConAsignaturas,
        );

  /// Comisiones con asignaturas para la vista directivo.
  final List<ComisionConAsignaturas> comisionesConAsignaturas;
}

/// {@template BlocComisionesEstadoInicial}
/// Estado inicial de los componentes de la pantalla 'Comisiones'
/// {@endtemplate}
class BlocComisionesEstadoInicial extends BlocComisionesEstado {
  /// {@macro BlocComisionesEstadoInicial}
  const BlocComisionesEstadoInicial() : super._();
}

/// {@template BlocComisionesEstadoCargando}
/// Estado de cargando de los componentes de la pantalla 'Comisiones'
/// {@endtemplate}
class BlocComisionesEstadoCargando extends BlocComisionesEstado {
  /// {@macro BlocComisionesEstadoCargando}
  BlocComisionesEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocComisionesEstadoExitoso}
/// Estado exitoso general de los componentes de la pantalla 'Comisiones'
/// {@endtemplate}
class BlocComisionesEstadoExitoso extends BlocComisionesEstado {
  /// {@macro BlocComisionesEstadoExitoso}
  BlocComisionesEstadoExitoso.desde(
    super.otro, {
    super.comisionesConAsignaturas,
  }) : super.desde();
}

/// {@template BlocComisionesEstadoError}
/// Estado de error de los componentes de la pantalla 'Comisiones'
/// {@endtemplate}
class BlocComisionesEstadoError extends BlocComisionesEstado {
  /// {@macro BlocComisionesEstadoError}
  BlocComisionesEstadoError.desde(super.otro) : super.desde();
}
