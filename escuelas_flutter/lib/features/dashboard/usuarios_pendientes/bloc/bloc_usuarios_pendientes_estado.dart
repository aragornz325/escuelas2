part of 'bloc_usuarios_pendientes.dart';

/// {@template BlocUsuariosPendientesEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocUsuariosPendientesEstado {
  /// {@macro BlocUsuariosPendientesEstado}
  const BlocUsuariosPendientesEstado._({
    this.listaUsuariosPendientes = const [],
    this.listaRoles = const [],
  });

  BlocUsuariosPendientesEstado.desde(
    BlocUsuariosPendientesEstado otro, {
    List<UsuarioPendiente>? listaUsuariosPendientes,
    List<Role>? listaRoles,
  }) : this._(
          listaUsuariosPendientes:
              listaUsuariosPendientes ?? otro.listaUsuariosPendientes,
          listaRoles: listaRoles ?? otro.listaRoles,
        );

  /// Lista de usuarios pendientes a ser asignados un rol
  final List<UsuarioPendiente> listaUsuariosPendientes;

  /// Lista de roles de la institucion
  final List<Role> listaRoles;

  /// Indica si se encuentra cargando
  bool get estaCargando => this is BlocUsuariosPendientesEstadoCargando;
}

/// {@template BlocUsuariosPendientesEstadoInicial}
/// Estado inicial de los componentes de la pantalla 'Usuarios Pendientes'
/// {@endtemplate}
class BlocUsuariosPendientesEstadoInicial extends BlocUsuariosPendientesEstado {
  /// {@macro BlocUsuariosPendientesEstadoInicial}
  const BlocUsuariosPendientesEstadoInicial() : super._();
}

/// {@template BlocUsuariosPendientesEstadoCargando}
/// Estado de cargando de los componentes de la pantalla 'Usuarios Pendientes'
/// {@endtemplate}
class BlocUsuariosPendientesEstadoCargando
    extends BlocUsuariosPendientesEstado {
  /// {@macro BlocUsuariosPendientesEstadoCargando}
  BlocUsuariosPendientesEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocUsuariosPendientesEstadoExitoso}
/// Estado exitoso general de los componentes de la pantalla
/// 'Usuarios Pendientes'
/// {@endtemplate}
class BlocUsuariosPendientesEstadoExitoso extends BlocUsuariosPendientesEstado {
  /// {@macro BlocUsuariosPendientesEstadoExitoso}
  BlocUsuariosPendientesEstadoExitoso.desde(
    super.otro, {
    super.listaUsuariosPendientes,
    super.listaRoles,
  }) : super.desde();
}

/// {@template BlocUsuariosPendientesEstadoError}
/// Estado de error de los componentes de la pantalla 'Usuarios Pendientes'
/// {@endtemplate}
class BlocUsuariosPendientesEstadoError extends BlocUsuariosPendientesEstado {
  /// {@macro BlocUsuariosPendientesEstadoError}
  BlocUsuariosPendientesEstadoError.desde(super.otro) : super.desde();
}
