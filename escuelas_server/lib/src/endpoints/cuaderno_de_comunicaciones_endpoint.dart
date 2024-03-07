import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/servicio_cuaderno_de_comunicaciones.dart';
import 'package:serverpod/serverpod.dart';

class CuadernoDeComunicacionesEndpoint extends Endpoint with Controller {
  @override
  ServicioCuadernoDeComunicaciones get servicio =>
      ServicioCuadernoDeComunicaciones();

  /// Crea la Notificaciones en la base de datos.
  Future<HiloDeNotificaciones> crearHiloDeNotificaciones(
    Session session, {
    required int idEstudiante,
    required String titulo,
    required String mensaje,
    required bool crearNuevaPlantilla,
    required bool necesitaSupervision,
  }) async =>
      await ejecutarOperacionControlador(
        session,
        'crearHiloDeNotificaciones',
        () => servicio.crearHiloDeNotificaciones(
          session,
          idEstudiante: idEstudiante,
          titulo: titulo,
          mensaje: mensaje,
          crearNuevaPlantilla: crearNuevaPlantilla,
          necesitaSupervision: necesitaSupervision,
        ),
      );

  /// Trae la lista de Notificaciones
  Future<List<HiloDeNotificaciones>> listarHilosDeNotificacionesPorUsuario(
    Session session, {
    required int idUsuario,
  }) async =>
      await ejecutarOperacionControlador(
        session,
        'listarHilosDeNotificacionesPorUsuario',
        () => servicio.listarHilosDeNotificacionesPorUsuario(
          session,
          idUsuario: idUsuario,
        ),
      );

  /// Elimina lista de Notificaciones
  Future<bool> eliminarHilosDeNotificaciones(
    Session session, {
    required List<int> idsHilosDeNotificaciones,
  }) async =>
      await ejecutarOperacionControlador(
        session,
        'eliminarHilosDeNotificaciones',
        () => servicio.eliminarHilosDeNotificaciones(
          session,
          idHiloDeNotificaciones: idsHilosDeNotificaciones,
        ),
      );

  // TODO (anyone): Definir mejor y terminar la lógica de marcar como leído (Hilos y comentarios en general y en particular).

  /// Crea un nuevo comentario de notificacion
  Future<ComentarioHiloDeNotificaciones>
      agregarComentarioEnHiloDeNotificaciones(
    Session session, {
    required int idHiloDeNotificaciones,
    required String comentario,
  }) async =>
          await ejecutarOperacionControlador(
            session,
            'agregarComentarioEnHiloDeNotificaciones',
            () => servicio.agregarComentarioEnHiloDeNotificaciones(
              session,
              idHiloDeNotificaciones: idHiloDeNotificaciones,
              comentario: comentario,
            ),
          );

  /// Elimina un comentario de notificacion.
  Future<bool> eliminarComentarioEnHiloDeNotificaciones(
    Session session, {
    required int idComentario,
  }) async =>
      await ejecutarOperacionControlador(
        session,
        'eliminarComentarioEnHiloDeNotificaciones',
        () => servicio.eliminarComentarioEnHiloDeNotificaciones(
          session,
          idComentario: idComentario,
        ),
      );
}
