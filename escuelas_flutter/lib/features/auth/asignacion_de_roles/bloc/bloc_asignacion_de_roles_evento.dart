part of 'bloc_asignacion_de_roles.dart';

/// {@template BlocAsignacionDeRolesEvento}
/// Clase padre de los eventos de [BlocAsignacionDeRoles].
/// {@endtemplate}
abstract class BlocAsignacionDeRolesEvento {
  /// {@macro BlocAsignacionDeRolesEvento}
  const BlocAsignacionDeRolesEvento();
}

/// {@template BlocAsignacionDeRolesEventoInicializar}
/// Inicializa la pagina, es decir, trae todos los usuarios pendientes a asignar
/// un rol
/// {@endtemplate}
class BlocAsignacionDeRolesEventoInicializar
    extends BlocAsignacionDeRolesEvento {
  /// {@macro BlocAsignacionDeRolesEventoInicializar}
  const BlocAsignacionDeRolesEventoInicializar({
    this.idUsuario,
  });

  /// Id del usuario que se va a asignar un rol
  final int? idUsuario;
}
