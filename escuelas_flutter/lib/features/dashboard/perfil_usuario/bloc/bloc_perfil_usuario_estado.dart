part of 'bloc_perfil_usuario.dart';

/// {@template BlocPerfilUsuarioEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocPerfilUsuarioEstado {
  /// {@macro BlocPerfilUsuarioEstado}
  const BlocPerfilUsuarioEstado._({
    this.usuario,
    this.usuarioPendiente,
    this.listaRoles = const [],
  });

  BlocPerfilUsuarioEstado.desde(
    BlocPerfilUsuarioEstado otro, {
    Usuario? usuario,
    UsuarioPendiente? usuarioPendiente,
    List<RolDeUsuario>? listaRoles,
  }) : this._(
          usuario: usuario ?? otro.usuario,
          usuarioPendiente: usuarioPendiente ?? otro.usuarioPendiente,
          listaRoles: listaRoles ?? otro.listaRoles,
        );

  /// Informacion del usuario
  final Usuario? usuario;

  /// Informacion del usuario pendiente
  final UsuarioPendiente? usuarioPendiente;

  /// Lista de roles de la institucion
  final List<RolDeUsuario> listaRoles;

  /// Nombre del rol del usuario
  String get nombreRol =>
      listaRoles
          .firstWhereOrNull((rol) => rol.id == usuarioPendiente?.rolSolicitado)
          ?.nombre ??
      '';
}

/// {@template BlocPerfilUsuarioEstadoInicial}
/// Estado inicial de los componentes de la pantalla 'Perfil de usuario'
/// {@endtemplate}
class BlocPerfilUsuarioEstadoInicial extends BlocPerfilUsuarioEstado {
  /// {@macro BlocPerfilUsuarioEstadoInicial}
  const BlocPerfilUsuarioEstadoInicial() : super._();
}

/// {@template BlocPerfilUsuarioEstadoCargando}
/// Estado de cargando de los componentes de la pantalla 'Perfil de usuario'
/// {@endtemplate}
class BlocPerfilUsuarioEstadoCargando extends BlocPerfilUsuarioEstado {
  /// {@macro BlocPerfilUsuarioEstadoCargando}
  BlocPerfilUsuarioEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocPerfilUsuarioEstadoExitoso}
/// Estado exitoso de los componentes de la pantalla 'Perfil de usuario'
/// {@endtemplate}
class BlocPerfilUsuarioEstadoExitoso extends BlocPerfilUsuarioEstado {
  /// {@macro BlocPerfilUsuarioEstadoExitoso}
  BlocPerfilUsuarioEstadoExitoso.desde(super.otro) : super.desde();
}

/// {@template BlocPerfilUsuarioEstadoExitosoAltraerUsuario}
/// Estado exitoso al traer los datos del usuario
/// {@endtemplate}
class BlocPerfilUsuarioEstadoExitosoAltraerUsuario
    extends BlocPerfilUsuarioEstado {
  /// {@macro BlocPerfilUsuarioEstadoExitosoAltraerUsuario}
  BlocPerfilUsuarioEstadoExitosoAltraerUsuario.desde(
    super.otro, {
    super.usuario,
    super.listaRoles,
  }) : super.desde();
}

/// {@template BlocPerfilUsuarioEstadoExitosoAltraerUsuarioPendiente}
/// Estado exitoso al traer los datos del usuario pendiente
/// {@endtemplate}
class BlocPerfilUsuarioEstadoExitosoAltraerUsuarioPendiente
    extends BlocPerfilUsuarioEstado {
  /// {@macro BlocPerfilUsuarioEstadoExitoso}
  BlocPerfilUsuarioEstadoExitosoAltraerUsuarioPendiente.desde(
    super.otro, {
    super.usuarioPendiente,
    super.listaRoles,
  }) : super.desde();
}

/// {@template BlocPerfilUsuarioEstadoFallido}
/// Estado de error de los componentes de la pantalla 'Perfil de usuario'
/// {@endtemplate}
class BlocPerfilUsuarioEstadoError extends BlocPerfilUsuarioEstado {
  /// {@macro BlocPerfilUsuarioEstadoError}
  BlocPerfilUsuarioEstadoError.desde(super.otro) : super.desde();
}
