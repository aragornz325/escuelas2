part of 'bloc_login.dart';

/// {@template BlocLoginEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocLoginEstado {
  /// {@macro BlocLoginEstado}
  const BlocLoginEstado._();

  BlocLoginEstado.desde(BlocLoginEstado otro) : this._();
}

/// {@template BlocLoginEstadoInicial}
/// Estado inicial de los componentes de la pantalla 'Login'
/// {@endtemplate}
class BlocLoginEstadoInicial extends BlocLoginEstado {
  /// {@macro BlocLoginEstadoInicial}
  const BlocLoginEstadoInicial() : super._();
}

/// {@template BlocLoginEstadoCargando}
/// Estado de cargando de los componentes de la pantalla 'Login'
/// {@endtemplate}
class BlocLoginEstadoCargando extends BlocLoginEstado {
  /// {@macro BlocLoginEstadoCargando}
  BlocLoginEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocLoginEstadoExitoso}
/// Estado exitoso general de los componentes de la pantalla 'Login'
/// {@endtemplate}
class BlocLoginEstadoExitoso extends BlocLoginEstado {
  /// {@macro BlocLoginEstadoExitoso}
  BlocLoginEstadoExitoso.desde(super.otro) : super.desde();
}

/// {@template BlocLoginEstadoError}
/// Estado de error de los componentes de la pantalla 'Login'
/// {@endtemplate}
class BlocLoginEstadoError extends BlocLoginEstado {
  /// {@macro BlocLoginEstadoError}
  BlocLoginEstadoError.desde(
    super.otro, {
    required this.mensajeDeError,
  }) : super.desde();

  /// Mensaje de error que se muestra al usuario
  final String mensajeDeError;
}
