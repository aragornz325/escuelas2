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

/// {@template BlocDashboardEventoObtenerAsignaturaYComision}
/// Evento para obtener una asignatura y mostrarlo en el appbar.
/// {@endtemplate}
class BlocDashboardEventoObtenerAsignaturaYComision
    extends BlocDashboardEvento {
  /// {@macro BlocDashboardEventoObtenerAsignaturaYComision}
  const BlocDashboardEventoObtenerAsignaturaYComision({
    required this.idAsignatura,
    required this.idComision,
  });

  /// id de la asignatura.
  final int idAsignatura;

  /// id de la comision.
  final int idComision;
}

/// {@template BlocDashboardEventoCambiarContrasenia}
/// Evento para cambiar la contraseña del usuario.
/// {@endtemplate}
class BlocDashboardEventoCambiarContrasenia extends BlocDashboardEvento {
  /// {@macro BlocDashboardEventoCambiarContrasenia}
  BlocDashboardEventoCambiarContrasenia(this.nuevaContrasenia);

  /// Nueva contraseña
  final String nuevaContrasenia;
}
