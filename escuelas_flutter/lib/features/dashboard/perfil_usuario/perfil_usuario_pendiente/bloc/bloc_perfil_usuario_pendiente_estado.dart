part of 'bloc_perfil_usuario_pendiente.dart';

/// {@template BlocPerfilUsuarioPendienteEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocPerfilUsuarioPendienteEstado {
  /// {@macro BlocPerfilUsuarioPendienteEstado}
  const BlocPerfilUsuarioPendienteEstado._({
    this.usuarioPendiente,
    this.listaRoles = const [],
  });

  BlocPerfilUsuarioPendienteEstado.desde(
    BlocPerfilUsuarioPendienteEstado otro, {
    UsuarioPendiente? usuarioPendiente,
    List<Role>? listaRoles,
  }) : this._(
          usuarioPendiente: usuarioPendiente ?? otro.usuarioPendiente,
          listaRoles: listaRoles ?? otro.listaRoles,
        );

  /// Informacion del usuario pendiente
  final UsuarioPendiente? usuarioPendiente;

  /// Lista de roles de la institucion
  final List<Role> listaRoles;

  /// Lista de [AsignaturaSolicitada] del usuario pendiente o una lista vacia
  /// si no tiene asignaturas solicitadas
  List<AsignaturaSolicitada> get listaAsignaturasSolicitadasUsuarioPendiente =>
      usuarioPendiente?.asignaturasSolicitadas ?? [];

  /// Devuelve un [String] del nombre de la comision del [UsuarioPendiente]
  String get nombreComisionSolicitada =>
      usuarioPendiente?.comisionSolicitada?.nombre ?? '';

  /// Devuelve un [String] con en dni del usuario
  String? get dniUsuario => usuarioPendiente?.dni;

  /// Devuelve una un [String] con los nombres de los roles del usuario o un
  /// [String] vacio si no tiene roles
  String get nombreRolUsuarioPendiente =>
      listaRoles
          .firstWhereOrNull(
            (element) => element.id == usuarioPendiente?.idRolSolicitado,
          )
          ?.name ??
      '';

  /// Devuelve el [Tipo] de usuario segun su estado/rol
  Tipo get tipoUsuario => nombreRolUsuarioPendiente == 'estudiante'
      ? Tipo.alumnoPendiente
      : Tipo.docentePendiente;
}

/// {@template BlocPerfilUsuarioPendienteInicial}
/// Estado inicial de los componentes de la pantalla de perfil usuario pendiente
/// {@endtemplate}
class BlocPerfilUsuarioPendienteEstadoInicial
    extends BlocPerfilUsuarioPendienteEstado {
  /// {@macro BlocPerfilUsuarioPendienteEstadoInicial}
  const BlocPerfilUsuarioPendienteEstadoInicial() : super._();
}

/// {@template BlocPerfilUsuarioPendienteEstadoCargando}
/// Estado cargando de los componentes de la pantalla
/// de perfil usuario pendiente
/// {@endtemplate}
class BlocPerfilUsuarioPendienteEstadoCargando
    extends BlocPerfilUsuarioPendienteEstado {
  /// {@macro BlocPerfilUsuarioPendienteEstadoCargando}
  BlocPerfilUsuarioPendienteEstadoCargando.desde(super.otro) : super.desde();
}

class BlocPerfilUsuarioPendienteEstadoExitoso
    extends BlocPerfilUsuarioPendienteEstado {
  BlocPerfilUsuarioPendienteEstadoExitoso.desde(super.otro) : super.desde();
}

/// {@template BlocPerfilUsuarioPendienteEstadoExitosoAltraerUsuario}
/// Estado exitoso al traer los datos del usuario pendiente
/// {@endtemplate}
class BlocPerfilUsuarioPendienteEstadoExitosoAlTraerUsuario
    extends BlocPerfilUsuarioPendienteEstado {
  /// {@macro BlocPerfilUsuarioPendienteEstadoExitosoAlTraerUsuario}
  BlocPerfilUsuarioPendienteEstadoExitosoAlTraerUsuario.desde(
    super.otro, {
    super.usuarioPendiente,
    super.listaRoles,
  }) : super.desde();
}

/// {@template BlocPerfilUsuarioPendienteAceptado}
/// Estado para darle un delay a la llamada de los endpoints de la pagina
/// de lista de usuarios pendientes
/// {@endtemplate}
class BlocPerfilUsuarioPendienteEstadoUsuarioAceptado
    extends BlocPerfilUsuarioPendienteEstado {
  /// {@macro BlocPerfilUsuarioPendienteEstadoUsuarioAceptado}
  BlocPerfilUsuarioPendienteEstadoUsuarioAceptado.desde(super.otro)
      : super.desde();
}

/// {@template BlocPerfilUsuarioPendienteEstadoFallido}
/// Estado de error de los componentes de la pantalla 'Perfil de usuario'
/// {@endtemplate}
class BlocPerfilUsuarioPendienteEstadoError
    extends BlocPerfilUsuarioPendienteEstado {
  /// {@macro BlocPerfilUsuarioPendienteEstadoError}
  BlocPerfilUsuarioPendienteEstadoError.desde(super.otro) : super.desde();
}
