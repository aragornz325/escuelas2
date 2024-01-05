import 'package:escuelas_server/src/generated/asistencia/asistencia_diaria.dart';
import 'package:escuelas_server/src/orms/orm_asistencia.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:serverpod/serverpod.dart';

class ServicioAsistencia extends Servicio<OrmAsistencia> {
  @override
  OrmAsistencia get orm => OrmAsistencia();

  /// La función `crearAsistenciasEnLote` crea múltiples registros de asistencia diaria en un lote.
  /// 
  /// Args:
  ///   session (Session): 
  ///   asistencias (List<AsistenciaDiaria>): Una lista de objetos del tipo "AsistenciaDiaria".
  /// 
  /// Returns:
  ///   El método `crearAsistenciasEnLote` devuelve un `Futuro<String>`.
  Future<String> crearAsistenciasEnLote(
    Session session, {
    required List<AsistenciaDiaria> asistencias,
  }) async {
    final ahora = DateTime.now();
    for (var asistencia in asistencias) {
      asistencia.ultimaModificacion = ahora;
      asistencia.fechaCreacion = ahora;
    }
    return await ejecutarOperacion(
      () => orm.crearAsistenciasEnLote(
        session,
        asistencias: asistencias,
      ),
    );
  }
}
