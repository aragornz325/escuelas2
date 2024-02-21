part of 'bloc_calificaciones_mensuales.dart';

/// {@template BlocCalificacionesMensualesEstado}
/// Bloc que maneja el estado de las CalificacionesMensuales
/// {@endtemplate}
@immutable
class BlocCalificacionesMensualesEstado {
  /// {@macro BlocCalificacionesMensualesEstado}
  const BlocCalificacionesMensualesEstado._({
    this.fecha,
    this.listaCalificacionesPorMateria = const [],
  });

  BlocCalificacionesMensualesEstado.desde(
    BlocCalificacionesMensualesEstado otro, {
    DateTime? fecha,
    List<CalificacionMensual>? listaCalificacionesPorMateria,
  }) : this._(
          fecha: fecha ?? otro.fecha,
          listaCalificacionesPorMateria: listaCalificacionesPorMateria ??
              otro.listaCalificacionesPorMateria,
        );

  /// Periodo actual del calendario
  final DateTime? fecha;

  /// Contiene una lista de calificaciones mensuales del mes actual
  final List<CalificacionMensual> listaCalificacionesPorMateria;

  List<Object?> get props => [fecha, listaCalificacionesPorMateria];
}

/// {@template BlocCalificacionesMensualesEstadoInicial}
/// Estado Inicial de la pagina de 'CalificacionesMensuales'
/// {@endtemplate}
class BlocCalificacionesMensualesEstadoInicial
    extends BlocCalificacionesMensualesEstado {
  /// {@macro BlocCalificacionesMensualesEstadoInicial}
  const BlocCalificacionesMensualesEstadoInicial({super.fecha}) : super._();
}

/// {@template BlocCalificacionesMensualesEstadoCargando}
/// Estado Cargando de la pagina de 'CalificacionesMensuales'
/// {@endtemplate}
class BlocCalificacionesMensualesEstadoCargando
    extends BlocCalificacionesMensualesEstado {
  /// {@macro BlocCalificacionesMensualesEstadoCargando}
  BlocCalificacionesMensualesEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocCalificacionesMensualesEstadoExitoso}
/// Estado Exitoso de la pagina de 'CalificacionesMensuales'
/// {@endtemplate}
class BlocCalificacionesMensualesEstadoExitoso
    extends BlocCalificacionesMensualesEstado {
  /// {@macro BlocCalificacionesMensualesEstadoExitoso}
  BlocCalificacionesMensualesEstadoExitoso.desde(
    super.otro, {
    super.listaCalificacionesPorMateria,
  }) : super.desde();
}

/// {@template BlocCalificacionesMensualesEstadoFallido}
/// Estado Fallido de la pagina de 'CalificacionesMensuales'
/// {@endtemplate}
class BlocCalificacionesMensualesEstadoFallido
    extends BlocCalificacionesMensualesEstado {
  /// {@macro BlocCalificacionesMensualesEstadoFallido}
  BlocCalificacionesMensualesEstadoFallido.desde(super.otro) : super.desde();
}
