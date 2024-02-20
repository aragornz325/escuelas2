import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmPlantillaComunicacion extends ORM {
  /// Crea la plantilla de comunicacion en la base de datos.
  Future<PlantillaComunicacion> crearPlantillaComunicacion(
    Session session, {
    required PlantillaComunicacion plantillaComunicacion,
  }) async =>
      ejecutarOperacionOrm(
        session,
        (session) => PlantillaComunicacion.db.insertRow(
          session,
          plantillaComunicacion,
        ),
      );

  /// Editar
  Future<PlantillaComunicacion> actualizarPlantillaComunicacion(
    Session session, {
    List<Column<dynamic>> Function(PlantillaComunicacionTable)? columns,
    required PlantillaComunicacion plantillaComunicacion,
  }) async {
    return await ejecutarOperacionOrm(
      session,
      (session) => PlantillaComunicacion.db.updateRow(
        session,
        plantillaComunicacion,
        columns: columns,
      ),
    );
  }

  /// trae la lista de plantillas
  Future<List<PlantillaComunicacion>> listarPlantillasComunicacion(
    Session session,
  ) async {
    return await ejecutarOperacionOrm(
        session,
        (session) => PlantillaComunicacion.db
            .find(session, where: (t) => t.fechaEliminacion.equals(null)));
  }

  /// Actualiza lista de plantillas
  Future<List<PlantillaComunicacion>> actualizarPlantillasComunicacion(
    Session session, {
    required List<PlantillaComunicacion> plantillasComunicacion,
    List<Column<dynamic>> Function(PlantillaComunicacionTable)? columnas,
  }) async {
    return await PlantillaComunicacion.db.update(
      session,
      plantillasComunicacion,
      columns: columnas,
    );
  }

  /// Elimina lista de plantillas
  Future<bool> eliminarPlantillasComunicacion(
    Session session, {
    required List<int> idPlantillasComunicacion,
  }) async {
    final ahora = DateTime.now();

    final actualizarPlantillas_ = await actualizarPlantillasComunicacion(
      session,
      plantillasComunicacion: idPlantillasComunicacion
          .map(
            (e) => PlantillaComunicacion(
              id: e,
              titulo: '',
              necesitaSupervision: false,
              nota: '',
              ultimaModificacion: ahora,
              fechaEliminacion: ahora,
              fechaCreacion: ahora,
            ),
          )
          .toList(),
      columnas: (t) => [
        t.ultimaModificacion,
        t.fechaEliminacion,
      ],
    );

    return actualizarPlantillas_.length == idPlantillasComunicacion.length;
  }
}
