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
  const BlocAdministrarPlantillasEventoAgregarPlantilla();
}

/// {@template BlocAdministrarPlantillasEventoEliminarPlantillas}
/// Evento para Eliminar plantillas
/// {@endtemplate}
class BlocAdministrarPlantillasEventoEliminarPlantillas
    extends BlocAdministrarPlantillasEvento {
  /// {@macro BlocAdministrarPlantillasEventoEliminarPlantillas}
  const BlocAdministrarPlantillasEventoEliminarPlantillas();
}

/// {@template BlocAdministrarPlantillasEventoEditarPlantilla}
/// Evento para Editar una plantilla
/// {@endtemplate}
class BlocAdministrarPlantillasEventoEditarPlantilla
    extends BlocAdministrarPlantillasEvento {
  /// {@macro BlocAdministrarPlantillasEventoEditarPlantilla}
  const BlocAdministrarPlantillasEventoEditarPlantilla();
}
