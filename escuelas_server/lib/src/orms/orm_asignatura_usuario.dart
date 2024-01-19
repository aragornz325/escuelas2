import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmRelacionAsignaturaUsuario extends ORM {
  Future<void> crearRelacionUsuarioAAsignaturas(
    Session session, {
    required List<AsignaturaSolicitada> asignaturasSolicitadas,
    required int usuarioId,
  }) async {
    final ahora = DateTime.now();

    await ejecutarOperacionOrm(
      session,
      (session) async {
        await RelacionAsignaturaUsuario.db.insert(
          session,
          [
            ...asignaturasSolicitadas.map(
              (asignatura) => RelacionAsignaturaUsuario(
                asignaturaId: asignatura.asignaturaId,
                usuarioId: usuarioId,
                ultimaModificacion: ahora,
                fechaCreacion: ahora,
                idComision: asignatura.idComision,
              ),
            ),
          ],
        );
      },
    );
  }

  // Future<List<RelacionAsignaturaUsuario>> obtenerRelacionesAsignaturaUsuario(Session session) async {
  //   return RelacionAsignaturaUsuario.db.find(session, where: (t) );
  // }
}
