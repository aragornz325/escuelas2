import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class OrmRelacionComentarioHiloDeNotificacionesUsuario extends ORM {
  Future<List<RelacionComentarioHiloDeNotificacionesUsuario>>
      crearRelacionesComentarioHiloDeNotificacionesUsuario(
    Session session, {
    required List<RelacionComentarioHiloDeNotificacionesUsuario> relaciones,
  }) async {
    return await ejecutarOperacionOrm(
      session,
      (session) async {
        return await RelacionComentarioHiloDeNotificacionesUsuario.db.insert(
          session,
          relaciones,
        );
      },
    );
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

  Future<RelacionComentarioHiloDeNotificacionesUsuario?>
      modificarRelacionComentarioHiloDeNotificacionesUsuario(
    Session session, {
    required RelacionComentarioHiloDeNotificacionesUsuario
        relacionesComentarioHiloDeNotificacionesUsuario,
  }) async {
    final relacion = await ejecutarOperacionOrm(
      session,
      (session) async {
        return RelacionComentarioHiloDeNotificacionesUsuario.db.updateRow(
          session,
          relacionesComentarioHiloDeNotificacionesUsuario,
        );
      },
    );
    // if (relacion) {
    //   return null;
    // }
    return relacion;
  }
}
