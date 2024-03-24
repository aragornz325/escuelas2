import 'package:escuelas_commons/escuelas_commons.dart';
import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/servicio_comision.dart';
import 'package:serverpod/serverpod.dart';

class ComisionEndpoint extends Endpoint with Controller<ServicioComision> {
  @override
  ServicioComision get servicio => ServicioComision();
  Future<void> asignarUsuarioAComision(
    Session session, {
    required int idComision,
    required int idUsuario,
  }) async =>
      ejecutarOperacionControlador(
        session,
        'asignarUsuarioAComision',
        () => servicio.asignarUsuarioAComision(
          session,
          idComision: idComision,
          idUsuario: idUsuario,
        ),permisoRequerido: PermisoDeComision.asignarAlumnosAComision,
      );

  Future<List<ComisionDeCurso>> obtenerComisiones(Session session) async =>
      ejecutarOperacionControlador(
        session,
        'obtenerComisiones',
        () => servicio.obtenerComisiones(session),permisoRequerido: PermisoDeComision.verComision,
      );

  Future<List<ComisionConAsignaturas>> listarComisionesConAsignaturas(
    Session session,
  ) async =>
      ejecutarOperacionControlador(
        session,
        'listarComisionesConAsignaturas',
        () => servicio.listarComisionesConAsignaturas(
          session,
        ),permisoRequerido: PermisoDeComision.verComision,
      );

  Future<ComisionDeCurso> obtenerComisionesDeCursoPorId(
    Session session, {
    required int idComision,
  }) async =>
      ejecutarOperacionControlador(
        session,
        'obtenerComisionesDeCursoPorId',
        () => servicio.obtenerComisionesDeCursoPorId(
          session,
          idComision: idComision,
        ),permisoRequerido: PermisoDeComision.verComision,
      );

  /// Obtiene las comisiones que tienen solicitudes de calificación mensual
  /// en el mes y año especificados.
  ///
  /// [SupervisionDeCurso] es un modelo que contiene la comisión y la fecha en la
  /// que se le notifico a los estudiantes/padres de familia de sus calificaciones
  /// del mes y año especificados.
  Future<List<SupervisionDeCurso>>
      obtenerComisionesConSolicitudesCalificacionMensual(
    Session session, {
    required int mes,
    required int anio,
  }) async =>
          ejecutarOperacionControlador(
            session,
            'obtenerComisionesConSolicitudesCalificacionMensual',
            () => servicio.obtenerComisionesConSolicitudesCalificacionMensual(
              session,
              mes: mes,
              anio: anio,
            ),permisoRequerido: PermisoDeComision.verComision,
          );

  Future<bool> cambiarUsuarioDeComision(
    Session session,
    int idComision,
    int idUsuario,
  ) async =>
      ejecutarOperacionControlador(
        session,
        'cambiarUsuarioDeComision',
        () => servicio.cambiarUsuarioDeComision(
          session,
          idComision: idComision,
          idUsuario: idUsuario,
        ),permisoRequerido: PermisoDeComision.asignarAlumnosAComision,
      );

  /// Obtiene una lista de las asignaturas dentro de una comisión, junto al nombre del docente,
  /// y la fecha en que las calificaciones del mes y el año indicados fueron cargadas.
  Future<List<EstadoCalificacionesAsignatura>>
      obtenerEstadoDeEnvioDeCalificacionesPorComisionPorMes(
    Session session, {
    required int idComision,
    required int mes,
    required int anio,
  }) async {
    return await ejecutarOperacionControlador(
      session,
      'obtenerEstadoDeEnvioDeCalificacionesPorComisionPorMes',
      () => servicio.obtenerEstadoDeEnvioDeCalificacionesPorComisionPorMes(
        session,
        idComision: idComision,
        mes: mes,
        anio: anio,
      ),permisoRequerido: PermisoDeComision.verComision,
    );
  }
}
