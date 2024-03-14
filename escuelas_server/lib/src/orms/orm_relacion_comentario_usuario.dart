import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class OrmRelacionComentarioHiloDeNotificacionesUsuario extends ORM {
  Future<void> crearRelacionesComentarioHiloDeNotificacionesUsuario(
    Session session, {
    required List<RelacionComentarioHiloDeNotificacionesUsuario> relaciones,
  }) async {
    await ejecutarOperacionOrm(
      session,
      (session) async {
        await RelacionComentarioHiloDeNotificacionesUsuario.db.insert(
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
}
