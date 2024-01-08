import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/servicio_calificacion.dart';
import 'package:serverpod/serverpod.dart';

class CalificacionEndpoint extends Endpoint with Controller {
  @override
  ServicioCalificacion get servicio => ServicioCalificacion();

  Future<List<Calificacion>> crearCalificacionesEnBloque(
    Session session, {
    required int idConcepto,
    required List<Calificacion> calificaciones,
  }) =>
      ejecutarOperacionControlador(
        'crearCalificacionesEnBloque',
        () => servicio.crearCalificacionesEnBloque(
          session,
          idConcepto: idConcepto,
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
    int? idConceptoDeCalificacion,
  ) async =>
      ejecutarOperacionControlador(
        'obtenerCalificaciones',
        () => servicio.obtenerCalificaciones(
          session,
          periodo,
          idConceptoDeCalificacion,
        ),
      );

  Future<List<ConceptoCalificacion>> obtenerConceptosDeCalificacion(
          Session session) =>
      ejecutarOperacionControlador(
        'obtenerConceptosDeCalificacion',
        () => servicio.obtenerConceptosDeCalificacion(session),
      );
}
