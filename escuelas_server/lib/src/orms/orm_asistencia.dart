import 'package:escuelas_server/src/extensiones/expresiones_en_columnas.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmAsistencia extends ORM<AsistenciaDiaria> {
  /// La función `crearAsistenciasEnLote` crea múltiples registros de asistencia diaria en una base de
  /// datos y devuelve un mensaje de éxito si todos los registros se crearon exitosamente.
  ///
  /// Args:
  ///   session (Session): Un objeto de sesión que representa una conexión a una base de datos. Se
  /// utiliza para realizar operaciones de bases de datos.
  ///   asistencias (List<AsistenciaDiaria>): Una lista de objetos de tipo AsistenciaDiaria, que
  /// representa registros de asistencia diaria.
  Future<List<AsistenciaDiaria>> crearAsistenciasEnLote(
    Session session, {
    required List<AsistenciaDiaria> asistencias,
  }) async {
    final asistenciasADb = await AsistenciaDiaria.db.insert(
      session,
      asistencias,
    );

    // TODO(anyone):
    // Mejorar esto, se hizo para no perder las relaciones que
    // tiene la lista de asistencias que necesita el front
    final respuesta = await AsistenciaDiaria.db.find(
      session,
      where: (t) => t.id.contains(
        asistenciasADb.map((e) => e.id!).toList(),
        AsistenciaDiaria.t.tableName,
      ),
      include: AsistenciaDiaria.include(estudiante: Usuario.include()),
    );

    if (asistenciasADb.length != asistencias.length) {
      throw Exception('No se pudieron crear todas las asistencias');
    }

    return respuesta;
  }

  /// La función `actualizarAsistenciasEnLote` actualiza múltiples registros de asistencia diaria en una base de
  /// datos y devuelve un mensaje de éxito si todos los registros se actualizaron exitosamente.
  Future<List<AsistenciaDiaria>> actualizarAsistenciasEnLote(
    Session session, {
    required List<AsistenciaDiaria> asistencias,
  }) async {
    final ahora = DateTime.now();
    List<AsistenciaDiaria> nuevasAsistenciasCreadas = [];

    final asistenciasActualizadas = await AsistenciaDiaria.db.update(
      session,
      asistencias,
    );

    final asistenciasNoExistentes = asistencias
        .where((element) => asistenciasActualizadas.contains(element) == false)
        .toList();
        
    if (asistenciasNoExistentes.isNotEmpty) {
      final nuevasAsistencias = await insertarVariosRegistrosEnDb(
        session,
        nuevosRegistros: asistenciasNoExistentes
            .map(
              (e) => e
                ..fechaCreacion = ahora
                ..ultimaModificacion = ahora,
            )
            .toList(),
      );

      nuevasAsistenciasCreadas.addAll(nuevasAsistencias);
    }

    return [
      ...asistenciasActualizadas,
      ...nuevasAsistenciasCreadas,
    ];
  }

  /// la funcion "traerAsistenciaPorDia" trae la asistencia de un dia en particular
  Future<List<AsistenciaDiaria>> traerAsistenciaPorDia(
    Session session, {
    required DateTime fecha,
  }) async {
    DateTime inicioDelDia = DateTime(fecha.year, fecha.month, fecha.day);
    DateTime finDelDia =
        DateTime(fecha.year, fecha.month, fecha.day, 23, 59, 59);

    final asistencias = await AsistenciaDiaria.db.find(
      session,
      where: (t) => t.fecha.between(inicioDelDia, finDelDia),
      include: AsistenciaDiaria.include(estudiante: Usuario.include()),
    );

    if (asistencias.isEmpty) {
      return [];
    }
    return asistencias;
  }
}
