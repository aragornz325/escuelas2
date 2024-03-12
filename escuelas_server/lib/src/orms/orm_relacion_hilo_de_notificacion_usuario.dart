import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmRelacionHiloDeNotificacionesUsuario extends ORM {
  Future<bool> crearRelacion(
    Session session, {
    required RelacionHiloDeNotificacionesUsuario relacion,
    required int usuarioId,
  }) async {
    final ahora = DateTime.now();

    await ejecutarOperacionOrm(
      session,
      (session) async {
        await RelacionHiloDeNotificacionesUsuario.db.insert(
          session,
          [
            relacion..fechaCreacion = ahora,
          ],
        );
      },
    );
    return true;
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
              t.usuarioId.equals(idUsuario),
        );
      },
    );
    if (relacion.isEmpty) {
      return null;
    }
    return relacion.first;
  }
}
