import 'package:escuelas_commons/escuelas_commons.dart';
import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/servicio_asignatura.dart';
import 'package:serverpod/server.dart';

class AsignaturaEndpoint extends Endpoint with Controller {
  @override
  ServicioAsignatura get servicio => ServicioAsignatura();

  @override
  bool get requireLogin => false;

  /// La función `obtenerAsignaturaPorId` recupera un objeto `Asignatura` por su ID usando una `Session`
  Future<Asignatura> obtenerAsignaturaPorId(
    Session session, {
    required int id,
  }) async {
    return ejecutarOperacionControlador(
      session,
      'obtenerAsignaturaPorId',
      () => servicio.obtenerAsignaturaPorId(
        session,
        id: id,
      ),
     
    );
  }

  /// La función "obtenerAsignaturas" recupera una lista de asignaturas utilizando un objeto de sesión.
  Future<List<Asignatura>> obtenerAsignaturas(
    Session session,
  ) async {
    return ejecutarOperacionControlador(
      session,
      'obtenerAsignaturas',
      () => servicio.obtenerAsignaturas(session),
    );
  }

  /// La función `crearAsignatura` crea un nuevo objeto `Asignatura` en la base de datos usando la
  /// sesión proporcionada y devuelve el objeto creado.
  Future<Asignatura> crearAsignatura(
    Session session, {
    required Asignatura asignatura,
  }) async {
    return ejecutarOperacionControlador(
      session,
      'crearAsignatura',
      () => servicio.crearAsignatura(
        session,
        asignatura: asignatura,
      ),
    );
  }

  /// La función `actualizarAsignatura` actualiza un objeto `Asignatura` en una base de datos usando un
  /// objeto `Session` proporcionado.
  Future<Asignatura> actualizarAsignatura(
    Session session, {
    required Asignatura asignatura,
  }) async {
    return ejecutarOperacionControlador(
      session,
      'actualizarAsignatura',
      () => servicio.actualizarAsignatura(
        session,
        asignatura: asignatura,
      ),
      permisoRequerido: PermisoDeAsistencia.editarAsistencia,
    );
  }

  /// La función `eliminarAsignatura` elimina un objeto `Asignatura` de una base de datos utilizando una
  /// `Session` proporcionada.
  Future<int> eliminarAsignatura(
    Session session, {
    required int id,
  }) async =>
      ejecutarOperacionControlador(
        session,
        'eliminarAsignatura',
        () => servicio.eliminarAsignatura(
          session,
          id: id,
        ),
        permisoRequerido: PermisoDeAsistencia.eliminarAsistencia,
      );
}
