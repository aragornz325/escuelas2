import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_calificacion.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:serverpod/serverpod.dart';

class ServicioCalificacion extends Servicio<OrmCalificacion> {

  @override
  OrmCalificacion get orm => OrmCalificacion();

  Future<List<Calificacion>> crearCalificacionesEnBloque(
    Session session, {
    required int idConcepto,
    required List<Calificacion> calificaciones,
  }) async {
    for (var calificacion in calificaciones) {
      calificacion.idConcepto = idConcepto;
    }
    
    return orm.crearCalificaciones(session, calificaciones: calificaciones);
  }
  
}