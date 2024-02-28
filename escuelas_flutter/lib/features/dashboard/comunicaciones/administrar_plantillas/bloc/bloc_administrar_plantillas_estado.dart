part of 'bloc_administrar_plantillas.dart';

/// {@template BlocAdministrarPlantillasEstado}
/// Estados para [BlocAdministrarPlantillas]
/// {@endtemplate}
class BlocAdministrarPlantillasEstado {
  /// {@macro BlocAdministrarPlantillasEstado}
  const BlocAdministrarPlantillasEstado._({
    this.plantilla,
    this.modoEliminar = false,
    this.listaDePlantillas = const [],
    this.listaDePlantillasConCheckbox = const [],
  });

  BlocAdministrarPlantillasEstado.desde(
    BlocAdministrarPlantillasEstado otro, {
    bool? modoEliminar,
    List<PlantillaComunicacion>? listaDePlantillas,
    List<PlantillaConCheckbox>? listaDePlantillasConCheckbox,
    PlantillaComunicacion? plantilla,
  }) : this._(
          modoEliminar: modoEliminar ?? otro.modoEliminar,
          listaDePlantillas: listaDePlantillas ?? otro.listaDePlantillas,
          listaDePlantillasConCheckbox:
              listaDePlantillasConCheckbox ?? otro.listaDePlantillasConCheckbox,
          plantilla: plantilla ?? otro.plantilla,
        );

  /// Bool para identificar si se encuentra en modo eliminar
  final bool modoEliminar;

  /// Lista de plantillas
  final List<PlantillaComunicacion> listaDePlantillas;

  /// Lista de plantillas a eliminar
  final List<PlantillaConCheckbox> listaDePlantillasConCheckbox;

  /// Plantilla
  final PlantillaComunicacion? plantilla;
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
    super.listaDePlantillas,
    super.listaDePlantillasConCheckbox,
    super.plantilla,
  }) : super.desde();
}

/// {@template BlocAdministrarPlantillasEstadoExitoso}
/// Estado exitoso para [PaginaAdministrarPlantillas]
/// {@endtemplate}
class BlocAdministrarPlantillasEstadoExitosoAlEditarPlantilla
    extends BlocAdministrarPlantillasEstado {
  /// {@macro BlocAdministrarPlantillasEstadoExitoso}
  BlocAdministrarPlantillasEstadoExitosoAlEditarPlantilla.desde(
    super.otro, {
    super.listaDePlantillas,
    super.plantilla,
  }) : super.desde();
}

/// {@template BlocAdministrarPlantillasEstadoExitosoAlCrearPlantilla}
/// Estado exitoso para [PaginaAdministrarPlantillas]
/// {@endtemplate}
class BlocAdministrarPlantillasEstadoExitosoAlCrearPlantilla
    extends BlocAdministrarPlantillasEstado {
  /// {@macro BlocAdministrarPlantillasEstadoExitosoAlCrearPlantilla}
  BlocAdministrarPlantillasEstadoExitosoAlCrearPlantilla.desde(
    super.otro, {
    super.modoEliminar,
    super.listaDePlantillas,
    super.plantilla,
  }) : super.desde();
}

class BlocAdministrarPlantillasEstadoExitosoAlCancelarModoEliminar
    extends BlocAdministrarPlantillasEstado {
  /// {@macro BlocAdministrarPlantillasEstadoExitosoAlCancelarModoEliminar}
  BlocAdministrarPlantillasEstadoExitosoAlCancelarModoEliminar.desde(
    super.otro, {
    super.listaDePlantillasConCheckbox,
    super.modoEliminar,
  }) : super.desde();
}
