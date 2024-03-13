import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class OrmRelacionComentarioHiloDeNotificacionesUsuario extends ORM {
  Future<RelacionComentarioHiloDeNotificacionesUsuario> crearRelacion(
    Session session, {
    required RelacionComentarioHiloDeNotificacionesUsuario relacion,
  }) async {
    final ahora = DateTime.now();

    final nuevaRelacion = await ejecutarOperacionOrm(
      session,
      (session) async {
        await RelacionComentarioHiloDeNotificacionesUsuario.db.insert(
          session,
          [
            relacion..fechaCreacion = ahora,
          ],
        );
      },
    );

    return nuevaRelacion;
  }

  Future<RelacionComentarioHiloDeNotificacionesUsuario?> obtenerRelacion(
    Session session, {
    required int idComentario,
    required int idUsuario,
  }) async {
    final relacion = await ejecutarOperacionOrm(
      session,
      (session) async {
        return RelacionComentarioHiloDeNotificacionesUsuario.db.find(
          session,
          where: (t) =>
              t.comentarioId.equals(idComentario) &
              t.idUsuario.equals(idUsuario),
        );
      },
    );
    if (relacion.isEmpty) {
      return null;
    }
    return relacion.first;
  }
}
