import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmRelacionHiloDeNotificacionesUsuario extends ORM {
  Future<List<RelacionHiloDeNotificacionesUsuario>> crearRelacionesHiloDeNotificacionesUsuario(
    Session session, {
    required List<RelacionHiloDeNotificacionesUsuario> relaciones,
  }) async {
    return await ejecutarOperacionOrm(
      session,
      (session) =>
        RelacionHiloDeNotificacionesUsuario.db.insert(
          session,
          relaciones,
        ),
    );
  }

  Future<RelacionHiloDeNotificacionesUsuario?> obtenerRelacion(
    Session session, {
    required int idHilo,
    required int idUsuario,
  }) async {
    final relacion = await ejecutarOperacionOrm(
      session,
      (session) async {
        return RelacionHiloDeNotificacionesUsuario.db.find(
          session,
          where: (t) =>
              t.hiloDeNotificacionesId.equals(idHilo) &
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
