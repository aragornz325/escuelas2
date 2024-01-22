part of 'bloc_dashboard.dart';

/// {@template BlocDashboardEvento}
/// Clase padre de los eventos de [BlocDashboard].
/// {@endtemplate}
abstract class BlocDashboardEvento {
  /// {@macro BlocDashboardEvento}
  const BlocDashboardEvento();
}

/// {@template BlocDashboardEventoInicializar}
/// Al inicializarse bloc dashboard se dispara este evento que va a refrescar
/// los datos del usuario en el caso de que haya cambiado algo.
/// {@endtemplate}
class BlocDashboardEventoInicializar extends BlocDashboardEvento {
  /// {@macro BlocDashboardEventoInicializar}
  const BlocDashboardEventoInicializar();
}
