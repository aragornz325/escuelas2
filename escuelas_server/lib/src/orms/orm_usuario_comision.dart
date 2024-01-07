import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmUsuarioComision extends ORM {
  Future<void> crearRelacionUsuarioAComision(
    Session session, {
    required int idComision,
    required int idUsuario,
  }) async {
    final ahora = DateTime.now();

    await ejecutarOperacionOrm(session, (session) {
      return RelacionComisionUsuario.db.insertRow(
        session,
        RelacionComisionUsuario(
          usuarioId: idUsuario,
          comisionDeCursoId: idComision,
          ultimaModificacion: ahora,
          fechaCreacion: ahora,
        ),
      );
    });
  }
}
