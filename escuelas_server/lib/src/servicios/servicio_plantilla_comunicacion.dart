import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_plantilla_comunicacion.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:serverpod/serverpod.dart';

class ServicioPlantillaComunicacion extends Servicio<OrmPlantillaComunicacion> {

  @override
  OrmPlantillaComunicacion get orm => OrmPlantillaComunicacion();
  
  /// Crea la plantilla de comunicacion en la base de datos.
  Future<PlantillaComunicacion> crearPlantillaComunicacion(
    Session session, {
    required PlantillaComunicacion plantillaComunicacion,
  }) async =>
      ejecutarOperacion(() => orm.crearPlantillaComunicacion(session,
          plantillaComunicacion: plantillaComunicacion));

  /// Edita una plantilla
  Future<PlantillaComunicacion> actualizarPlantillaComunicacion(
    Session session, {
    List<Column<dynamic>> Function(PlantillaComunicacionTable)? columns,
    required PlantillaComunicacion plantillaComunicacion,
  }) async {
    return await ejecutarOperacion(() => orm.actualizarPlantillaComunicacion(
        session,
        plantillaComunicacion: plantillaComunicacion,
        columns: (t) => [t.titulo, t.nota, t.necesitaSupervision, t.ultimaModificacion],));
  }

  /// trae la lista de plantillas
  Future<List<PlantillaComunicacion>> listarPlantillasComunicacion(
    Session session,
  ) async {
    return await ejecutarOperacion(
        () => orm.listarPlantillasComunicacion(session));
  }

  /// Actualiza lista de plantillas
  Future<List<PlantillaComunicacion>> actualizarPlantillasComunicacion(
    Session session, {
    required List<PlantillaComunicacion> plantillasComunicacion,
    List<Column<dynamic>> Function(PlantillaComunicacionTable)? columnas,
  }) async {
    return await ejecutarOperacion(() => orm.actualizarPlantillasComunicacion(
        session,
        plantillasComunicacion: plantillasComunicacion,
        columnas: columnas));
  }

  /// Elimina lista de plantillas
  Future<bool> eliminarPlantillasComunicacion(
    Session session, {
    required List<int> idPlantillasComunicacion,
  }) async {
    return await ejecutarOperacion(() => orm.eliminarPlantillasComunicacion(
        session,
        idPlantillasComunicacion: idPlantillasComunicacion));
  }
}
