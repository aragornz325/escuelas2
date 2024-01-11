import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmComisionSolicitada extends ORM {
  Future<void> crearComisionSolicitada(
    Session session, {
    required int idComision,
    required int idUsuarioPendiente,
    required String nombreComision,
  }) async {
    final ahora = DateTime.now();

    await ejecutarOperacionOrm(session, (session) {
      return ComisionSolicitada.db.insertRow(
        session,
        ComisionSolicitada(
          idComision: idComision,
          idUsuarioPendiente: idUsuarioPendiente,
          ultimaModificacion: ahora,
          fechaCreacion: ahora,
        ),
      );
    });
  }
}
