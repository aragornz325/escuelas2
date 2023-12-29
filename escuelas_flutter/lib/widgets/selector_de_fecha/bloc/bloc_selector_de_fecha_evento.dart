part of 'bloc_selector_de_fecha.dart';

/// {@template BlocSelectorDeFechaEvento}
/// Clase padre de los eventos de [BlocSelectorDeFecha].
/// {@endtemplate}
abstract class BlocSelectorDeFechaEvento {
  /// {@macro BlocSelectorDeFechaEvento}
  const BlocSelectorDeFechaEvento();
}

/// {@template BlocSelectorDeFechaEventoRetroceder}
/// Retrocede un mes en el selector de fecha
/// {@endtemplate}
class BlocSelectorDeFechaEventoRetroceder extends BlocSelectorDeFechaEvento {}

/// {@template BlocSelectorDeFechaEventoAvanzar}
/// Avanza un mes en el selector de fecha
/// {@endtemplate}
class BlocSelectorDeFechaEventoAvanzar extends BlocSelectorDeFechaEvento {}
