part of 'bloc_perfil_usuario.dart';

//! TODO(Anyone): Quitar UsuarioPendiente y arreglar lo que se rompe

/// {@template BlocPerfilUsuarioEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocPerfilUsuarioEstado {
  /// {@macro BlocPerfilUsuarioEstado}
  const BlocPerfilUsuarioEstado._({
    this.listaComisiones = const [],
    this.listaAsignaturas = const [],
    this.usuario,
    this.usuarioPendiente,
    this.listaRoles = const [],
    this.telefono = '',
    this.mail = '',
    this.factorSanguineo = '',
    this.edad = '',
    this.contactoEmergenciaNombre = '',
    this.contactoEmergenciaVinculo = '',
    this.contactoEmergenciaTelefono = '',
    this.contactoEmergenciaMail = '',
    this.opcionesFormulario = const [],
    this.observaciones = '',
  });

  BlocPerfilUsuarioEstado.desde(
    BlocPerfilUsuarioEstado otro, {
    Usuario? usuario,
    UsuarioPendiente? usuarioPendiente,
    List<Role>? listaRoles,
    String? telefono,
    String? mail,
    String? factorSanguineo,
    String? edad,
    String? contactoEmergenciaNombre,
    String? contactoEmergenciaVinculo,
    String? contactoEmergenciaTelefono,
    String? contactoEmergenciaMail,
    String? observaciones,
    List<OpcionFormulario>? opcionesFormulario,
    List<ComisionDeCurso>? listaComisiones,
    List<Asignatura>? listaAsignaturas,
  }) : this._(
          opcionesFormulario: opcionesFormulario ?? otro.opcionesFormulario,
          listaAsignaturas: listaAsignaturas ?? otro.listaAsignaturas,
          listaComisiones: listaComisiones ?? otro.listaComisiones,
          usuario: usuario ?? otro.usuario,
          usuarioPendiente: usuarioPendiente ?? otro.usuarioPendiente,
          listaRoles: listaRoles ?? otro.listaRoles,
          telefono: telefono ?? otro.telefono,
          mail: mail ?? otro.mail,
          factorSanguineo: factorSanguineo ?? otro.factorSanguineo,
          edad: edad ?? otro.edad,
          contactoEmergenciaNombre:
              contactoEmergenciaNombre ?? otro.contactoEmergenciaNombre,
          contactoEmergenciaVinculo:
              contactoEmergenciaVinculo ?? otro.contactoEmergenciaVinculo,
          contactoEmergenciaTelefono:
              contactoEmergenciaTelefono ?? otro.contactoEmergenciaTelefono,
          contactoEmergenciaMail:
              contactoEmergenciaMail ?? otro.contactoEmergenciaMail,
          observaciones: observaciones ?? otro.observaciones,
        );

  /// Informacion del usuario
  final Usuario? usuario;

  /// Telefono del usuario
  final String? telefono;

  /// Mail del usuario
  final String? mail;

  /// Grupo sanguineo del usuario
  final String? factorSanguineo;

  /// Edad del usuario
  final String? edad;

  /// Nombre del contacto de emergencia
  final String? contactoEmergenciaNombre;

  /// Vinculo del contacto de emergencia
  final String? contactoEmergenciaVinculo;

  /// Telefono del contacto de emergencia
  final String? contactoEmergenciaTelefono;

  /// Mail del contacto de emergencia
  final String? contactoEmergenciaMail;

  /// Observaciones del usuario
  final String? observaciones;

  /// Lista de cursos de la escuela a la que pertenece el usuario
  final List<ComisionDeCurso> listaComisiones;

  /// Lista de materias de la escuela a la que pertenece el usuario
  final List<Asignatura> listaAsignaturas;

  /// Informacion del usuario pendiente
  final UsuarioPendiente? usuarioPendiente;

  /// Lista de roles de la institucion
  final List<Role> listaRoles;

  /// Lista de opciones de kyc (inicialmente hay una)
  final List<OpcionFormulario> opcionesFormulario;

  List<EscuelasDropdownOption<int>> get opcionesComisiones => listaComisiones
      .map(
        (comision) => EscuelasDropdownOption(
          value: comision.id ?? 0,
          title: comision.nombre,
        ),
      )
      .toList();

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
  List<RelacionComisionUsuario> get listaComisionesDelUsuario =>
      usuario?.comisiones ?? [];

  /// Devuelve un [String] de los nombres de las comisiones del usuario
  String get nombreComisiones =>
      listaComisionesDelUsuario.map((e) => e.comision?.nombre).join(', ');

  /// Devuelve un [String] del nombre de la comision del [UsuarioPendiente]
  String get nombreComisionSolicitada =>
      usuarioPendiente?.comisionSolicitada?.nombre ?? '';

  /// Devuelve una lista de [NumeroDeTelefono] del usuario o una lista vacia
  /// si no tiene
  List<NumeroDeTelefono> get numerosDeTelefono =>
      usuario?.numerosDeTelefono ?? [];

  /// Devuelve una lista de direcciones de [DireccionDeEmail] del usuario o una
  /// lista vacia si no tiene
  List<DireccionDeEmail> get direccionesDeEmail =>
      usuario?.direccionesDeEmail ?? [];

  /// Devuelve una lista de [Role] del usuario o una lista vacia
  /// si no tiene
  List<String> get nombreRolesDeUsuario => usuario?.roles?.keys.toList() ?? [];

  /// Devuelve un [String] con en dni del usuario
  String? get dniUsuario => usuario?.dni ?? usuarioPendiente?.dni;

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
      ? nombreRolesDeUsuario.any((usuarioConRol) => usuarioConRol == 'alumno')
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
  BlocPerfilUsuarioEstadoExitoso.desde(
    super.otro, {
    super.opcionesFormulario,
  }) : super.desde();
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

