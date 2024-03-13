import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmHiloDeNotificaciones extends ORM<HiloDeNotificaciones> {
  /// Crea la notificacion en la base de datos.
  Future<HiloDeNotificaciones> crearHiloDeNotificaciones(
    Session session, {
    required HiloDeNotificaciones hiloDeNotificaciones,
  }) async =>
      ejecutarOperacionOrm(
        session,
        (session) => HiloDeNotificaciones.db.insertRow(
          session,
          hiloDeNotificaciones,
        ),
      );

  /// Modificar notificacion
  Future<HiloDeNotificaciones> modificarHiloDeNotificaciones(
    Session session, {
    List<Column<dynamic>> Function(HiloDeNotificacionesTable)? columns,
    required HiloDeNotificaciones hiloDeNotificaciones,
  }) async {
    return await ejecutarOperacionOrm(
      session,
      (session) {
        final ahora = DateTime.now();

        return HiloDeNotificaciones.db.updateRow(
          session,
          hiloDeNotificaciones..ultimaModificacion = ahora,
          columns: columns,
        );
      },
    );
  }

  /// trae la lista de notificaciones
  Future<List<HiloDeNotificaciones>> listarHilosDeNotificaciones(
    Session session, {
    required int idUsuario,
  }) async =>
      await ejecutarOperacionOrm(
        session,
        (session) => HiloDeNotificaciones.db.find(
          session,
          where: (t) =>
              t.fechaEliminacion.equals(null) &
              t.estudianteId.equals(idUsuario),
          include: HiloDeNotificaciones.include(
            estudiante: Usuario.include(),
            participantes: RelacionHiloDeNotificacionesUsuario.includeList(
              include: RelacionHiloDeNotificacionesUsuario.include(),
            ),
            comentarios: ComentarioHiloDeNotificaciones.includeList(
              where: (t) => t.fechaEliminacion.equals(null),
              include: ComentarioHiloDeNotificaciones.include(
                autor: Usuario.include(),
                destinatarios:
                    RelacionComentarioHiloDeNotificacionesUsuario.includeList(
                  include: RelacionComentarioHiloDeNotificacionesUsuario.include(comentario: ComentarioHiloDeNotificaciones.include()),
                ),
              ),
            ),
          ),
        ),
      );

  /// Actualiza lista de notificaciones
  Future<List<HiloDeNotificaciones>> marcarTodaslosHiloDeNotificacionesLeidas(
      Session session,
      {required List<HiloDeNotificaciones> hiloDeNotificaciones,
      required int idUsuario}) async {
    final ahora = DateTime.now();

    hiloDeNotificaciones.forEach(
      (hilo) async {
        await ejecutarOperacionOrm(
          session,
          (session) => RelacionComentarioHiloDeNotificacionesUsuario.db.update(
            session,
            hilo.comentarios == null
                ? hilo.comentarios!
                    .map((e) => e.destinatarios!.firstWhere((element) => element.idUsuario == idUsuario)
                      ..fechaDeLectura = ahora)
                    .toList()
                : <RelacionComentarioHiloDeNotificacionesUsuario>[],
          ),
        );
      },
    );

    return [];
  }

  /// Actualiza lista de notificaciones
  Future<List<HiloDeNotificaciones>> actualizarListaHiloDeNotificaciones(
    Session session, {
    required List<HiloDeNotificaciones> hiloDeNotificaciones,
    List<Column<dynamic>> Function(HiloDeNotificacionesTable)? columnas,
  }) async {
    final ahora = DateTime.now();

    return await ejecutarOperacionOrm(
      session,
      (session) => HiloDeNotificaciones.db.update(
        session,
        hiloDeNotificaciones.map((e) => e..ultimaModificacion = ahora).toList(),
        columns: columnas,
      ),
    );
  }

  /// Elimina lista de notificaciones
  Future<bool> eliminarHilosDeNotificaciones(
    Session session, {
    required List<int> idHiloDeNotificaciones,
  }) async {
    final ahora = DateTime.now();

    final notificacion_ = await ejecutarOperacionOrm(
        session,
        (session) => actualizarListaHiloDeNotificaciones(
              session,
              columnas: (t) => [
                t.fechaEliminacion,
                t.ultimaModificacion,
              ],
              hiloDeNotificaciones: idHiloDeNotificaciones.map((e) {
                return HiloDeNotificaciones(
                  id: e,
                  necesitaSupervision: false,
                  fechaEliminacion: ahora,
                  ultimaModificacion: ahora,
                  comentarios: [],
                  estudianteId: 0,
                  fechaCreacion: ahora,
                  titulo: '',
                );
              }).toList(),
            ));

    return notificacion_.length == idHiloDeNotificaciones.length;
  }
}
