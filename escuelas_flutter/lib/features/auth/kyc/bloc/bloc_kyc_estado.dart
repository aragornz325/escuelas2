part of 'bloc_kyc.dart';

/// {@template BlocKycEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocKycEstado {
  /// {@macro BlocKycEstado}
  const BlocKycEstado._({
    this.listaCursos = const [],
    this.listaMaterias = const [],
    this.opcionesKyc = const [],
    this.listaRoles = const [],
    this.rolElegido,
  });

  BlocKycEstado.desde(
    BlocKycEstado otro, {
    List<Curso>? listaCursos,
    List<Materia>? listaMaterias,
    List<OpcionKyc>? opcionesKyc,
    Rol? rolElegido,
    List<Rol>? listaRoles,
  }) : this._(
          listaCursos: listaCursos ?? otro.listaCursos,
          listaMaterias: listaMaterias ?? otro.listaMaterias,
          opcionesKyc: opcionesKyc ?? otro.opcionesKyc,
          rolElegido: rolElegido ?? otro.rolElegido,
          listaRoles: listaRoles ?? otro.listaRoles,
        );

  /// Lista de cursos de la escuela a la que pertenece el usuario
  final List<Curso> listaCursos;

  /// Lista de materias de la escuela a la que pertenece el usuario
  final List<Materia> listaMaterias;

  /// Lista de opciones de kyc (inicialmente hay una)
  final List<OpcionKyc> opcionesKyc;

  /// Rol elegido por el usuario en la pantalla de seleccion de rol
  final Rol? rolElegido;

  /// Lista de roles a mostrar en pantalla
  final List<Rol> listaRoles;

  /// Indica si el state es cargando
  bool get estaEnEstadoCargando => this is BlocKycEstadoCargando;

  /// Retorna la lista de cursos de la escuela a la que pertenece el usuario en
  /// forma de [PopupOption]
  List<PopupOption> get listaOpcionesCursos => listaCursos
      .map(
        (curso) => PopupOption(
          id: curso.id,
          name: curso.nombre,
        ),
      )
      .toList();

  /// Retorna la lista de materias de la escuela a la que pertenece el usuario
  /// en forma de [PopupOption]
  List<PopupOption> get listaOpcionesMaterias => listaMaterias
      .map(
        (materia) => PopupOption(
          id: materia.id,
          name: materia.nombre,
        ),
      )
      .toList();
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
    super.listaCursos,
    super.listaMaterias,
    super.opcionesKyc,
    super.rolElegido,
    super.listaRoles,
  }) : super.desde();
}

/// {@template BlocKycEstadoFallido}
/// Estado de error de los componentes de la pantalla 'Kyc'
/// {@endtemplate}
class BlocKycEstadoError extends BlocKycEstado {
  /// {@macro BlocKycEstadoError}
  BlocKycEstadoError.desde(super.otro) : super.desde();
}
