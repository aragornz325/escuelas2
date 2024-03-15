part of 'bloc_administrar_plantillas.dart';

/// {@template BlocAdministrarPlantillasEvento}
/// Eventos para [BlocAdministrarPlantillas]
/// {@endtemplate}
abstract class BlocAdministrarPlantillasEvento {
  /// {@macro BlocAdministrarPlantillasEvento}
  const BlocAdministrarPlantillasEvento();
}

/// {@template BlocAdministrarPlantillasEventoInicializar}
/// Evento que traera la lista de plantillas del servidor
/// {@endtemplate}
class BlocAdministrarPlantillasEventoInicializar
    extends BlocAdministrarPlantillasEvento {
  /// {@macro BlocAdministrarPlantillasEventoInicializar}
  const BlocAdministrarPlantillasEventoInicializar();
}

/// {@template BlocAdministrarPlantillasEventoAgregarPlantilla}
/// Evento para agregar una nueva plantilla
/// {@endtemplate}
class BlocAdministrarPlantillasEventoAgregarPlantilla
    extends BlocAdministrarPlantillasEvento {
  /// {@macro BlocAdministrarPlantillasEventoAgregarPlantilla}
  const BlocAdministrarPlantillasEventoAgregarPlantilla({
    required this.nombrePlantilla,
    required this.descripcionPlantilla,
    required this.necesitaSupervision,
  });

  /// Nombre de la plantilla
  final String nombrePlantilla;

  /// Descripción de la plantilla
  final String descripcionPlantilla;

  /// Verifica si la plantilla necesita supervisión
  final bool necesitaSupervision;
}

/// {@template BlocAdministrarPlantillasEventoCambiarModoEliminar}
/// Evento para cambiar a modo eliminar
/// {@endtemplate}
class BlocAdministrarPlantillasEventoAlternarModoEliminar
    extends BlocAdministrarPlantillasEvento {}

/// {@template BlocAdministrarPlantillasEventoEliminarPlantillas}
/// Evento para Eliminar plantillas
/// {@endtemplate}
class BlocAdministrarPlantillasEventoEliminarPlantillas
    extends BlocAdministrarPlantillasEvento {}

/// {@template BlocAdministrarPlantillasEventoEditarPlantilla}
/// Evento para Editar una plantilla
/// {@endtemplate}
class BlocAdministrarPlantillasEventoEditarPlantilla
    extends BlocAdministrarPlantillasEvento {
  /// {@macro BlocAdministrarPlantillasEventoEditarPlantilla}
  const BlocAdministrarPlantillasEventoEditarPlantilla({
    required this.nuevoNombre,
    required this.nuevaDescripcion,
    required this.nuevaNecesitaSupervision,
    required this.plantilla,
    required this.idPlantilla,
  });

  /// Plantilla a editar
  final PlantillaComunicacion plantilla;

  /// Nuevo nombre de la plantilla
  final String nuevoNombre;

  /// Nueva descripción de la plantilla
  final String nuevaDescripcion;

  /// Nuevo estado de supervision
  final bool nuevaNecesitaSupervision;

  /// id de la plantilla a modificar
  final int idPlantilla;
}

/// {@template BlocAdministrarPlantillasEventoPlantillaSeleccionada}
/// Evento para seleccionar una plantilla y agregarla al estado
/// listaDePlantillasAEliminar
/// {@endtemplate}
class BlocAdministrarPlantillasEventoAlternarSeleccionPlantilla
    extends BlocAdministrarPlantillasEvento {
  /// {@macro BlocAdministrarPlantillasEventoPlantillaSeleccionada}
  const BlocAdministrarPlantillasEventoAlternarSeleccionPlantilla({
    required this.idPlantillaSeleccionada,
  });

  /// Plantilla seleccionada
  final int idPlantillaSeleccionada;
}
