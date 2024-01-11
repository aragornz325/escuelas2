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
        'obtenerCalificaciones',
        () => servicio.obtenerCalificaciones(
          session,
          periodo,
        ),
      );

  Future<List<ConceptoCalificacion>> obtenerConceptosDeCalificacion(
          Session session) =>
      ejecutarOperacionControlador(
        'obtenerConceptosDeCalificacion',
        () => servicio.obtenerConceptosDeCalificacion(session),
      );

  Future<List<ComisionOverview>> obtenerInformacionDeVistaGeneralDeComisiones(
    Session session, {
    required int idUsuario,
    required int numeroDeMes,
  }) =>
      ejecutarOperacionControlador(
        'obtenerInformacionDeVistaGeneralDeComisiones',
        () => servicio.obtenerInformacionDeVistaGeneralDeComisiones(
          session,
          idUsuario: idUsuario,
          numeroDeMes: numeroDeMes,
        ),
      );
}