/// {@template BlocPerfilUsuarioEstadoExitosoAlEliminarUsuario}
/// Estado exitoso al eliminar usuario
/// {@endtemplate}
class BlocPerfilUsuarioEstadoExitosoAlEliminarUsuario
    extends BlocPerfilUsuarioEstado {
  /// {@macro BlocPerfilUsuarioEstadoExitosoAlEliminarUsuario}
  BlocPerfilUsuarioEstadoExitosoAlEliminarUsuario.desde(super.otro)
      : super.desde();
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

/// {@template BlocPerfilUsuarioEstadoExitosoALTraerAsignaturas}
/// Estado exitoso al traer las asignaturas
/// {@endtemplate}
class BlocPerfilUsuarioEstadoExitosoALTraerAsignaturas
    extends BlocPerfilUsuarioEstado {
  /// {@macro BlocPerfilUsuarioEstadoExitosoALTraerAsignaturas}
  BlocPerfilUsuarioEstadoExitosoALTraerAsignaturas.desde(
    super.otro, {
    super.listaAsignaturas,
    super.listaComisiones,
  }) : super.desde();
}

/// {@template BlocPerfilUsuarioEstadoFallido}
/// Estado de error de los componentes de la pantalla 'Perfil de usuario'
/// {@endtemplate}
class BlocPerfilUsuarioEstadoError extends BlocPerfilUsuarioEstado {
  /// {@macro BlocPerfilUsuarioEstadoError}
  BlocPerfilUsuarioEstadoError.desde(super.otro) : super.desde();
}

/// {@template BlocPerfilUsuarioEstadoRecolectandoDatosKyC}
/// Estado de recoleccion de datos del KYC
/// {@endtemplate}
class BlocPerfilUsuarioEstadoRecolectandoDatosKyC
    extends BlocPerfilUsuarioEstado {
  /// {@macro BlocPerfilUsuarioEstadoRecolectandoDatosKyC}
  BlocPerfilUsuarioEstadoRecolectandoDatosKyC.desde(
    super.otro, {
    super.telefono,
    super.mail,
    super.factorSanguineo,
    super.edad,
    super.contactoEmergenciaNombre,
    super.contactoEmergenciaVinculo,
    super.contactoEmergenciaTelefono,
    super.contactoEmergenciaMail,
    super.observaciones,
  }) : super.desde();
}
