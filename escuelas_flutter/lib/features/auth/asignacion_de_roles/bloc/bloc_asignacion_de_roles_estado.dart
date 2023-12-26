part of 'bloc_asignacion_de_roles.dart';

/// {@template BlocAsignacionDeRolesEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocAsignacionDeRolesEstado {
  /// {@macro BlocAsignacionDeRolesEstado}
  const BlocAsignacionDeRolesEstado._({
    this.listaDocentes = const [],
    this.listaAlumnos = const [],
  });

  BlocAsignacionDeRolesEstado.desde(
    BlocAsignacionDeRolesEstado otro, {
    List<InfoUsuario>? listaDocentes,
    List<InfoUsuario>? listaAlumnos,
  }) : this._(
          listaDocentes: listaDocentes ?? otro.listaDocentes,
          listaAlumnos: listaAlumnos ?? otro.listaAlumnos,
        );

  final List<InfoUsuario> listaDocentes;
  final List<InfoUsuario> listaAlumnos;
}

/// {@template BlocAsignacionDeRolesEstadoInicial}
/// Estado inicial de los componentes de la pantalla 'Inicio'
/// {@endtemplate}
class BlocAsignacionDeRolesEstadoInicial extends BlocAsignacionDeRolesEstado {
  /// {@macro BlocAsignacionDeRolesEstadoInicial}
  const BlocAsignacionDeRolesEstadoInicial() : super._();
}

/// {@template BlocAsignacionDeRolesEstadoCargando}
/// Estado de cargando de los componentes de la pantalla 'Inicio'
/// {@endtemplate}
class BlocAsignacionDeRolesEstadoCargando extends BlocAsignacionDeRolesEstado {
  /// {@macro BlocAsignacionDeRolesEstadoCargando}
  BlocAsignacionDeRolesEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocAsignacionDeRolesEstadoExitoso}
/// Estado exitoso general de los componentes de la pantalla 'Inicio'
/// {@endtemplate}
class BlocAsignacionDeRolesEstadoExitoso extends BlocAsignacionDeRolesEstado {
  /// {@macro BlocAsignacionDeRolesEstadoExitoso}
  BlocAsignacionDeRolesEstadoExitoso.desde(
    super.otro, {
    super.listaDocentes,
    super.listaAlumnos,
  }) : super.desde();
}

/// {@template BlocAsignacionDeRolesEstadoFallido}
/// Estado de error de los componentes de la pantalla 'Inicio'
/// {@endtemplate}
class BlocAsignacionDeRolesEstadoError extends BlocAsignacionDeRolesEstado {
  /// {@macro BlocAsignacionDeRolesEstadoError}
  BlocAsignacionDeRolesEstadoError.desde(super.otro) : super.desde();
}
