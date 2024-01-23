import 'package:escuelas_server/src/extensiones/expresiones_en_columnas.dart';
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

  /// La función `obtenerUsuariosEnLote` recupera una lista de usuarios con ID específicas, incluidas
  /// sus direcciones de correo electrónico asociadas, direcciones, números de teléfono, comisiones y
  /// asuntos.
  ///
  /// Args:
  ///   session (Session): Un objeto de sesión utilizado para operaciones de bases de datos.
  ///   ids (List<int>): Una lista de números enteros que representan los ID de los usuarios que se van
  /// a recuperar.
  ///
  /// Returns:
  ///   un `Futuro` que se resuelve en una `Lista` de objetos `Usuario`.
  Future<List<Usuario>> obtenerUsuariosEnLote(
    Session session, {
    required List<int> ids,
  }) async {
    return await ejecutarOperacionOrm(
      session,
      (session) async => await Usuario.db.find(
        session,
        where: (t) {
          return t.id.contains(ids, 'usuarios');
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

  /// La función `obtenerUsuariosConAsignaturas` recupera una lista de ID de usuarios asociados con
  /// asignaciones.
  Future<List<int>> obtenerUsuariosConAsignaturas(
    Session session,
  ) async {
    final resultados = await session.dbNext.unsafeQueryMappedResults(
      session,
      '''SELECT DISTINCT "usuarioId"
FROM r_asignaturas_usuarios;
''',
    );
    final usuarios = resultados.map((
      resultado,
    ) {
      final usuarioId = resultado['r_asignaturas_usuarios']?['usuarioId'];
      if (usuarioId == null) {
        throw Exception(
          'usuarioId es null para el resultado: $resultado',
        );
      }
      return usuarioId as int;
    }).toList();

    return usuarios;
  }
}
