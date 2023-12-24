part of 'bloc_seleccion_de_rol.dart';

/// {@template BlocSeleccionDeRolEvento}
/// Clase padre de los eventos de 'SeleccionDeRol'
/// {@endtemplate}
abstract class BlocSeleccionDeRolEvento {
  /// {@macro BlocSeleccionDeRolEvento}
  const BlocSeleccionDeRolEvento();
}

/// {@template BlocSeleccionDeRolEventoInicializar}
/// Trae los roles para que el usuario pueda elegir cual solicitar
/// {@endtemplate}
class BlocSeleccionDeRolEventoTraerRoles extends BlocSeleccionDeRolEvento {}
