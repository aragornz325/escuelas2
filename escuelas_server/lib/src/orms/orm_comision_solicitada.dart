import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmComisionSolicitada extends ORM {
  Future<ComisionSolicitada> crearComisionSolicitada(
    Session session, {
    required int idComision,
    required int idUsuarioPendiente,
  }) async {
    final ahora = DateTime.now();

    return await ejecutarOperacionOrm(session, (session) {
      return ComisionSolicitada.db.insertRow(
        session,
        ComisionSolicitada(
          comisionId: idComision,
          ultimaModificacion: ahora,
          fechaCreacion: ahora,
        ),
      );
    });
  }
}
