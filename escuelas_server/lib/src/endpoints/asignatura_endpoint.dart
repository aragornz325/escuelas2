import 'package:escuelas_server/controller.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/servicio_asignatura.dart';
import 'package:serverpod/server.dart';

class AsignaturaEndpoint extends Endpoint with Controller {
  @override
  ServicioAsignatura get servicio => ServicioAsignatura();

  @override
  bool get requireLogin => false;

  Future<Asignatura> obtenerAsignaturaPorId(
    Session session, {
    required int id,
  }) async {
    return servicio.otenerAsignaturaPorId(
      session,
      id: id,
    );
  }

  Future<List<Asignatura>> obtenerAsignaturas(
    Session session,
  ) async {
    return servicio.obtenerAsignaturas(session);
  }

  Future<Asignatura> crearAsignatura(
    Session session, {
    required Asignatura asignatura,
  }) async {
    return servicio.crearAsignatura(
      session,
      asignatura: asignatura,
    );
  }

  Future<Asignatura> actualizarAsignatura(
    Session session, {
    required Asignatura asignatura,
  }) async {
    return servicio.actualizarAsignatura(
      session,
      asignatura: asignatura,
    );
  }

  Future<int> eliminarAsignatura(
    Session session, {
    required int id,
  }) async {
    return servicio.eliminarAsignatura(
      session,
      id: id,
    );
  }
}
