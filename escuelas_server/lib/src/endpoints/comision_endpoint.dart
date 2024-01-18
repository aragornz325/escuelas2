import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/servicio_comision.dart';
import 'package:serverpod/serverpod.dart';

class ComisionEndpoint extends Endpoint with Controller<ServicioComision> {
  @override
  ServicioComision get servicio => ServicioComision();
  Future<void> asignarUsuarioAComision(
    Session session, {
    required int idComision,
    required int idUsuario,
  }) async =>
      ejecutarOperacionControlador(
        session,
        'asignarUsuarioAComision',
        () => servicio.asignarUsuarioAComision(
          session,
          idComision: idComision,
          idUsuario: idUsuario,
        ),
      );

  Future<List<ComisionDeCurso>> obtenerComisiones(Session session) async =>
      ejecutarOperacionControlador(
        session,
        'obtenerComisiones',
        () => servicio.obtenerComisiones(session),
      );
}
