part of 'bloc_administrar_plantillas.dart';

/// {@template BlocAdministrarPlantillasEstado}
/// Estados para [BlocAdministrarPlantillas]
/// {@endtemplate}
class BlocAdministrarPlantillasEstado {
  /// {@macro BlocAdministrarPlantillasEstado}
  const BlocAdministrarPlantillasEstado._({
    this.modoEliminar = false,
    this.modoEditar = false,
    this.seleccionado = false,
    this.plantillas = const [],
  });

  BlocAdministrarPlantillasEstado.desde(
    BlocAdministrarPlantillasEstado otro, {
    bool? modoEliminar,
    bool? modoEditar,
    bool? seleccionado,
    List<PlantillaDeComunicaciones>? plantillas,
  }) : this._(
          modoEliminar: modoEliminar ?? otro.modoEliminar,
          modoEditar: modoEditar ?? otro.modoEditar,
          plantillas: plantillas ?? otro.plantillas,
          seleccionado: seleccionado ?? otro.seleccionado,
        );

  /// Bool para identificar si se encuentra en modo eliminar
  final bool modoEliminar;

  /// Bool para identificar si se encuentra en modo editar
  final bool modoEditar;

  /// Bool para identificar si la plantilla se encuentra seleccionada en modo
  /// eliminar
  final bool seleccionado;

  /// Lista de plantillas
  final List<PlantillaDeComunicaciones> plantillas;
}

/// {@template BlocAdministrarPlantillasEstadoInicial}
/// Estado inicial para [PaginaAdministrarPlantillas]
/// {@endtemplate}
class BlocAdministrarPlantillasEstadoInicial
    extends BlocAdministrarPlantillasEstado {
  /// {@macro BlocAdministrarPlantillasEstadoInicial}
  const BlocAdministrarPlantillasEstadoInicial() : super._();
}

/// {@template BlocAdministrarPlantillasEstadoCargando}
/// Estado cargando para [PaginaAdministrarPlantillas]
/// {@endtemplate}
class BlocAdministrarPlantillasEstadoCargando
    extends BlocAdministrarPlantillasEstado {
  /// {@macro BlocAdministrarPlantillasEstadoCargando}
  BlocAdministrarPlantillasEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocAdministrarPlantillasEstadoError}
/// Estado Error para [PaginaAdministrarPlantillas]
/// {@endtemplate}
class BlocAdministrarPlantillasEstadoError
    extends BlocAdministrarPlantillasEstado {
  /// {@macro BlocAdministrarPlantillasEstadoError}
  BlocAdministrarPlantillasEstadoError.desde(super.otro) : super.desde();
}

/// {@template BlocAdministrarPlantillasEstadoExitoso}
/// Estado exitoso para [PaginaAdministrarPlantillas]
/// {@endtemplate}
class BlocAdministrarPlantillasEstadoExitoso
    extends BlocAdministrarPlantillasEstado {
  /// {@macro BlocAdministrarPlantillasEstadoExitoso}
  BlocAdministrarPlantillasEstadoExitoso.desde(
    super.otro, {
    super.modoEliminar,
    super.modoEditar,
    super.plantillas,
    super.seleccionado,
  }) : super.desde();
}
