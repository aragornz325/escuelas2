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
  final String nuevoNombre;
  final String nuevaDescripcion;
  final bool nuevaNecesitaSupervision;
  final int idPlantilla;
}

// class BlocAdministrarPlantillasEventoCambioSeleccionado
//     extends BlocAdministrarPlantillasEvento {
//   /// {@macro BlocAdministrarPlantillasEventoCambioSeleccionado}
//   const BlocAdministrarPlantillasEventoCambioSeleccionado({
//     required this.plantillaSeleccionada,
//   });

//   final bool plantillaSeleccionada;
// }
