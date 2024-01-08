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

  /// La función `traerAsistenciaPorDia` recupera la asistencia de un día en particular.
  /// Args:
  ///  session (Session): Un objeto de tipo "Session" que representa una conexión a una base de datos.
  /// idComision (int): Un número entero que representa el identificador único de la comisión.
  /// fecha (DateTime): Un objeto de tipo "DateTime" que representa la fecha de la asistencia.
  /// Returns:
  ///  El método `traerAsistenciaPorDia` devuelve un `Futuro<List<AsistenciaDiaria>>`.
  Future<List<AsistenciaDiaria>> traerAsistenciaPorDia(
    Session session, {
    required int idComision,
    required DateTime fecha,
  }) async {
    return await ejecutarOperacion(
      () => orm.traerAsistenciaPorDia(
        session,
        idComision: idComision,
        fecha: fecha,
      ),
    );
  }

  /// La función `actualizarAsistenciasEnLote` actualiza múltiples registros de asistencia diaria en un lote.
  /// Args:
  ///  session (Session):
  /// asistencias (List<AsistenciaDiaria>): Una lista de objetos del tipo "AsistenciaDiaria".
  /// Returns:
  /// El método `actualizarAsistenciasEnLote` devuelve un `Futuro<String>`.
  Future<String> actualizarAsistenciasEnLote(
    Session session, {
    required List<AsistenciaDiaria> asistencias,
  }) async {
    final ahora = DateTime.now();
    for (var asistencia in asistencias) {
      asistencia.ultimaModificacion = ahora;
    }
    return await ejecutarOperacion(
      () => orm.actualizarAsistenciasEnLote(
        session,
        asistencias: asistencias,
      ),
    );
  }
}
