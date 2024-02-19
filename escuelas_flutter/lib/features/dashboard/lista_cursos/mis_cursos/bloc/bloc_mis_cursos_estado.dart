part of 'bloc_mis_cursos.dart';

/// {@template BlocMisCursosEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocMisCursosEstado {
  /// {@macro BlocMisCursosEstado}
  const BlocMisCursosEstado._({
    this.comisiones = const [],
    this.comisionesConAsignaturas = const [],
  });

  BlocMisCursosEstado.desde(
    BlocMisCursosEstado otro, {
    List<ComisionOverview>? comisiones,
    List<ComisionConAsignaturas>? comisionesConAsignaturas,
  }) : this._(
          comisiones: comisiones ?? otro.comisiones,
          comisionesConAsignaturas:
              comisionesConAsignaturas ?? otro.comisionesConAsignaturas,
        );

  /// Cursos del usuario.
  final List<ComisionOverview> comisiones;

  /// Comisiones con asignaturas para la vista directivo.
  final List<ComisionConAsignaturas> comisionesConAsignaturas;
}

/// {@template BlocMisCursosEstadoInicial}
/// Estado inicial de los componentes de la pantalla 'Mis Cursos'
/// {@endtemplate}
class BlocMisCursosEstadoInicial extends BlocMisCursosEstado {
  /// {@macro BlocMisCursosEstadoInicial}
  const BlocMisCursosEstadoInicial() : super._();
}

/// {@template BlocMisCursosEstadoCargando}
/// Estado de cargando de los componentes de la pantalla 'Mis Cursos'
/// {@endtemplate}
class BlocMisCursosEstadoCargando extends BlocMisCursosEstado {
  /// {@macro BlocMisCursosEstadoCargando}
  BlocMisCursosEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocMisCursosEstadoExitoso}
/// Estado exitoso general de los componentes de la pantalla 'Mis Cursos'
/// {@endtemplate}
class BlocMisCursosEstadoExitoso extends BlocMisCursosEstado {
  /// {@macro BlocMisCursosEstadoExitoso}
  BlocMisCursosEstadoExitoso.desde(
    super.otro, {
    super.comisiones,
    super.comisionesConAsignaturas,
  }) : super.desde();
}

/// {@template BlocMisCursosEstadoFallido}
/// Estado de error de los componentes de la pantalla 'Mis Cursos'
/// {@endtemplate}
class BlocMisCursosEstadoError extends BlocMisCursosEstado {
  /// {@macro BlocMisCursosEstadoError}
  BlocMisCursosEstadoError.desde(super.otro) : super.desde();
}
