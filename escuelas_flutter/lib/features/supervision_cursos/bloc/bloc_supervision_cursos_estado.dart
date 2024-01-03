part of 'bloc_supervision_cursos.dart';

/// {@template BlocSupervisionCursosEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocSupervisionCursosEstado {
  /// {@macro BlocSupervisionCursosEstado}
  const BlocSupervisionCursosEstado._({
    this.listaCursos = const [],
  });

  BlocSupervisionCursosEstado.desde(
    BlocSupervisionCursosEstado otro, {
    List<CursosPorPeriodo>? listaCursos,
  }) : this._(
          listaCursos: listaCursos ?? otro.listaCursos,
        );
  final List<CursosPorPeriodo> listaCursos;
  bool get todasMateriasCargadas => true;
  bool get habilitacionCargaDeCalificaciones => true;
  DateTime get fechaUltimaMateriaCargada => DateTime.now();
}

/// {@template BlocSupervisionCursosEstadoInicial}
/// Estado inicial de los componentes de la pantalla 'SupervisionCursos'
/// {@endtemplate}
class BlocSupervisionCursosEstadoInicial extends BlocSupervisionCursosEstado {
  /// {@macro BlocSupervisionCursosEstadoInicial}
  const BlocSupervisionCursosEstadoInicial() : super._();
}

/// {@template BlocSupervisionCursosEstadoCargando}
/// Estado de cargando de los componentes de la pantalla 'SupervisionCursos'
/// {@endtemplate}
class BlocSupervisionCursosEstadoCargando extends BlocSupervisionCursosEstado {
  /// {@macro BlocSupervisionCursosEstadoCargando}
  BlocSupervisionCursosEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocSupervisionCursosEstadoExitoso}
/// Estado exitoso general de los componentes de la pantalla 'SupervisionCursos'
/// {@endtemplate}
class BlocSupervisionCursosEstadoExitoso extends BlocSupervisionCursosEstado {
  /// {@macro BlocSupervisionCursosEstadoExitoso}
  BlocSupervisionCursosEstadoExitoso.desde(
    super.otro, {
    super.listaCursos,
  }) : super.desde();
}

/// {@template BlocSupervisionCursosEstadoFallido}
/// Estado de error de los componentes de la pantalla 'SupervisionCursos'
/// {@endtemplate}
class BlocSupervisionCursosEstadoError extends BlocSupervisionCursosEstado {
  /// {@macro BlocSupervisionCursosEstadoError}
  BlocSupervisionCursosEstadoError.desde(super.otro) : super.desde();
}
