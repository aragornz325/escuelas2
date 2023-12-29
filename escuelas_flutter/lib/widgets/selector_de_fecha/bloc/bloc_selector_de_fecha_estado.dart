part of 'bloc_selector_de_fecha.dart';

/// {@template BlocSelectorDeFechaEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocSelectorDeFechaEstado {
  /// {@macro BlocSelectorDeFechaEstado}
  const BlocSelectorDeFechaEstado._({required this.fecha});

  BlocSelectorDeFechaEstado.desde(
    BlocSelectorDeFechaEstado otro, {
    DateTime? fecha,
  }) : this._(
          fecha: fecha ?? otro.fecha,
        );

  /// Fecha utilizada
  final DateTime fecha;

  DateTime get fechaEnElMesAnterior => fecha.copyWith(month: fecha.month - 1);

  DateTime get fechaEnElMesPosterior => fecha.copyWith(month: fecha.month + 1);
}

/// {@template BlocSelectorDeFechaEstadoInicial}
/// Estado inicial de los componentes de la pantalla 'Selector de fecha'
/// {@endtemplate}
class BlocSelectorDeFechaEstadoInicial extends BlocSelectorDeFechaEstado {
  /// {@macro BlocSelectorDeFechaEstadoInicial}
  BlocSelectorDeFechaEstadoInicial() : super._(fecha: DateTime.now());
}

/// {@template BlocSelectorDeFechaEstadoCargando}
/// Estado de cargando de los componentes de la pantalla 'Selector de fecha'
/// {@endtemplate}
class BlocSelectorDeFechaEstadoCargando extends BlocSelectorDeFechaEstado {
  /// {@macro BlocSelectorDeFechaEstadoCargando}
  BlocSelectorDeFechaEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocSelectorDeFechaEstadoExitoso}
/// Estado exitoso general de los componentes de la pantalla 'Selector de fecha'
/// {@endtemplate}
class BlocSelectorDeFechaEstadoExitoso extends BlocSelectorDeFechaEstado {
  /// {@macro BlocSelectorDeFechaEstadoExitoso}
  BlocSelectorDeFechaEstadoExitoso.desde(
    super.otro, {
    super.fecha,
  }) : super.desde();
}

/// {@template BlocSelectorDeFechaEstadoFallido}
/// Estado de error de los componentes de la pantalla 'Selector de fecha'
/// {@endtemplate}
class BlocSelectorDeFechaEstadoError extends BlocSelectorDeFechaEstado {
  /// {@macro BlocSelectorDeFechaEstadoError}
  BlocSelectorDeFechaEstadoError.desde(super.otro) : super.desde();
}
