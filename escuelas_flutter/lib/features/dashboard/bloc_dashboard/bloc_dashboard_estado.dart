part of 'bloc_dashboard.dart';

/// {@template BlocDashboardEstado}
/// Maneja los estados de procesos que se
/// ejecutan a lo largo del dashboard indiferentemente
/// de en que sub-página del dashboard se encuentre
/// el usuario.
/// {@endtemplate}
class BlocDashboardEstado {
  /// {@macro BlocDashboardEstado}
  const BlocDashboardEstado._({
    required this.usuario,
    required this.infoUsuario,
  });

  BlocDashboardEstado.desde(
    BlocDashboardEstado otro, {
    UserInfo? infoUsuario,
    Usuario? usuario,
  }) : this._(
          infoUsuario: infoUsuario ?? otro.infoUsuario,
          usuario: usuario ?? otro.usuario,
        );

  /// Modelo de usuario de la base de datos que contiene info de los roles y
  /// demas datos importantes del usuario.
  final Usuario usuario;

  /// Modelo de usuario logueado por google que contiene info del cliente.
  final UserInfo infoUsuario;
}

/// {@template BlocDashboardEstadoInicial}
/// Estado inicial de [BlocDashboardEstado].
/// {@endtemplate}
class BlocDashboardEstadoInicial extends BlocDashboardEstado {
  /// {@macro BlocDashboardEstadoInicial}
  const BlocDashboardEstadoInicial({
    required super.infoUsuario,
    required super.usuario,
  }) : super._();
}

/// {@template BlocDashboardEstadoCargando}
/// Estado de espera/carga de [BlocDashboardEstado].
/// {@endtemplate}
class BlocDashboardEstadoCargando extends BlocDashboardEstado {
  /// {@macro BlocDashboardEstadoCargando}
  BlocDashboardEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocDashboardEstadoExitoso}
/// Estado de éxito de [BlocDashboardEstado].
/// se puede dar desde distintas páginas del dashboard.
/// {@endtemplate}
class BlocDashboardEstadoExitoso extends BlocDashboardEstado {
  /// {@macro BlocDashboardEstadoExitoso}
  BlocDashboardEstadoExitoso.desde(
    super.otro, {
    required super.usuario,
  }) : super.desde();
}

/// {@template BlocDashboardEstadoFallido}
/// Estado de fallo de [BlocDashboardEstado].
/// {@endtemplate}
class BlocDashboardEstadoFallido extends BlocDashboardEstado {
  /// {@macro BlocDashboardEstadoFallido}
  BlocDashboardEstadoFallido.desde(super.otro) : super.desde();
}

/// {@template BlocDashboardEstadoLogueoFallido}
/// Este estado ocurre cuando la verificacion del logueo falla
/// {@endtemplate}
class BlocDashboardEstadoLogueoFallido extends BlocDashboardEstado {
  /// {@macro BlocDashboardEstadoLogueoFallido}
  BlocDashboardEstadoLogueoFallido.desde(super.otro) : super.desde();
}
