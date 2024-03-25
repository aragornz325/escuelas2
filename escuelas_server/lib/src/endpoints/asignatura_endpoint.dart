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
      permisoRequerido: PermisoDeAsignatura.verAsignatura,
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
      permisoRequerido: PermisoDeAsignatura.verAsignatura,
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
      permisoRequerido: PermisoDeAsignatura.crearAsignatura,
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
      permisoRequerido: PermisoDeAsignatura.editarAsignatura,
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
        permisoRequerido: PermisoDeAsignatura.eliminarAsignatura,
      );

  /// las [Asignatura]s tienen un solo docente asignado (por el momento)
  /// {multiples asignaciones}(http://google.com/)
  /// ///TODO(chivo): soportar multiples asignaciones
  Future<bool> asignarDocenteAAsignatura(
    Session session, {
    required List<int> idsAsignaturas,
    required int idDocente,
    required int idComision,
  }) async =>
      ejecutarOperacionControlador(
        session,
        'asignarDocenteAAsignatura',
        () => servicio.asignarDocenteAAsignatura(
          session,
          idsAsignaturas: idsAsignaturas,
          idDocente: idDocente,
          idComision: idComision,
        ),
        permisoRequerido: PermisoDeAsignatura.asignarDocenteAAsignatura,
      );

  /// quita la relacion entre un [docente] y una [asignatura]
  Future<void> desasignarUsuarioAAsignatura(
    Session session, {
    required int idDocente,
    required int comisionId,
    required int asignaturaId,
  }) async =>
      ejecutarOperacionControlador(
        session,
        'desasignarUsuarioAAsignatura',
        () => servicio.desasignarUsuarioAAsignatura(
          session,
          idDocente: idDocente,
          comisionId: comisionId,
          asignaturaId: asignaturaId,
        ),
        permisoRequerido: PermisoDeAsignatura.asignarDocenteAAsignatura,
      );
}
