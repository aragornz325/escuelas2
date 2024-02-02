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
        ),
      );

  Future<List<ComisionDeCurso>> obtenerComisiones(Session session) async =>
      ejecutarOperacionControlador(
        session,
        'obtenerComisiones',
        () => servicio.obtenerComisiones(session),
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
        ),
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
            ),
          );
}
