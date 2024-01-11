import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmUsuarioComision extends ORM {
  Future<void> crearRelacionUsuarioAComision(
    Session session, {
    required int idComision,
    required int idUsuario,
  }) async =>
      ejecutarOperacionOrm(session, (session) {
        return RelacionComisionUsuario.db.insertRow(
          session,
          RelacionComisionUsuario(
            usuarioId: idUsuario,
            comisionId: idComision,
          ),
        );
      });

  Future<List<RelacionComisionUsuario>> obtenerRelacionesComisionUsuario(
    Session session, {
    int? idComision,
    int? idUsuario,
  }) async {
    return await ejecutarOperacionOrm(
      session,
      (session) => RelacionComisionUsuario.db.find(
        session,
        where: (t) {
          if (idComision != null && idUsuario != null) {
            return t.comisionId.equals(idComision) &
                t.usuarioId.equals(idUsuario);
          }
          if (idComision != null && idUsuario == null) {
            return t.comisionId.equals(idComision);
          }
          if (idComision == null && idUsuario != null) {
            return t.usuarioId.equals(idUsuario);
          }
          return t.id.notEquals(null);
        },
        include: RelacionComisionUsuario.include(
          usuario: Usuario.include(),
        ),
      ),
    );
  }
}
