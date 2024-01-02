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
    required this.infoUsuario,
  });

  BlocDashboardEstado.desde(
    BlocDashboardEstado otro, {
    InfoUsuario? infoUsuario,
  }) : this._(
          infoUsuario: infoUsuario ?? otro.infoUsuario,
        );

  final InfoUsuario infoUsuario;
}

/// {@template BlocDashboardEstadoInicial}
/// Estado inicial de [BlocDashboardEstado].
/// {@endtemplate}
class BlocDashboardEstadoInicial extends BlocDashboardEstado {
  /// {@macro BlocDashboardEstadoInicial}
  const BlocDashboardEstadoInicial(
    InfoUsuario infoUsuario,
  ) : super._(
          infoUsuario: infoUsuario,
        );
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
    super.otro,
  ) : super.desde();
}

/// {@template BlocDashboardEstadoFallido}
/// Estado de fallo de [BlocDashboardEstado].
/// {@endtemplate}
class BlocDashboardEstadoFallido extends BlocDashboardEstado {
  /// {@macro BlocDashboardEstadoFallido}
  BlocDashboardEstadoFallido.desde(super.otro) : super.desde();
}

/// {@template BlocDashboardEstadoLogueoExitoso}
/// Este estado ocurre cuando la verificacion del logueo es exitosa
/// {@endtemplate}
class BlocDashboardEstadoLogueoExitoso extends BlocDashboardEstado {
  /// {@macro BlocDashboardEstadoLogueoExitoso}
  BlocDashboardEstadoLogueoExitoso.desde(
    super.otro, {
    super.infoUsuario,
  }) : super.desde();
}

/// {@template BlocDashboardEstadoLogueoFallido}
/// Este estado ocurre cuando la verificacion del logueo falla
/// {@endtemplate}
class BlocDashboardEstadoLogueoFallido extends BlocDashboardEstado {
  /// {@macro BlocDashboardEstadoLogueoFallido}
  BlocDashboardEstadoLogueoFallido.desde(super.otro) : super.desde();
}

/// {@template BlocDashboardEstadoFaltaCompletarKyc}
/// Este estado ocurre cuando se ingresa en el dashboard,
/// se averigua si en la db el usuario actual ya completo el
/// kcy, en caso de no ser así se emite este estado.
///
/// Si este estado es emitido, se redirige al usuario a completar
/// el kyc.
/// {@endtemplate}
class BlocDashboardEstadoFaltaCompletarKyc extends BlocDashboardEstado {
  /// {@macro BlocDashboardEstadoFaltaCompletarKyc}
  BlocDashboardEstadoFaltaCompletarKyc.desde(super.otro) : super.desde();
}
