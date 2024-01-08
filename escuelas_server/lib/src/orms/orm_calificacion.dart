import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmCalificacion extends ORM {
  Future<List<Calificacion>> crearCalificaciones(
    Session session, {
    required List<Calificacion> nuevasCalificaciones,
  }) async {
    return await Calificacion.db.insert(
      session,
      nuevasCalificaciones,
    );
  }

  Future<List<Calificacion>> obtenerCalificaciones(Session session) async {
    return await Calificacion.db.find(session);
  }

  Future<List<Calificacion>> actualizarCalificaciones(Session session, {required List<Calificacion> calificaciones,}) async {
    return await Calificacion.db.update(session, calificaciones);
  }

  Future<List<int>> eliminarCalificaciones(Session session, {required List<Calificacion> calificaciones,}) async {
    return await Calificacion.db.delete(session, calificaciones);
  }
}
