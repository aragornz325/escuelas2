import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmAsignaturaSolicitada extends ORM {
  Future<List<AsignaturaSolicitada>> crearAsignaturasSolicitadas(
    Session session, {
    required List<AsignaturaSolicitada> asignaturasSolicitadas,
  }) async =>
      ejecutarOperacionOrm(
        session,
        (session) => AsignaturaSolicitada.db.insert(
          session,
          asignaturasSolicitadas,
        ),
      );

  Future<List<AsignaturaSolicitada>>
      obtenerAsignaturasSolicitadasPorIdUsuarioPendiente(
    Session session, {
    required int idUsuarioPendiente,
  }) async =>
          ejecutarOperacionOrm(
            session,
            (session) {
              return AsignaturaSolicitada.db.find(
                session,
                where: (t) => t.idUsuarioPendiente.equals(idUsuarioPendiente),
              );
            },
          );
}
