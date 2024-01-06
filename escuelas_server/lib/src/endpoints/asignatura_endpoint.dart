import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/servicio_asignatura.dart';
import 'package:serverpod/server.dart';

class AsignaturaEndpoint extends Endpoint with Controller {
  @override
  ServicioAsignatura get servicio => ServicioAsignatura();

  @override
  bool get requireLogin => false;

  /// La función `otenerAsignaturaPorId` recupera un objeto `Asignatura` por su ID usando una `Session`
  Future<Asignatura> obtenerAsignaturaPorId(
    Session session, {
    required int id,
  }) async {
    return servicio.otenerAsignaturaPorId(
      session,
      id: id,
    );
  }

  /// La función "obtenerAsignaturas" recupera una lista de asignaturas utilizando un objeto de sesión.
  Future<List<Asignatura>> obtenerAsignaturas(
    Session session,
  ) async {
    return servicio.obtenerAsignaturas(session);
  }

  /// La función `crearAsignatura` crea un nuevo objeto `Asignatura` en la base de datos usando la
  /// sesión proporcionada y devuelve el objeto creado.
  Future<Asignatura> crearAsignatura(
    Session session, {
    required Asignatura asignatura,
  }) async {
    return servicio.crearAsignatura(
      session,
      asignatura: asignatura,
    );
  }

  /// La función `actualizarAsignatura` actualiza un objeto `Asignatura` en una base de datos usando un
  /// objeto `Session` proporcionado.
  Future<Asignatura> actualizarAsignatura(
    Session session, {
    required Asignatura asignatura,
  }) async {
    return servicio.actualizarAsignatura(
      session,
      asignatura: asignatura,
    );
  }

  /// La función `eliminarAsignatura` elimina un objeto `Asignatura` de una base de datos utilizando una
  /// `Session` proporcionada.
  Future<int> eliminarAsignatura(
    Session session, {
    required int id,
  }) async {
    return servicio.eliminarAsignatura(
      session,
      id: id,
    );
  }

  Future<void> relacionUsuarioAAsignaturas(
    Session session, {
    required List<Asignatura> asignaturas,
    required int idUsuario,
  }) async =>
      ejecutarOperacionControlador(
        'relacionUsuarioAAsignaturas',
        () => servicio.relacionarUsuarioAAsignaturas(
          session,
          asignaturas: asignaturas,
          usuarioId: idUsuario,
        ),
      );
}
