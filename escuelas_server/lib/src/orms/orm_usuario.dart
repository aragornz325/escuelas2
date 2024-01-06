import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmUsuario extends ORM {
  Future<Usuario> crearUsuario(
    Session session, {
    required Usuario nuevoUsuario,
  }) async {
    return await ejecutarOperacionOrm(
      session,
      (session) async => await Usuario.db.insertRow(session, nuevoUsuario),
    );
  }

  Future<Usuario> buscarUsuario(
    Session session, {
    int? idUserInfo,
  }) async {
    final usuario = await ejecutarOperacionOrm(
      session,
      (session) async => await Usuario.db.findFirstRow(
        session,
        where: (t) {
          if (idUserInfo != null) {
            return t.idUserInfo.equals(idUserInfo);
          }
          return t.id.notEquals(null);
        },
        include: Usuario.include(
          direccionesDeEmail: DireccionDeEmail.includeList(
            include: DireccionDeEmail.include(),
          ),
          domicilio: DomicilioDeUsuario.include(),
          numerosDeTelefono: NumeroDeTelefono.includeList(),
          roles: RelacionUsuarioRol.includeList(
            include: RelacionUsuarioRol.include(
              rol: RolDeUsuario.include(),
            ),
          ),
        ),
      ),
    );

    if (usuario == null) {
      throw ExcepcionCustom(
        titulo: 'Usuario no encontrado.',
        mensaje: 'Usuario no encontrado.',
        tipoDeError: TipoExcepcion.noEncontrado,
        codigoError: 404,
      );
    }

    return usuario;
  }

  Future<Usuario> actualizarUsuario(
    Session session, {
    required Usuario usuario,
  }) async {
    return await ejecutarOperacionOrm(
      session,
      (session) async => await Usuario.db.updateRow(session, usuario),
    );
  }
}
