part of 'bloc_dashboard.dart';

/// {@template BlocDashboardEvento}
/// Clase padre de los eventos de [BlocDashboard].
/// {@endtemplate}
abstract class BlocDashboardEvento {
  /// {@macro BlocDashboardEvento}
  const BlocDashboardEvento();
}

/// {@template BlocDashboardEventoTraerInformacion}
/// Evento que verifica si el usuario esta logueado.
/// {@endtemplate}

class BlocDashboardEventoTraerInformacion extends BlocDashboardEvento {
  /// {@macro BlocDashboardEventoTraerInformacion}
  BlocDashboardEventoTraerInformacion();
}
