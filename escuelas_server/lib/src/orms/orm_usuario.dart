import 'package:escuelas_server/src/extensiones/expresiones_en_columnas.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart';

class OrmUsuario extends ORM {
  Future<Usuario> crearUsuario(Session session,
      {required Usuario nuevoUsuario,
      required DireccionDeEmail direccionDeMail}) async {
    final usuario = await ejecutarOperacionOrm(
      session,
      (session) async => await Usuario.db.insertRow(session, nuevoUsuario),
    );

    await ejecutarOperacionOrm(
      session,
      (session) => DireccionDeEmail.db.insert(
        session,
        [direccionDeMail],
      ),
    );

    return usuario;
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

    final roles = await _obtenerRolesDeUsuario(session, usuario);

    return usuario..roles = roles;
  }

  /// La función `obtenerUsuariosEnLote` recupera una lista de usuarios con ID específicas, incluidas
  /// sus direcciones de correo electrónico asociadas, direcciones, números de teléfono, comisiones y
  /// asuntos.
  ///
  /// Args:
  ///   session (Session): Un objeto de sesión utilizado para operaciones de bases de datos.
  ///   ids (List<int>): Una lista de números enteros que representan los ID de los usuarios que se van
  /// a recuperar.
  Future<List<Usuario>> obtenerUsuariosEnLote(
    Session session, {
    required List<int> ids,
  }) async {
    return await ejecutarOperacionOrm(
      session,
      (session) async => await Usuario.db.find(
        session,
        where: (t) {
          return t.id.contains(
            ids,
            Usuario.t.tableName,
          );
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
              comision: ComisionDeCurso.include(),
            ),
          ),
        ),
      ),
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
          comisiones: RelacionComisionUsuario.includeList(
            include: RelacionComisionUsuario.include(
              comision: ComisionDeCurso.include(),
            ),
          ),
          asignaturas: RelacionAsignaturaUsuario.includeList(
            include: RelacionAsignaturaUsuario.include(
              asignatura: Asignatura.include(),
              comision: ComisionDeCurso.include(),
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

    final roles = await _obtenerRolesDeUsuario(session, usuario);

    return usuario..roles = roles;
  }

  // ? En algun momento debería cambiar el lugar donde se obtienen los roles de un usuario
  /// Obtiene los roles de un usuario y devuelve un mapa con el nombre del rol
  /// como key y el permission como value
  Future<Map<String, String>> _obtenerRolesDeUsuario(
      Session session, Usuario usuario) async {
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

    return roles;
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
              comision: ComisionDeCurso.include(),
            ),
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

  Future<List<int>> obtenerIdsDeUsuariosDocentes(
    Session session,
  ) async {
    final usuarios = await RelacionAsignaturaUsuario.db
        .find(session, orderBy: (t) => t.usuarioId);
    final ids = usuarios.map((e) => e.usuarioId).toList();

    return ids;
  }
}
