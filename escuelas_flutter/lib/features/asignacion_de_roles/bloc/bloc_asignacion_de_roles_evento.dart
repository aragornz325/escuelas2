part of 'bloc_asignacion_de_roles.dart';

/// {@template BlocAsignacionDeRolesEvento}
/// Clase padre de los eventos de 'AsignacionDeRoles'
/// {@endtemplate}
abstract class BlocAsignacionDeRolesEvento extends Equatable {
  /// {@macro BlocAsignacionDeRolesEvento}
  const BlocAsignacionDeRolesEvento();

  @override
  List<Object> get props => [];
}

/// {@template BlocAsignacionDeRolesEventoInicializar}
/// Inicializa la pagina 'AsignacionDeRoles'
/// {@endtemplate}
class BlocAsignacionDeRolesEventoInicializar
    extends BlocAsignacionDeRolesEvento {}

/// {@template BlocAsignacionDeRolesEventoFiltrarPorNombreEntregable}
/// Filtra por el nombre del articulo/Entregable.
/// {@endtemplate}
class BlocAsignacionDeRolesEventoFiltrarPorNombreEntregable
    extends BlocAsignacionDeRolesEvento {
  /// {@macro BlocAsignacionDeRolesEventoFiltrarPorNombreEntregable}
  const BlocAsignacionDeRolesEventoFiltrarPorNombreEntregable({
    required this.nombreEntregable,
  });

  /// nombre del articulo/Entregable a filtrar.
  final String? nombreEntregable;
}
