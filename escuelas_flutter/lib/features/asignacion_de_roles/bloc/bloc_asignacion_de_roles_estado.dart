part of 'bloc_asignacion_de_roles.dart';

/// {@template BlocAsignacionDeRolesEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocAsignacionDeRolesEstado extends Equatable {
  /// {@macro BlocAsignacionDeRolesEstado}
  const BlocAsignacionDeRolesEstado._({
    this.listaRoles = const [],
  });

  BlocAsignacionDeRolesEstado.desde(
    BlocAsignacionDeRolesEstado otro, {
    List<Rol>? listaRoles,
  }) : this._(
          listaRoles: listaRoles ?? otro.listaRoles,
        );

  /// Lista de articulos a mostrar bajo el encabezado del AsignacionDeRoles
  final List<Rol> listaRoles;

  @override
  List<Object> get props => [
        listaRoles,
      ];

  /// Indica si el state es cargando
  bool get estaEnEstadoCargando => this is BlocAsignacionDeRolesEstadoCargando;
}

/// {@template BlocAsignacionDeRolesEstadoInicial}
/// Estado inicial de los componentes de la pantalla 'AsignacionDeRoles'
/// {@endtemplate}
class BlocAsignacionDeRolesEstadoInicial extends BlocAsignacionDeRolesEstado {
  /// {@macro BlocAsignacionDeRolesEstadoInicial}
  const BlocAsignacionDeRolesEstadoInicial() : super._();
}

/// {@template BlocAsignacionDeRolesEstadoCargando}
/// Estado de cargando de los componentes de la pantalla 'AsignacionDeRoles'
/// {@endtemplate}
class BlocAsignacionDeRolesEstadoCargando extends BlocAsignacionDeRolesEstado {
  /// {@macro BlocAsignacionDeRolesEstadoCargando}
  BlocAsignacionDeRolesEstadoCargando.desde(
    super.otro,
  ) : super.desde();
}

/// {@template BlocAsignacionDeRolesEstadoExitosoGeneral}
/// Estado exitoso general de los componentes de la pantalla 'AsignacionDeRoles'
/// {@endtemplate}
class BlocAsignacionDeRolesEstadoExitosoGeneral
    extends BlocAsignacionDeRolesEstado {
  /// {@macro BlocAsignacionDeRolesEstadoExitosoGeneral}
  BlocAsignacionDeRolesEstadoExitosoGeneral.desde(
    super.otro, {
    required super.listaRoles,
  }) : super.desde();
}

/// {@template BlocAsignacionDeRolesEstadoError}
/// Estado de error de los componentes de la pantalla 'AsignacionDeRoles'
/// {@endtemplate}
class BlocAsignacionDeRolesEstadoError extends BlocAsignacionDeRolesEstado {
  /// {@macro BlocAsignacionDeRolesEstadoError}
  BlocAsignacionDeRolesEstadoError.desde(super.otro) : super.desde();
}
