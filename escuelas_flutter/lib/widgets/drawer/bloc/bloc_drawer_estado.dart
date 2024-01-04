part of 'bloc_drawer.dart';

/// {@template BlocDrawerEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocDrawerEstado {
  /// {@macro BlocDrawerEstado}
  const BlocDrawerEstado._();

  BlocDrawerEstado.desde(
    // ignore: avoid_unused_constructor_parameters
    BlocDrawerEstado otro,
  ) : this._();
}

/// {@template BlocDrawerEstadoInicial}
/// Estado inicial de los componentes de la pantalla [BlocDrawer]
/// {@endtemplate}
class BlocDrawerEstadoInicial extends BlocDrawerEstado {
  /// {@macro BlocDrawerEstadoInicial}
  const BlocDrawerEstadoInicial() : super._();
}

/// {@template BlocDrawerEstadoCargando}
/// Estado de cargando de los componentes de la pantalla [BlocDrawer]
/// {@endtemplate}
class BlocDrawerEstadoCargando extends BlocDrawerEstado {
  /// {@macro BlocDrawerEstadoCargando}
  BlocDrawerEstadoCargando.desde(
    super.otro,
  ) : super.desde();
}

/// {@template BlocDrawerEstadoCerrarSesionExitoso}
/// Estado exitoso de cierre de sesion del usuario.
/// {@endtemplate}
class BlocDrawerEstadoCerrarSesionExitoso extends BlocDrawerEstado {
  /// {@macro BlocDrawerEstadoCerrarSesionExitoso}
  BlocDrawerEstadoCerrarSesionExitoso.desde(
    super.otro,
  ) : super.desde();
}

/// {@template BlocDrawerEstadoCambioDePagina}
/// Estado que indica el cambio de página dentro del dashboard.
/// {@endtemplate}
class BlocDrawerEstadoCambioDePagina extends BlocDrawerEstado {
  /// {@macro BlocDrawerEstadoCambioDePagina}
  BlocDrawerEstadoCambioDePagina.desde(
    super.otro,
  ) : super.desde();
}

/// {@template BlocDrawerEstadoError}
/// Estado de error de los componentes de la pantalla [BlocDrawer]
/// {@endtemplate}
class BlocDrawerEstadoError extends BlocDrawerEstado {
  /// {@macro BlocDrawerEstadoError}
  BlocDrawerEstadoError.desde(super.otro) : super.desde();
}
