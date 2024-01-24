import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/servicio_calificacion.dart';
import 'package:serverpod/serverpod.dart';

class CalificacionEndpoint extends Endpoint with Controller {
  @override
  ServicioCalificacion get servicio => ServicioCalificacion();

  Future<List<Calificacion>> crearCalificacionesEnBloque(
    Session session, {
    required List<Calificacion> calificaciones,
  }) =>
      ejecutarOperacionControlador(
        session,
        'crearCalificacionesEnBloque',
        () => servicio.crearCalificacionesEnBloque(
          session,
          calificaciones: calificaciones,
        ),
      );

  Future<ConceptoCalificacion> crearConceptoDeCalificacion(
    Session session, {
    required String etiqueta,
  }) =>
      ejecutarOperacionControlador(
        session,
        'crearConceptoDeCalificacion',
        () => servicio.crearConceptoDeCalificacion(
          session,
          etiqueta: etiqueta,
        ),
      );

  Future<List<Calificacion>> obtenerCalificaciones(
    Session session,
    Periodo? periodo,
  ) async =>
      ejecutarOperacionControlador(
        session,
        'obtenerCalificaciones',
        () => servicio.obtenerCalificaciones(
          session,
          periodo,
        ),
      );

  Future<List<ConceptoCalificacion>> obtenerConceptosDeCalificacion(
          Session session) =>
      ejecutarOperacionControlador(
        session,
        'obtenerConceptosDeCalificacion',
        () => servicio.obtenerConceptosDeCalificacion(session),
      );

  Future<List<ComisionOverview>> obtenerInformacionDeVistaGeneralDeComisiones(
    Session session, {
    required int idUsuario,
    required int numeroDeMes,
  }) =>
      ejecutarOperacionControlador(
        session,
        'obtenerInformacionDeVistaGeneralDeComisiones',
        () => servicio.obtenerInformacionDeVistaGeneralDeComisiones(
          session,
          idUsuario: idUsuario,
          numeroDeMes: numeroDeMes,
        ),
      );

  /// El método `obtenerCalificacionesPorAsignaturaPorPeriodo` es una función que recupera una lista de
  /// calificaciones para una materia y periodo específico.
  Future<ModeloAVerDos> obtenerCalificacionesPorAsignaturaPorPeriodo(
    Session session, {
    required int idAsignatura,
    required Periodo periodo,
  }) =>
      ejecutarOperacionControlador(
        session,
        'obtenerCalificacionesPorAsignaturaPorPeriodo',
        () async => await servicio.obtenerCalificacionesPorAsignaturaPorPeriodo(
          session,
          idAsignatura: idAsignatura,
          periodo: periodo,
        ),
      );

  Future<void> cargarCalificacionesMensualesPorSolicitud(
    Session session, {
    required List<CalificacionMensual> calificacionesMensuales,
    required int idSolicitud,
  }) =>
      ejecutarOperacionControlador(
        session,
        'cargarCalificacionesMensuales',
        () async => await servicio.cargarCalificacionesMensualesPorSolicitud(
          session,
          calificacionesMensuales: calificacionesMensuales,
          idSolicitud: idSolicitud,
        ),
      );

  Future<List<CalificacionMensual>> obtenerCalificacionesMensuales(
    Session session, {
    int? numeroDeMes,
    required int idAsignatura,
    required int idComision,
  }) async =>
      ejecutarOperacionControlador(
        session,
        'obtenerCalificacionesMensuales',
        () async => await servicio.obtenerCalificacionesMensuales(
          session,
          numeroDeMes: numeroDeMes,
          idAsignatura: idAsignatura,
          idComision: idComision,
        ),
      );
}
