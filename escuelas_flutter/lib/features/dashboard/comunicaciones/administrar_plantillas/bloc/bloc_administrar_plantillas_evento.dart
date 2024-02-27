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
    required this.necesitaSupervicion,
  });

  /// Nombre de la plantilla
  final String nombrePlantilla;

  /// Descripción de la plantilla
  final String descripcionPlantilla;

  /// Verifica si la plantilla necesita supervisión
  final bool necesitaSupervicion;
}

/// {@template BlocAdministrarPlantillasEventoCambiarModoEliminar}
/// Evento para cambiar a modo eliminar
/// {@endtemplate}
class BlocAdministrarPlantillasEventoCambiarModoEliminar
    extends BlocAdministrarPlantillasEvento {
  /// {@macro BlocAdministrarPlantillasEventoCambiarModoEliminar}
  BlocAdministrarPlantillasEventoCambiarModoEliminar({
    required this.modoEliminar,
  });

  /// Identifica si se encuentra en modo eliminar
  final bool modoEliminar;
}

/// {@template BlocAdministrarPlantillasEventoCambiarModoEliminar}
/// Evento para cambiar a modo eliminar
/// {@endtemplate}
class BlocAdministrarPlantillasEventoCambiarModoEditar
    extends BlocAdministrarPlantillasEvento {
  /// {@macro BlocAdministrarPlantillasEventoCambiarModoEditar}
  BlocAdministrarPlantillasEventoCambiarModoEditar({
    required this.modoEditar,
  });

  /// Identifica si se encuentra en modo editar
  final bool modoEditar;
}

/// {@template BlocAdministrarPlantillasEventoEliminarPlantillas}
/// Evento para Eliminar plantillas
/// {@endtemplate}
class BlocAdministrarPlantillasEventoEliminarPlantillas
    extends BlocAdministrarPlantillasEvento {
  /// {@macro BlocAdministrarPlantillasEventoEliminarPlantillas}
  const BlocAdministrarPlantillasEventoEliminarPlantillas({
    required this.idPlantilla,
  });

  /// Id de la plantilla a eliminar
  final int idPlantilla;
}

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
class BlocAdministrarPlantillasEventoPlantillaSeleccionada
    extends BlocAdministrarPlantillasEvento {
  /// {@macro BlocAdministrarPlantillasEventoPlantillaSeleccionada}
  const BlocAdministrarPlantillasEventoPlantillaSeleccionada({
    required this.plantillaSeleccionada,
    required this.select,
  });

  /// Bool que verifica si la plantilla esta seleccionada
  final bool select;

  /// Plantilla seleccionada
  final PlantillaComunicacion plantillaSeleccionada;
}

/// {@template BlocAdministrarPlantillasEventoPlantillaNoSeleccionada}
/// Evento para deseleccionar una plantilla y eliminarla del estado
/// listaDePlantillasAEliminar
/// {@endtemplate}
class BlocAdministrarPlantillasEventoPlantillaNoSeleccionada
    extends BlocAdministrarPlantillasEvento {
  /// {@macro BlocAdministrarPlantillasEventoPlantillaNoSeleccionada}
  const BlocAdministrarPlantillasEventoPlantillaNoSeleccionada({
    required this.plantilla,
    required this.select,
  });

  /// Bool que verifica si la plantilla esta seleccionada
  final bool select;

  /// Plantilla
  final PlantillaComunicacion plantilla;
}

/// {@template BlocAministrarPlantillasEventoCancelarModoEliminar}
/// Evento para cancelar el modo eliminar
/// {@endtemplate}
class BlocAministrarPlantillasEventoCancelarModoEliminar

    /// {@macro BlocAministrarPlantillasEventoCancelarModoEliminar}
    extends BlocAdministrarPlantillasEvento {
  const BlocAministrarPlantillasEventoCancelarModoEliminar({
    required this.modoEliminar,
    required this.select,
  });

  final bool modoEliminar;

  /// Bool que verifica si la plantilla esta seleccionada
  final bool select;
}
