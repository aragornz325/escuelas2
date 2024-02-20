import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/servicio_plantilla_comunicacion.dart';
import 'package:serverpod/serverpod.dart';

class PlantillaComunicacionEndpoint extends Endpoint with Controller {
  @override
  ServicioPlantillaComunicacion get servicio => ServicioPlantillaComunicacion();

  /// Crea la plantilla de comunicacion en la base de datos.
  Future<PlantillaComunicacion> crearPlantillaComunicacion(
    Session session, {
    required PlantillaComunicacion plantillaComunicacion,
  }) async =>
      ejecutarOperacionControlador(
          session,
          'crearPlantillaComunicacion',
          () => servicio.crearPlantillaComunicacion(session,
              plantillaComunicacion: plantillaComunicacion));

  /// Edita una plantilla
  Future<PlantillaComunicacion> actualizarPlantillaComunicacion(
    Session session, {
    required PlantillaComunicacion plantillaComunicacion,
  }) async {
    return await ejecutarOperacionControlador(
        session,
        'actualizarPlantillaComunicacion',
        () => servicio.actualizarPlantillaComunicacion(session,
            plantillaComunicacion: plantillaComunicacion));
  }

  /// trae la lista de plantillas
  Future<List<PlantillaComunicacion>> listarPlantillasComunicacion(
    Session session,
  ) async {
    return await ejecutarOperacionControlador(
        session,
        'listarPlantillasComunicacion',
        () => servicio.listarPlantillasComunicacion(session));
  }

  /// Elimina lista de plantillas
  Future<bool> eliminarPlantillasComunicacion(
    Session session, {
    required List<int> idPlantillasComunicacion,
  }) async {
    return await ejecutarOperacionControlador(
        session,
        'eliminarPlantillasComunicacion',
        () => servicio.eliminarPlantillasComunicacion(session,
            idPlantillasComunicacion: idPlantillasComunicacion));
  }
}
