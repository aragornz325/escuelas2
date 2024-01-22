import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmUsuarioPendiente extends ORM {
  /// La función `crearUsuarioPendiente` crea un nuevo usuario pendiente en una base de datos y devuelve
  /// el usuario insertado.
  ///
  /// Args:
  ///   session (Session): El parámetro de sesión es de tipo Sesión  y es obligatorio.
  ///   usuarioPendiente (UsuarioPendiente): El parámetro "UserPending" es de tipo "UserPending" y es
  /// obligatorio.
  ///
  /// Returns:
  ///   a `Future<UsuarioPendiente>`.
  Future<UsuarioPendiente> crearUsuarioPendiente(
    Session session, {
    required UsuarioPendiente usuarioPendiente,
  }) async {
    return await UsuarioPendiente.db.insert(session, [usuarioPendiente]).then(
      (rows) {
        return rows.first;
      },
    );
  }

  /// La función obtiene el primer usuario pendiente de la base de datos y lanza una excepción si no hay
  /// usuarios pendientes.
  ///
  /// Args:
  ///   session (Session): Un objeto de sesión que representa la sesión del usuario actual.
  ///
  /// Returns:
  ///   La función `obtenerUsuarioPendiente` devuelve un `Futuro` que se resuelve en una instancia de
  /// `UsuarioPendiente` o `null`.
  Future<UsuarioPendiente?> obtenerUsuarioPendiente(
    Session session, {
    int? idUsuarioPendiente,
    int? idUserInfo,
  }) async {
    final usuarioPendiente = await UsuarioPendiente.db.findFirstRow(
      session,
      where: (t) {
        if (idUserInfo != null) {
          return t.idUserInfo.equals(idUserInfo);
        }
        if (idUsuarioPendiente != null) {
          return t.id.equals(idUsuarioPendiente);
        }
        return t.id.notEquals(null);
      },
    );

    final asignaturasSolicitadas = await AsignaturaSolicitada.db.find(
      session,
      where: (t) => t.idUsuarioPendiente.equals(usuarioPendiente?.id),
      include: AsignaturaSolicitada.include(
        asignatura: Asignatura.include(),
        comision: ComisionDeCurso.include(),
      ),
    );

    usuarioPendiente?.asignaturasSolicitadas = asignaturasSolicitadas;

    return usuarioPendiente;
  }

  /// La función obtiene la lista de usuarios pendientes de la base de datos.
  ///
  /// Args:
  ///   session (Session): Un objeto de sesión que representa la sesión del usuario actual.
  Future<List<UsuarioPendiente>> obtenerUsuariosPendientes(
      Session session) async {
    final usuarioPendientes = await UsuarioPendiente.db.find(
      session,
      where: (t) => t.estadoDeSolicitud.equals(
        EstadoDeSolicitud.pendiente,
      ),
      include: UsuarioPendiente.include(
        asignaturasSolicitadas: AsignaturaSolicitada.includeList(
          include: AsignaturaSolicitada.include(
            asignatura: Asignatura.include(),
            comision: ComisionDeCurso.include(),
          ),
        ),
        comisionSolicitada: ComisionDeCurso.include(),
      ),
    );

    return usuarioPendientes;
  }

  /// La función `actualizarUsuarioPendiente` actualiza un usuario pendiente.
  Future<void> actualizarUsuarioPendiente(
    Session session, {
    required UsuarioPendiente usuarioPendiente,
  }) async =>
      ejecutarOperacionOrm(
        session,
        (session) => UsuarioPendiente.db.updateRow(
          session,
          usuarioPendiente,
          columns: (t) => [
            t.nombre,
            t.apellido,
            t.dni,
            t.idRolSolicitado,
            t.estadoDeSolicitud,
            t.ultimaModificacion,
            t.comisionSolicitadaId,
          ],
        ),
      );

  Future<void> eliminarUsuarioPendiente(
    Session session, {
    required int id,
  }) async =>
      ejecutarOperacionOrm(
        session,
        (session) => UsuarioPendiente.db.deleteWhere(
          session,
          where: (t) => t.id.equals(id),
        ),
      );
}
