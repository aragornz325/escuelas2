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

  Future<Usuario> obtenerUsuario(
    Session session, {
    int? idUsuario,
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
          if (idUsuario != null) {
            return t.id.equals(idUsuario);
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
          comisiones: RelacionComisionUsuario.includeList(
            include: RelacionComisionUsuario.include(
                comision: ComisionDeCurso.include()),
          ),
          asignaturas: RelacionAsignaturaUsuario.includeList(
            include: RelacionAsignaturaUsuario.include(
              asignatura: Asignatura.include(),
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

  Future<List<Usuario>> obtenerUsuarios(Session session) async {
    return await ejecutarOperacionOrm(
      session,
      (session) async => await Usuario.db.find(
        session,
        include: Usuario.include(
          roles: RelacionUsuarioRol.includeList(
            include: RelacionUsuarioRol.include(
              rol: RolDeUsuario.include(),
            ),
          ),
          comisiones: RelacionComisionUsuario.includeList(
            include: RelacionComisionUsuario.include(
                comision: ComisionDeCurso.include()),
          ),
          asignaturas: RelacionAsignaturaUsuario.includeList(
            include: RelacionAsignaturaUsuario.include(
              asignatura: Asignatura.include(),
            ),
          ),
        ),
      ),
    );
  }
}
