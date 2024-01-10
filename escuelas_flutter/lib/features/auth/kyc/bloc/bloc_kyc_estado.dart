part of 'bloc_kyc.dart';

/// {@template BlocKycEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocKycEstado {
  /// {@macro BlocKycEstado}
  const BlocKycEstado._({
    this.listaComisiones = const [],
    this.listaAsignaturas = const [],
    this.listaRoles = const [],
    this.opcionesFormulario = const [],
    this.rolElegido,
  });

  BlocKycEstado.desde(
    BlocKycEstado otro, {
    List<ComisionDeCurso>? listaComisiones,
    List<Asignatura>? listaAsignaturas,
    List<OpcionFormulario>? opcionesFormulario,
    List<RolDeUsuario>? listaRoles,
    RolDeUsuario? rolElegido,
    bool eliminarRolElegido = false,
  }) : this._(
          listaComisiones: listaComisiones ?? otro.listaComisiones,
          listaAsignaturas: listaAsignaturas ?? otro.listaAsignaturas,
          opcionesFormulario: opcionesFormulario ?? otro.opcionesFormulario,
          rolElegido: eliminarRolElegido ? null : rolElegido ?? otro.rolElegido,
          listaRoles: listaRoles ?? otro.listaRoles,
        );

  /// Factory constructor fromJson del [BlocKycEstado]
  factory BlocKycEstado.fromJson(
    Map<String, dynamic> json,
  ) {
    return BlocKycEstado._(
      listaComisiones: (json['listaComisiones'] as List<dynamic>?)
              ?.map(
                (e) => ComisionDeCurso.fromJson(
                  e as Map<String, dynamic>,
                  Protocol(),
                ),
              )
              .toList() ??
          [],
      listaAsignaturas: (json['listaAsignaturas'] as List<dynamic>?)
              ?.map(
                (e) => Asignatura.fromJson(
                  e as Map<String, dynamic>,
                  Protocol(),
                ),
              )
              .toList() ??
          [],
      rolElegido: json['rolElegido'] == null
          ? null
          : RolDeUsuario.fromJson(
              json['rolElegido'] as Map<String, dynamic>,
              Protocol(),
            ),
      listaRoles: (json['listaRoles'] as List<dynamic>?)
              ?.map(
                (e) => RolDeUsuario.fromJson(
                  e as Map<String, dynamic>,
                  Protocol(),
                ),
              )
              .toList() ??
          [],
    );
  }

  /// Lista de cursos de la escuela a la que pertenece el usuario
  final List<ComisionDeCurso> listaComisiones;

  /// Lista de materias de la escuela a la que pertenece el usuario
  final List<Asignatura> listaAsignaturas;

  /// Lista de opciones de kyc (inicialmente hay una)
  final List<OpcionFormulario> opcionesFormulario;

  /// Rol elegido por el usuario en la pantalla de seleccion de rol
  final RolDeUsuario? rolElegido;

  /// Lista de roles a mostrar en pantalla
  final List<RolDeUsuario> listaRoles;

  /// Indica si el state es cargando
  bool get estaEnEstadoCargando => this is BlocKycEstadoCargando;

  /// Retorna la lista de cursos de la escuela a la que pertenece el usuario en
  /// forma de [PopupOption]
  List<PopupOption> get listaOpcionesComisiones => listaComisiones
      .map(
        (curso) => PopupOption(
          id: curso.id ?? 0,
          name: curso.nombre,
        ),
      )
      .toList();

  /// Retorna la lista de materias de la escuela a la que pertenece el usuario
  /// en forma de [PopupOption]
  List<PopupOption> get listaOpcionesAsignaturas => listaAsignaturas
      .map(
        (asignatura) => PopupOption(
          id: asignatura.id ?? 0,
          name: asignatura.nombre,
        ),
      )
      .toList();

  /// Metodo toJson del [BlocKycEstado]
  Map<String, dynamic> toJson() {
    return {
      'listaComisiones': listaComisiones.map((e) => e.toJsonBloc()).toList(),
      'listaAsignaturas': listaAsignaturas.map((e) => e.toJsonBloc()).toList(),
      'rolElegido': rolElegido?.toJsonBloc(),
      'listaRoles': listaRoles.map((e) => e.toJsonBloc()).toList(),
    };
  }
}

/// {@template BlocKycEstadoInicial}
/// Estado inicial de los componentes de la pantalla 'Kyc'
/// {@endtemplate}
class BlocKycEstadoInicial extends BlocKycEstado {
  /// {@macro BlocKycEstadoInicial}
  const BlocKycEstadoInicial() : super._();
}

/// {@template BlocKycEstadoCargando}
/// Estado de cargando de los componentes de la pantalla 'Kyc'
/// {@endtemplate}
class BlocKycEstadoCargando extends BlocKycEstado {
  /// {@macro BlocKycEstadoCargando}
  BlocKycEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocKycEstadoExitoso}
/// Estado exitoso general de los componentes de la pantalla 'Kyc'
/// {@endtemplate}
class BlocKycEstadoExitoso extends BlocKycEstado {
  /// {@macro BlocKycEstadoExitoso}
  BlocKycEstadoExitoso.desde(
    super.otro, {
    super.listaComisiones,
    super.listaAsignaturas,
    super.opcionesFormulario,
    super.rolElegido,
    super.listaRoles,
    super.eliminarRolElegido,
  }) : super.desde();
}

/// {@template BlocKycEstadoExitoAlSolicitarRol}
/// Estado de exito al solicitar un rol en la pantalla 'Kyc'
/// {@endtemplate}
class BlocKycEstadoExitoAlSolicitarRol extends BlocKycEstado {
  /// {@macro BlocKycEstadoExitoAlSolicitarRol}
  BlocKycEstadoExitoAlSolicitarRol.desde(super.otro) : super.desde();
}

/// {@template BlocKycEstadoFallido}
/// Estado de error de los componentes de la pantalla 'Kyc'
/// {@endtemplate}
class BlocKycEstadoFallido extends BlocKycEstado {
  /// {@macro BlocKycEstadoError}
  BlocKycEstadoFallido.desde(super.otro) : super.desde();
}

/// {@template BlocKycEstadoErrorOpcionYaElegida}
/// Estado de error de los componentes de la pantalla 'Kyc'
/// {@endtemplate}
class BlocKycEstadoErrorOpcionYaElegida extends BlocKycEstado {
  /// {@macro BlocKycEstadoErrorOpcionYaElegida}
  BlocKycEstadoErrorOpcionYaElegida.desde(super.otro) : super.desde();
}

/// {@template BlocKycEstadoCerrarSesionExitoso}
/// Estado exitoso de cierre de sesion del usuario.
/// {@endtemplate}
class BlocKycEstadoCerrarSesionExitoso extends BlocKycEstado {
  /// {@macro BlocKycEstadoCerrarSesionExitoso}
  BlocKycEstadoCerrarSesionExitoso.desde(
    super.otro,
  ) : super.desde();
}

/// {@template BlocKycEstadoCerrarSesionExitoso}
/// Estado exitoso de cierre de sesion del usuario.
/// {@endtemplate}
class BlocKycEstadoExitoAlSolicitarRegistro extends BlocKycEstado {
  /// {@macro BlocKycEstadoCerrarSesionExitoso}
  BlocKycEstadoExitoAlSolicitarRegistro.desde(
    super.otro,
  ) : super.desde();
}
