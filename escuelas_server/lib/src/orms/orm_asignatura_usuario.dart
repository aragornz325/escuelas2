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
                comisionId: asignatura.comisionId,
              ),
            ),
          ],
        );
      },
    );
  }

  //la funcion eliminarRelacionUsuarioAAsignaturas se usa para eliminar relaciones entre usuarios y asignaturas
  //en la base de datos
  //recibe una session, una lista de asignaturas solicitadas, un id de usuario, un id de comision y un id de asignatura
  //devuelve un Future<void> que indica si la operacion fue exitosa

  Future<void> eliminarRelacionUsuarioAAsignaturas(
    Session session, {
    required int idDocente,
    required int comisionId,
    required int asignaturaId,
  }) async {
    await ejecutarOperacionOrm(
      session,
      (session) async {
        await RelacionAsignaturaUsuario.db.deleteWhere(session,
            where: (t) =>
                t.usuarioId.equals(idDocente) &
                t.asignaturaId.equals(asignaturaId) &
                t.comisionId.equals(comisionId));
      },
    );
  }

  //la funcion crearRelacionesDocenteAsignatura se usa para crear relaciones entre docentes y asignaturas
  //en la base de datos
  //recibe una session, una lista de ids de asignaturas, un id de docente y un id de comision
  //devuelve un Future<bool> que indica si la operacion fue exitosa

  Future<RelacionAsignaturaUsuario> obtenerRelacionUsuarioAAsignatura(
    Session session, {
    required int usuarioId,
    required int asignaturaId,
    required int comisionId,
  }) async {
    final ahora = DateTime.now();
    logger.info('Buscando relacion entre usuario y asignatura');
    final relacion = await ejecutarOperacionOrm(
      session,
      (session) async {
        await RelacionAsignaturaUsuario.db.find(
          session,
          where: (t) =>
              t.usuarioId.equals(usuarioId) &
              t.asignaturaId.equals(asignaturaId) &
              t.comisionId.equals(comisionId),
        );
      },
    );
    if (relacion.isEmpty) {
      logger.info('No se encontro la relacion, se devuelve una vacia');
      return RelacionAsignaturaUsuario(
        asignaturaId: 0,
        usuarioId: 0,
        comisionId: 0,
        ultimaModificacion: ahora,
        fechaCreacion: ahora,
      );
    }
    return relacion.first;
  }
}
