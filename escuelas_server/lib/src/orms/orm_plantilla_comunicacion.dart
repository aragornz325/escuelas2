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

  Future<PlantillaComunicacion> modificarPlantillaComunicacion(
    Session session, {
    List<Column<dynamic>> Function(PlantillaComunicacionTable)? columns,
    required PlantillaComunicacion plantillaComunicacion,
  }) async {
    return ejecutarOperacionOrm(
      session,
      (session) => PlantillaComunicacion.db.updateRow(
        session,
        plantillaComunicacion,
        columns: columns,
      ),
    );
  }

  Future<List<PlantillaComunicacion>> listarPlantillasComunicacion(
    Session session,
  ) async {
    return ejecutarOperacionOrm(
        session,
        (session) => PlantillaComunicacion.db
            .find(session, where: (t) => t.fechaEliminacion.equals(null)));
  }

  // Future<bool> eliminarPlantillaComunicacion(
  //   Session session, {
  //   required int id,
  // }) async {
  //   final ahora = DateTime.now();
  //   final eliminado = await ejecutarOperacionOrm(
  //     session,
  //     (session) => modificarPlantillaComunicacion(
  //       session,
  //       plantillaComunicacion: PlantillaComunicacion(
  //         id: id,
  //         titulo: '',
  //         nota: '',
  //         necesitaSupervision: false,
  //         ultimaModificacion: ahora,
  //         fechaEliminacion: ahora,
  //         fechaCreacion: ahora,
  //       ),
  //       columns: (t) => [
  //         t.ultimaModificacion,
  //         t.fechaEliminacion,
  //       ],
  //     ),
  //   );
  //   return eliminado.id != null;
  // }

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

  // Future<bool> eliminarPlantillasComunicacion(
  //   Session session, {
  //   required List<PlantillaComunicacion> plantillasComunicacion,
  // }) async {
  //   final ahora = DateTime.now();

  //   final actualizarPlantillas = await actualizarPlantillasComunicacion(
  //     session,
  //     plantillasComunicacion: plantillasComunicacion
  //         .map(
  //           (e) => e
  //             ..ultimaModificacion = ahora
  //             ..fechaEliminacion = ahora,
  //         )
  //         .toList(),
  //     columnas: (t) => [
  //       t.ultimaModificacion,
  //       t.fechaEliminacion,
  //     ],
  //   );

  //   return actualizarPlantillas.length == plantillasComunicacion.length;
  // }

  Future<bool> eliminarPlantillasComunicaciones(
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
