import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/servicio_asistencia.dart';
import 'package:serverpod/server.dart';

class AsistenciaEndpoint extends Endpoint with Controller<ServicioAsistencia> {
  @override
  ServicioAsistencia get servicio => ServicioAsistencia();

  @override
  bool get requireLogin => false;

  /// La función `crearAsistenciasEnBatch` crea un nuevo objeto `AsistenciaDiaria` en la base de datos usando la
  /// sesión proporcionada y devuelve el objeto creado.
  Future<String> crearAsistenciasEnLote(
    Session session, {
    required List<AsistenciaDiaria> asistencias,
  }) async {
    return ejecutarOperacionControlador(
      'crearAsistenciaEnBatch',
      () => servicio.crearAsistenciasEnLote(
        session,
        asistencias: asistencias,
      ),
    );
  }
}
