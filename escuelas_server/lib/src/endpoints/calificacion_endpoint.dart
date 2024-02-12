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
  // ! Mejorar naming
  Future<CalificacionesMensuales>
      obtenerCalificacionesPorAsignaturaPorPeriodoPorComision(
    Session session, {
    required int idAsignatura,
    required int idComision,
    required int numeroDeAnio,
    required int numeroDeMes,
  }) =>
          ejecutarOperacionControlador(
            session,
            'obtenerCalificacionesPorAsignaturaPorPeriodoPorComision',
            () async => await servicio
                .obtenerCalificacionesPorAsignaturaPorPeriodoPorComision(
              session,
              idAsignatura: idAsignatura,
              numeroDeAnio: numeroDeAnio,
              numeroDeMes: numeroDeMes,
              idComision: idComision,
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

  Future<void> actualizarCalificacionesMensualesEnLote(
    Session session, {
    required List<CalificacionMensual> calificacionesMensuales,
  }) =>
      ejecutarOperacionControlador(
        session,
        'actualizarCalificacionesMensualesEnLote',
        () async => await servicio.actualizarCalificacionesMensualesEnLote(
          session,
          calificacionesMensuales: calificacionesMensuales,
        ),
      );

  Future<bool> enviarCalificacionesPorMesYAnio(
    Session session, {
    required EnvioCalificaciones filtroDeEnvio,
    required int mes,
    required int anio,
    List<int>? idCursos,
    List<int>? idComisiones,
    List<int>? idEstudiantes,
  }) async {
    return await ejecutarOperacionControlador(
      session,
      'enviarCalificacionesPorMesYAnio',
      () => servicio.enviarCalificacionesPorMesYAnio(
        session,
        filtroDeEnvio: filtroDeEnvio,
        mes: mes,
        anio: anio,
        idCursos: idCursos,
        idComisiones: idComisiones,
        idEstudiantes: idEstudiantes,
      ),
    );
  }
}
