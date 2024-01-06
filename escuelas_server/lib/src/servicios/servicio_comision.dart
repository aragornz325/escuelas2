import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_comision.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:serverpod/serverpod.dart';

class ServicioComision extends Servicio<OrmComision> {
  Future<void> asignarUsuarioAComision(
    Session session, {
    required int idComision,
    required int idUsuario,
  }) async =>
      ejecutarOperacion(
        () => orm.asignarUsuarioAComision(
          session,
          idComision: idComision,
          idUsuario: idUsuario,
        ),
      );

  Future<void> crearComisionSolicitada(
    Session session, {
    required int idComision,
    required int idUsuarioPendiente,
  }) async =>
      ejecutarOperacion(
        () => orm.crearComisionSolicitada(
          session,
          idComision: idComision,
          idUsuarioPendiente: idUsuarioPendiente,
        ),
      );

  Future<List<ComisionDeCurso>> obtenerComisiones(Session session) async =>
      ejecutarOperacion(
        () => orm.obtenerComisiones(session),
      );
}
