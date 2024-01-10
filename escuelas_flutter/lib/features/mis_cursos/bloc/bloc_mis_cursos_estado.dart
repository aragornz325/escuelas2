part of 'bloc_mis_cursos.dart';

class ComisionAsignaturaOverview {
  const ComisionAsignaturaOverview({
    required this.nombreComision,
    required this.asignaturas,
  });
  final String nombreComision;

  final List<AsignaturaOverview> asignaturas;
}

class AsignaturaOverview {
  const AsignaturaOverview({
    required this.nombre,
    required this.tienePendientes,
  });

  final String nombre;
  final bool tienePendientes;
}

/// {@template BlocMisCursosEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocMisCursosEstado {
  /// {@macro BlocMisCursosEstado}
  const BlocMisCursosEstado._({
    this.comsiones = const [],
  });

  BlocMisCursosEstado.desde(
    BlocMisCursosEstado otro, {
    List<ComisionAsignaturaOverview>? comisiones,
  }) : this._(
          comsiones: comisiones ?? otro.comsiones,
        );

  /// Cursos del usuario.
  final List<ComisionAsignaturaOverview> comsiones;
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
  }) : super.desde();
}

/// {@template BlocMisCursosEstadoFallido}
/// Estado de error de los componentes de la pantalla 'Mis Cursos'
/// {@endtemplate}
class BlocMisCursosEstadoError extends BlocMisCursosEstado {
  /// {@macro BlocMisCursosEstadoError}
  BlocMisCursosEstadoError.desde(super.otro) : super.desde();
}
