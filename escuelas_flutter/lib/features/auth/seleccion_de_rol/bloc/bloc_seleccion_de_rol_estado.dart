part of 'bloc_seleccion_de_rol.dart';

/// {@template BlocSeleccionDeRolEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocSeleccionDeRolEstado {
  /// {@macro BlocSeleccionDeRolEstado}
  const BlocSeleccionDeRolEstado._({
    this.listaRoles = const [],
  });

  BlocSeleccionDeRolEstado.desde(
    BlocSeleccionDeRolEstado otro, {
    List<Rol>? listaRoles,
  }) : this._(
          listaRoles: listaRoles ?? otro.listaRoles,
        );

  /// Lista de roles a mostrar en pantalla
  final List<Rol> listaRoles;

  /// Indica si el state es cargando
  bool get estaEnEstadoCargando => this is BlocSeleccionDeRolEstadoCargando;
}

/// {@template BlocSeleccionDeRolEstadoInicial}
/// Estado inicial de los componentes de la pantalla 'SeleccionDeRol'
/// {@endtemplate}
class BlocSeleccionDeRolEstadoInicial extends BlocSeleccionDeRolEstado {
  /// {@macro BlocSeleccionDeRolEstadoInicial}
  const BlocSeleccionDeRolEstadoInicial() : super._();
}

/// {@template BlocSeleccionDeRolEstadoCargando}
/// Estado de cargando de los componentes de la pantalla 'SeleccionDeRol'
/// {@endtemplate}
class BlocSeleccionDeRolEstadoCargando extends BlocSeleccionDeRolEstado {
  /// {@macro BlocSeleccionDeRolEstadoCargando}
  BlocSeleccionDeRolEstadoCargando.desde(
    super.otro,
  ) : super.desde();
}

/// {@template BlocSeleccionDeRolEstadoExitosoGeneral}
/// Estado exitoso general de los componentes de la pantalla 'SeleccionDeRol'
/// {@endtemplate}
class BlocSeleccionDeRolEstadoExitosoGeneral extends BlocSeleccionDeRolEstado {
  /// {@macro BlocSeleccionDeRolEstadoExitosoGeneral}
  BlocSeleccionDeRolEstadoExitosoGeneral.desde(
    super.otro, {
    required super.listaRoles,
  }) : super.desde();
}

/// {@template BlocSeleccionDeRolEstadoError}
/// Estado de error de los componentes de la pantalla 'SeleccionDeRol'
/// {@endtemplate}
class BlocSeleccionDeRolEstadoError extends BlocSeleccionDeRolEstado {
  /// {@macro BlocSeleccionDeRolEstadoError}
  BlocSeleccionDeRolEstadoError.desde(super.otro) : super.desde();
}
