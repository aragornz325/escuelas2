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
    this.asignatura,
    this.comision,
  });

  BlocDashboardEstado.desde(
    BlocDashboardEstado otro, {
    Usuario? usuario,
    UserInfo? infoUsuario,
    Asignatura? asignatura,
    ComisionDeCurso? comision,
  }) : this._(
          usuario: usuario ?? otro.usuario,
          comision: comision ?? otro.comision,
          asignatura: asignatura ?? otro.asignatura,
          infoUsuario: infoUsuario ?? otro.infoUsuario,
        );

  /// Modelo de usuario de la base de datos que contiene info de los roles y
  /// demas datos importantes del usuario.
  final Usuario usuario;

  /// Modelo de usuario logueado por google que contiene info del cliente.
  final UserInfo infoUsuario;

  /// Asignatura para mostrar en el appbar.En caso de que sea nulo no se
  /// muestra el titulo de la ruta
  final Asignatura? asignatura;

  /// Asignatura para mostrar en el appbar.En caso de que sea nulo no se
  /// muestra el titulo de la ruta.
  final ComisionDeCurso? comision;
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
    super.asignatura,
    super.comision,
  }) : super.desde();
}

/// {@template BlocDashboardEstadoFallido}
/// Estado de fallo de [BlocDashboardEstado].
/// {@endtemplate}
class BlocDashboardEstadoFallido extends BlocDashboardEstado {
  /// {@macro BlocDashboardEstadoFallido}
  BlocDashboardEstadoFallido.desde(
    super.otro, {
    this.excepcion,
  }) : super.desde();

  /// excepcion que arroja el servidor.
  final ExcepcionCustom? excepcion;
}

/// {@template BlocDashboardEstadoLogueoFallido}
/// Este estado ocurre cuando la verificacion del logueo falla
/// {@endtemplate}
class BlocDashboardEstadoLogueoFallido extends BlocDashboardEstado {
  /// {@macro BlocDashboardEstadoLogueoFallido}
  BlocDashboardEstadoLogueoFallido.desde(super.otro) : super.desde();
}

/// {@template BlocDashboardEstadoExitosoAlCambiarLaContrasenia}
/// Estado de éxito de [BlocDashboardEstado] cuando se cambia la contraseña.
/// {@endtemplate}
class BlocDashboardEstadoExitosoAlCambiarLaContrasenia
    extends BlocDashboardEstado {
  /// {@macro BlocDashboardEstadoExitosoAlCambiarLaContrasenia}
  BlocDashboardEstadoExitosoAlCambiarLaContrasenia.desde(
    super.otro, {
    super.usuario,
  }) : super.desde();
}

/// {@template BlocDashboardEstadoExitosoAlCambiarElDNI}
/// Estado de éxito de [BlocDashboardEstado] cuando se cambia el DNI.
/// {@endtemplate}
class BlocDashboardEstadoExitosoAlCambiarElDNI extends BlocDashboardEstado {
  /// {@macro BlocDashboardEstadoExitosoAlCambiarElDNI}
  BlocDashboardEstadoExitosoAlCambiarElDNI.desde(
    super.otro, {
    super.usuario,
  }) : super.desde();
}
