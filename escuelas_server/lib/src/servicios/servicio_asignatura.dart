import 'package:escuelas_server/servicio.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_asignatura.dart';
import 'package:serverpod/serverpod.dart';

class ServicioAsignatura extends Servicio {
  OrmAsignatura get orm => OrmAsignatura();

  Future<Asignatura> crearAsignatura(
    Session session, {
    required Asignatura asignatura,
  }) async {
    final asignaturaDB = await ejecutarOperacion(
      () => orm.crearAsignatura(
        session,
        asignatura: asignatura,
      ),
    );
    return asignaturaDB;
  }

  Future<Asignatura> actualizarAsignatura(
    Session session, {
    required Asignatura asignatura,
  }) async {
    final asignaturaDB = await ejecutarOperacion(
      () => orm.actualizarAsignatura(
        session,
        asignatura: asignatura,
      ),
    );
    return asignaturaDB;
  }

  Future<Asignatura> otenerAsignaturaPorId(
    Session session, {
    required int id,
  }) async {
    final asignatura = await ejecutarOperacion(
      () => orm.otenerAsignaturaPorId(
        session,
        id: id,
      ),
    );
    return asignatura;
  }

  Future<List<Asignatura>> obtenerAsignaturas(
    Session session,
  ) async {
    final asignaturas = await ejecutarOperacion(
      () => orm.obtenerAsignaturas(
        session,
      ),
    );
    return asignaturas;
  }

  Future<int> eliminarAsignatura(
    Session session, {
    required int id,
  }) async {
    return await ejecutarOperacion(
      () => orm.eliminarAsignatura(
        session,
        id: id,
      ),
    );
  }
}
