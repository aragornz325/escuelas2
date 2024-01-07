import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmRelacionUsuarioRol extends ORM {
  Future<List<RelacionUsuarioRol>> obtenerRelacionesUsuarioRol(
    Session session, {
    int? idRol,
    int? idUsuario,
    OrdenarPor ordenarUsuariosPor = OrdenarPor.apellido,
  }) async {
    return await RelacionUsuarioRol.db.find(
      session,
      where: (t) {
        if (idRol != null && idUsuario != null) {
          return (t.rolId.equals(idRol) & t.usuarioId.equals(idUsuario));
        }
        if (idRol == null && idUsuario != null) {
          return t.usuarioId.equals(idUsuario);
        }
        if (idRol != null && idUsuario == null) {
          return t.rolId.equals(idRol);
        }
        return t.id.notEquals(null);
      },
      orderBy: (t) {
        switch (ordenarUsuariosPor) {
          case OrdenarPor.apellido:
            return t.usuario.apellido;
          case OrdenarPor.asignatura:
            return t.usuario.apellido;
          case OrdenarPor.curso:
            return t.usuario.apellido;
          default:
            return t.usuario.apellido;
        }
      },
      include: RelacionUsuarioRol.include(
        usuario: Usuario.include(
          domicilio: DomicilioDeUsuario.include(),
          direccionesDeEmail: DireccionDeEmail.includeList(),
          numerosDeTelefono: NumeroDeTelefono.includeList(),
        ),
      ),
    );
  }
}
