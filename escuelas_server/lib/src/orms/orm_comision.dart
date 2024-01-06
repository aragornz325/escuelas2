import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmComision extends ORM {
  Future<void> asignarUsuarioAComision(
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

  Future<void> crearComisionSolicitada(
    Session session, {
    required int idComision,
    required int idUsuarioPendiente,
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

  Future<List<ComisionDeCurso>> obtenerComisiones(Session session) async =>
      ejecutarOperacionOrm(
        session,
        (session) => ComisionDeCurso.db.find(session),
      );
}
