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
    List<Role>? listaRoles,
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
  final List<Role> listaRoles;

  /// Lista de [AsignaturaSolicitada] del usuario pendiente o una lista vacia
  /// si no tiene asignaturas solicitadas
  List<AsignaturaSolicitada> get listaAsignaturasSolicitadasUsuarioPendiente =>
      usuarioPendiente?.asignaturasSolicitadas ?? [];

  /// Lista de [Asignatura] del usuario o una lista vacia si no tiene
  /// asignaturas
  List<RelacionAsignaturaUsuario> get listaAsignaturasUsuario =>
      usuario?.asignaturas ?? [];

  /// Devuelve una lista de [RelacionComisionUsuario] del usuario o una lista
  /// vacia si no
  List<RelacionComisionUsuario> get listaComisiones =>
      usuario?.comisiones ?? [];

  /// Devuelve un [String] de los nombres de las comisiones del usuario
  String get nombreComisiones =>
      listaComisiones.map((e) => e.comision?.nombre).join(', ');

  /// Devuelve un [String] del nombre de la comision del [UsuarioPendiente]
  String get nombreComisionSolicitada =>
      usuarioPendiente?.comisionSolicitada?.comision?.nombre ?? '';

  /// Devuelve una lista de [NumeroDeTelefono] del usuario o una lista vacia
  /// si no tiene
  List<NumeroDeTelefono> get numerosDeTelefono =>
      usuario?.numerosDeTelefono ?? [];

  /// Devuelve una lista de direcciones de [DireccionDeEmail] del usuario o una
  /// lista vacia si no tiene
  List<DireccionDeEmail> get direccionesDeEmail =>
      usuario?.direccionesDeEmail ?? [];

  /// Devuelve una lista de [RelacionUsuarioRol] del usuario o una lista vacia
  /// si no tiene
  List<Role> get rolesDeUsuario => usuario?.roles ?? [];

  /// Devuelve un [String] con en dni del usuario
  // TODO(anyone): Cambiar por el dni del usuario pendiente cuando este
  String? get dniUsuario => usuario?.dni;

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
  Tipo get tipoUsuario => usuarioPendiente == null
      ? rolesDeUsuario.any((usuarioConRol) => usuarioConRol.name == 'alumno')
          ? Tipo.alumnoAprobado
          : Tipo.docenteAprobado
      : nombreRolUsuarioPendiente == 'alumno'
          ? Tipo.alumnoPendiente
          : Tipo.docentePendiente;
}

/// {@template BlocPerfilUsuarioEstadoInicial}
/// Estado inicial de los componentes de la pa ntalla 'Perfil de usuario'
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
