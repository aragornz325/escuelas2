import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/servicio_comision.dart';
import 'package:serverpod/serverpod.dart';

class ComisionesEndpoint extends Endpoint with Controller<ServicioComision> {
  Future<void> relacionarUsuarioAComision(
    Session session, {
    required int idComision,
    required int idUsuario,
  }) async =>
      ejecutarOperacionControlador(
        'relacionarUsuarioAComision',
        () => servicio.relacionarUsuarioAComision(
          session,
          idComision: idComision,
          idUsuario: idUsuario,
        ),
      );

  Future<List<ComisionDeCurso>> obtenerComisiones(Session session) async =>
      ejecutarOperacionControlador(
        'obtenerComisiones',
        () => servicio.obtenerComisiones(session),
      );
}
