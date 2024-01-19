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

  Future<Usuario> obtenerInfoBasicaUsuario(
    Session session, {
    required int idUserInfo,
  }) async {
    final usuario = await ejecutarOperacionOrm(
      session,
      (session) async => await Usuario.db.findFirstRow(session, where: (t) {
        return t.idUserInfo.equals(idUserInfo);
      }),
    );

    if (usuario == null) {
      throw ExcepcionCustom(
        titulo: 'Usuario no encontrado.',
        mensaje: 'Usuario no encontrado.',
        tipoDeError: TipoExcepcion.noEncontrado,
        codigoError: 404,
      );
    }

    final rolesQuery = await ejecutarOperacionOrm(
      session,
      (session) async => session.dbNext.unsafeQueryMappedResults(session, '''
        SELECT "roles"."id", "roles"."name", "roles"."permissions", "roles"."createdAt", "roles"."updatedAt"
        FROM "roles"
        INNER JOIN "user_role_relation" ON "roles"."id" = "user_role_relation"."roleId"
        WHERE "user_role_relation"."userId" = ${usuario.id}
       '''),
    );

    /// transforma la lista en un mapa con las keys con el nombre del rol y como value el permission
    final roles = rolesQuery.fold<Map<String, String>>(
      {},
      (previousValue, element) {
        final rol = element['roles']!;

        previousValue[rol['name']] = rol['permissions'];
        return previousValue;
      },
    );

    return usuario..roles = roles;
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

  Future<List<Usuario>> obtenerUsuarios(
    Session session, {
    int? idRol,
  }) async {
    return await ejecutarOperacionOrm(
      session,
      (session) async => await Usuario.db.find(
        session,
        where: (t) {
          if (idRol != null) {
            return Expression(
              '''
              "id" IN (
                SELECT "userId" FROM "user_role_relation" WHERE "roleId" = $idRol
              )''',
            );
          }

          return t.id.notEquals(null);
        },
        include: Usuario.include(
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
