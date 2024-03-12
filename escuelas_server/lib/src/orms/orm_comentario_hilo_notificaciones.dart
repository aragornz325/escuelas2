import 'package:escuelas_server/src/excepciones/excepcion_endpoint.dart';
import 'package:escuelas_server/src/extensiones/expresiones_en_columnas.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmComentariosHiloDeNotificaciones extends ORM {
  /// Crea un nuevo comentario de notificacion
  Future<ComentarioHiloDeNotificaciones> crearComentarioHiloDeNotificaciones(
    Session session, {
    required ComentarioHiloDeNotificaciones comentario,
  }) async {
    final nuevoComentario = await ejecutarOperacionOrm(
      session,
      (session) => ComentarioHiloDeNotificaciones.db.insertRow(
        session,
        comentario,
      ),
    );

    if (nuevoComentario.id == null) {
      throw ExcepcionCustom.fromJson(errorDesconocido, Protocol());
    }

    await session.dbNext.unsafeExecute('''
UPDATE ${ComentarioHiloDeNotificaciones.t.tableName} 
SET "_hilosDeNotificacionesComentariosHilosDeNotificacionesId" = ${nuevoComentario.idHiloDeNotificaciones}
WHERE ${ComentarioHiloDeNotificaciones.t.id.nombreCaseSensitive} = ${nuevoComentario.id};
''');

    return nuevoComentario;
  }

  /// Modificar comentario de notificacion
  Future<ComentarioHiloDeNotificaciones>
      modificarComentarioHiloDeNotificaciones(
    Session session, {
    List<Column<dynamic>> Function(ComentarioHiloDeNotificacionesTable)?
        columns,
    required ComentarioHiloDeNotificaciones comentario,
  }) async =>
          await ejecutarOperacionOrm(
            session,
            (session) {
              final ahora = DateTime.now();

              return ComentarioHiloDeNotificaciones.db.updateRow(
                session,
                comentario..ultimaModificacion = ahora,
                columns: columns,
              );
            },
          );

  /// Elimina un comentario de la notificacion.
  Future<bool> eliminarComentarioHiloDeNotificaciones(
    Session session, {
    required int idComentario,
  }) async {
    final ahora = DateTime.now();

    final comentario_ = await ejecutarOperacionOrm(
      session,
      (session) => modificarComentarioHiloDeNotificaciones(
        session,
        columns: (t) => [
          t.fechaEliminacion,
          t.ultimaModificacion,
        ],
        comentario: ComentarioHiloDeNotificaciones(
          id: idComentario,
          contenido: '',
          idHiloDeNotificaciones: 0,
          autorId: 0,
          fechaEliminacion: ahora,
          ultimaModificacion: ahora,
          fechaCreacion: ahora,
          relacionComentarioHiloDeNotificacionesUsuarioId: 0,
        ),
      ),
    );

    return comentario_.id != null;
  }
}
