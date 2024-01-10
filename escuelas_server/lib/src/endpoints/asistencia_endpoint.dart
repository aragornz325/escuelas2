import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/servicio_asistencia.dart';
import 'package:serverpod/server.dart';

class AsistenciaEndpoint extends Endpoint with Controller<ServicioAsistencia> {
  @override
  ServicioAsistencia get servicio => ServicioAsistencia();

  @override
  bool get requireLogin => false;

  /// La función `crearAsistenciasEnBatch` crea un nuevo objeto `AsistenciaDiaria`
  /// en la base de datos usando la sesión proporcionada y devuelve el objeto creado.
  Future<List<AsistenciaDiaria>> crearAsistenciasEnLote(
    Session session, {
    required List<AsistenciaDiaria> asistencias,
  }) async {
    return ejecutarOperacionControlador(
      'crearAsistenciasEnLote',
      () => servicio.crearAsistenciasEnLote(
        session,
        asistencias: asistencias,
      ),
    );
  }

  /// La función `traerAsistenciaPorDia` recupera la asistencia de un día en particular.
  /// Args:
  /// session (Session): Un objeto de tipo "Session" que representa una conexión a una base de datos.
  /// idComision (int): Un número entero que representa el identificador único de la comisión.
  /// fecha (DateTime): Un objeto de tipo "DateTime" que representa la fecha de la asistencia.
  /// Returns:
  /// El método `traerAsistenciaPorDia` devuelve un `Futuro<List<AsistenciaDiaria>>`.
  Future<List<AsistenciaDiaria>> traerAsistenciaPorDia(
    Session session, {
    required DateTime fecha,
  }) async {
    return ejecutarOperacionControlador(
      'traerAsistenciaPorDia',
      () => servicio.traerAsistenciaPorDia(
        session,
        fecha: fecha,
      ),
    );
  }

  /// La función `actualizarAsistenciasEnLote` actualiza múltiples registros de asistencia diaria en un lote.
  /// Args:
  /// session (Session):
  /// asistencias (List<AsistenciaDiaria>): Una lista de objetos del tipo "AsistenciaDiaria".
  /// Returns:
  /// El método `actualizarAsistenciasEnLote` devuelve un `Futuro<String>`.
  Future<String> actualizarAsistenciasEnLote(
    Session session, {
    required List<AsistenciaDiaria> asistencias,
  }) async {
    return ejecutarOperacionControlador(
      'actualizarAsistenciasEnLote',
      () => servicio.actualizarAsistenciasEnLote(
        session,
        asistencias: asistencias,
      ),
    );
  }
}
