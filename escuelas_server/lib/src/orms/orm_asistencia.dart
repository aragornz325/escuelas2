import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmAsistencia extends ORM {
  /// La función `crearAsistenciasEnLote` crea múltiples registros de asistencia diaria en una base de
  /// datos y devuelve un mensaje de éxito si todos los registros se crearon exitosamente.
  ///
  /// Args:
  ///   session (Session): Un objeto de sesión que representa una conexión a una base de datos. Se
  /// utiliza para realizar operaciones de bases de datos.
  ///   asistencias (List<AsistenciaDiaria>): Una lista de objetos de tipo AsistenciaDiaria, que
  /// representa registros de asistencia diaria.
  ///
  /// Returns:
  ///   El método devuelve un `Future<String>`.
  Future<String> crearAsistenciasEnLote(
    Session session, {
    required List<AsistenciaDiaria> asistencias,
  }) async {
    final asistenciasADb =
        await AsistenciaDiaria.db.insert(session, asistencias);

    if (asistenciasADb.length != asistencias.length) {
      throw Exception('No se pudieron crear todas las asistencias');
    }

    return 'Asistencias creadas correctamente';
  }
}
