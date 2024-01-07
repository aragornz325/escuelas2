part of 'bloc_asignacion_de_roles.dart';

/// {@template BlocAsignacionDeRolesEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocAsignacionDeRolesEstado {
  /// {@macro BlocAsignacionDeRolesEstado}
  const BlocAsignacionDeRolesEstado._({
    this.listaUsuariosPendientes = const [],
    this.listaRoles = const [],
  });

  BlocAsignacionDeRolesEstado.desde(
    BlocAsignacionDeRolesEstado otro, {
    List<UsuarioPendiente>? listaUsuariosPendientes,
    List<RolDeUsuario>? listaRoles,
  }) : this._(
          listaUsuariosPendientes:
              listaUsuariosPendientes ?? otro.listaUsuariosPendientes,
          listaRoles: listaRoles ?? otro.listaRoles,
        );

  /// Lista de usuarios pendientes a ser asignados un rol
  final List<UsuarioPendiente> listaUsuariosPendientes;

  /// Lista de roles de la institucion
  final List<RolDeUsuario> listaRoles;

  /// Indica si se encuentra cargando
  bool get estaCargando => this is BlocAsignacionDeRolesEstadoCargando;
}

/// {@template BlocAsignacionDeRolesEstadoInicial}
/// Estado inicial de los componentes de la pantalla 'Asignacion de Rol'
/// {@endtemplate}
class BlocAsignacionDeRolesEstadoInicial extends BlocAsignacionDeRolesEstado {
  /// {@macro BlocAsignacionDeRolesEstadoInicial}
  const BlocAsignacionDeRolesEstadoInicial() : super._();
}

/// {@template BlocAsignacionDeRolesEstadoCargando}
/// Estado de cargando de los componentes de la pantalla 'Asignacion de Rol'
/// {@endtemplate}
class BlocAsignacionDeRolesEstadoCargando extends BlocAsignacionDeRolesEstado {
  /// {@macro BlocAsignacionDeRolesEstadoCargando}
  BlocAsignacionDeRolesEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocAsignacionDeRolesEstadoExitoso}
/// Estado exitoso general de los componentes de la pantalla 'Asignacion de Rol'
/// {@endtemplate}
class BlocAsignacionDeRolesEstadoExitoso extends BlocAsignacionDeRolesEstado {
  /// {@macro BlocAsignacionDeRolesEstadoExitoso}
  BlocAsignacionDeRolesEstadoExitoso.desde(
    super.otro, {
    super.listaUsuariosPendientes,
    super.listaRoles,
  }) : super.desde();
}

/// {@template BlocAsignacionDeRolesEstadoError}
/// Estado de error de los componentes de la pantalla 'Asignacion de Rol'
/// {@endtemplate}
class BlocAsignacionDeRolesEstadoError extends BlocAsignacionDeRolesEstado {
  /// {@macro BlocAsignacionDeRolesEstadoError}
  BlocAsignacionDeRolesEstadoError.desde(super.otro) : super.desde();
}
