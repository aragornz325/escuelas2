part of 'bloc_inicio.dart';

/// {@template BlocInicioEstado}
/// Maneja los estados de procesos que se ejecutan a lo largo del Inicio
/// {@endtemplate}
class BlocInicioEstado {
  /// {@macro BlocInicioEstado}
  const BlocInicioEstado._({
    this.usuario,
    this.hayUsuariosPendientes = false,
    this.cantidadNotificacionesPendientes = 0,
  });

  BlocInicioEstado.desde(
    BlocInicioEstado otro, {
    bool? hayUsuariosPendientes,
    int? cantidadNotificacionesPendientes,
  }) : this._(
          hayUsuariosPendientes:
              hayUsuariosPendientes ?? otro.hayUsuariosPendientes,
          cantidadNotificacionesPendientes: cantidadNotificacionesPendientes ??
              otro.cantidadNotificacionesPendientes,
        );

  /// Indica si hay usuarios pendientes para señalizar al usuario con un circulo
  /// rojo.
  final bool hayUsuariosPendientes;

  /// Cantidad de solicitudes de notificaciones pendientes para poder
  /// señalizarle al usuario la cantidad de las mismas en el menu inicio.
  final int cantidadNotificacionesPendientes;

  final Usuario? usuario;
}

/// {@template BlocInicioEstadoInicial}
/// Estado inicial de [BlocInicioEstado].
/// {@endtemplate}
class BlocInicioEstadoInicial extends BlocInicioEstado {
  /// {@macro BlocInicioEstadoInicial}
  const BlocInicioEstadoInicial(this.usuario) : super._();

  final Usuario usuario;
}

/// {@template BlocInicioEstadoCargando}
/// Estado de espera/carga de [BlocInicioEstado].
/// {@endtemplate}
class BlocInicioEstadoCargando extends BlocInicioEstado {
  /// {@macro BlocInicioEstadoCargando}
  BlocInicioEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocInicioEstadoExitoso}
/// Estado de éxito de [BlocInicioEstado].
/// {@endtemplate}
class BlocInicioEstadoExitoso extends BlocInicioEstado {
  /// {@macro BlocInicioEstadoExitoso}
  BlocInicioEstadoExitoso.desde(
    super.otro, {
    super.hayUsuariosPendientes,
    super.cantidadNotificacionesPendientes,
  }) : super.desde();
}

/// {@template BlocInicioEstadoFallido}
/// Estado de fallo de [BlocInicioEstado].
/// {@endtemplate}
class BlocInicioEstadoFallido extends BlocInicioEstado {
  /// {@macro BlocInicioEstadoFallido}
  BlocInicioEstadoFallido.desde(super.otro) : super.desde();
}
