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

  /// la funcion "traerAsistenciaPorDia" trae la asistencia de un dia en particular
  Future<List<AsistenciaDiaria>> traerAsistenciaPorDia(
    Session session, {
    required int idComision,
    required DateTime fecha,
  }) async {
    DateTime inicioDelDia = DateTime(fecha.year, fecha.month, fecha.day);
    DateTime finDelDia =
        DateTime(fecha.year, fecha.month, fecha.day, 23, 59, 59);

    final asistencias = await AsistenciaDiaria.db.find(
      session,
      where: (t) =>
          t.fecha.between(inicioDelDia, finDelDia) &
          t.comisionId.equals(idComision),
      include: AsistenciaDiaria.include(estudiante: Usuario.include()),
    );

    if (asistencias.isEmpty) {
      throw ExcepcionCustom(
          codigoError: 404,
          mensaje: 'No hay asistencias con ese id de comision',
          titulo: 'No hay asistencias',
          tipoDeError: TipoExcepcion.noEncontrado);
    }
    return asistencias;
  }
}
