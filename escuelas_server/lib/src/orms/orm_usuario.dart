import 'package:escuelas_server/src/extensiones/expresiones_en_columnas.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart';

class OrmUsuario extends ORM {
  Future<Usuario> crearUsuario(
    Session session, {
    required Usuario nuevoUsuario,
  }) async {
    final usuario = await ejecutarOperacionOrm(
      session,
      (session) async => await Usuario.db.insertRow(session, nuevoUsuario),
    );

    return usuario;
  }

  Future<Usuario> obtenerInfoBasicaUsuario(
    Session session, {
    required int idUserInfo,
  }) async {
    final usuario = await ejecutarOperacionOrm(
      session,
      (session) async => await Usuario.db.findFirstRow(
        session,
        where: (t) =>
            t.idUserInfo.equals(
              idUserInfo,
            ) &
            t.fechaEliminacion.equals(
              null,
            ),
      ),
    );

    if (usuario == null) {
      return Usuario(
        apellido: '',
        nombre: '',
        id: 0,
        idUserInfo: 0,
        roles: {},
        fechaCreacion: DateTime.now(),
        ultimaModificacion: DateTime.now(),
        urlFotoDePerfil: '',
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
        where: (t) =>
            t.id.contains(
              ids,
              Usuario.t.tableName,
            ) &
            t.fechaEliminacion.equals(
              null,
            ),
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
            return t.idUserInfo.equals(
                  idUserInfo,
                ) &
                t.fechaEliminacion.equals(
                  null,
                );
          }
          if (idUsuario != null) {
            return t.id.equals(
                  idUsuario,
                ) &
                t.fechaEliminacion.equals(
                  null,
                );
          }
          return t.id.notEquals(
                null,
              ) &
              t.fechaEliminacion.equals(
                null,
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

  /// La función `actualizarUsuario` actualiza un usuario en la base de datos y devuelve el usuario
  /// actualizado.
  ///
  /// Args:
  ///   session (Session):
  ///   usuario (Usuario): El parámetro `usuario` es de tipo `Usuario` y es obligatorio. Representa el
  /// objeto de usuario que debe actualizarse en la base de datos.

  Future<Usuario> actualizarUsuario(
    Session session, {
    required Usuario usuario,
  }) async {
    return await ejecutarOperacionOrm(
      session,
      (session) async {
        logger.info('Actualizando tabla usuario: $usuario');
        final usuarioActualizado = await Usuario.db.update(
          session,
          [usuario],
        ).then((value) => usuario);
        logger.info('tabla usuario actualizada con exito');

        return usuarioActualizado;
      },
    );
  }

  ///devuelve una lista de [Usuario]s dependiendo de los parametros que se le pasen
  Future<List<Usuario>> obtenerUsuarios(
    Session session, {
    int? idRol,
    String? nombre,
    String? apellido,
  }) async {
    return await ejecutarOperacionOrm(
      session,
      (session) async => await Usuario.db.find(
        session,
        where: (t) {
          Expression condicion = t.fechaEliminacion.equals(null);

          if (idRol != null) {
            condicion = condicion &
                Expression(
                  '''
            "id" IN (
              SELECT "userId" FROM "user_role_relation" WHERE "roleId" = $idRol
            )''',
                );
          }
          if (nombre != null) {
            condicion = condicion & t.nombre.equals(nombre);
          }
          if (apellido != null) {
            condicion = condicion & t.apellido.equals(apellido);
          }

          return condicion;
        },
        include: Usuario.include(
          comisiones: RelacionComisionUsuario.includeList(
            include: RelacionComisionUsuario.include(
              comision: ComisionDeCurso.include(),
            ),
          ),
          numerosDeTelefono: NumeroDeTelefono.includeList(
            include: NumeroDeTelefono.include(),
          ),
          direccionesDeEmail: DireccionDeEmail.includeList(
            include: DireccionDeEmail.include(),
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
    final usuarios = await RelacionAsignaturaUsuario.db.find(
      session,
      orderBy: (t) => t.usuarioId,
    );
    final ids = usuarios
        .map(
          (e) => e.usuarioId,
        )
        .toList();

    return ids;
  }
}
