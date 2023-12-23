part of 'bloc_asignacion_de_roles.dart';

/// {@template BlocAsignacionDeRolesEvento}
/// Clase padre de los eventos de 'AsignacionDeRoles'
/// {@endtemplate}
abstract class BlocAsignacionDeRolesEvento {
  /// {@macro BlocAsignacionDeRolesEvento}
  const BlocAsignacionDeRolesEvento();
}

/// {@template BlocAsignacionDeRolesEventoInicializar}
/// Trae los roles para que el usuario pueda elegir cual solicitar
/// {@endtemplate}
class BlocAsignacionDeRolesEventoTraerRoles
    extends BlocAsignacionDeRolesEvento {}
