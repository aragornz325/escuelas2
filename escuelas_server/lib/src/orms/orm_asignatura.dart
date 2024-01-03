import 'package:escuelas_server/orm.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class OrmAsignatura extends ORM {
  Future<Asignatura> crearAsignatura(
    Session session, {
    required Asignatura asignatura,
  }) async {
    final asignaturaDB = await ejecutarOperacionOrm(
      session,
      (session) => Asignatura.db.insert(
        session,
        [asignatura],
      ),
    );
    return asignaturaDB.first;
  }

  Future<Asignatura> actualizarAsignatura(
    Session session, {
    required Asignatura asignatura,
  }) async {
    final asignaturaDB = await ejecutarOperacionOrm(
      session,
      (session) => Asignatura.db.update(
        session,
        [asignatura],
      ),
    );
    return asignaturaDB.first;
  }

  Future<Asignatura> otenerAsignaturaPorId(
    Session session, {
    required int id,
  }) async {
    final asignatura = await ejecutarOperacionOrm(
      session,
      (session) => Asignatura.db.findById(
        session,
        id,
      ),
    );
    if (asignatura == null) {
      throw Exception(
        'Asignatura no encontrada',
      );
    }
    return asignatura;
  }

  Future<List<Asignatura>> obtenerAsignaturas(
    Session session,
  ) async {
    final asignaturas = await ejecutarOperacionOrm(
      session,
      (session) => Asignatura.db.find(
        session,
      ),
    );
    if (asignaturas.isEmpty) {
      throw Exception(
        'No hay asignaturas',
      );
    }
    return asignaturas;
  }

  Future<int> eliminarAsignatura(
    Session session, {
    required int id,
  }) async {
    final asignatura = await otenerAsignaturaPorId(
      session,
      id: id,
    );
    final eliminado = await ejecutarOperacionOrm(
      session,
      (session) => Asignatura.db.delete(
        session,
        [asignatura],
      ),
    );
    return eliminado.first;
  }

  
}
