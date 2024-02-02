import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/servicio_docente.dart';
import 'package:serverpod/server.dart';

class DocenteEndpoint extends Endpoint with Controller<ServicioDocente> {
  @override
  ServicioDocente get servicio => ServicioDocente();

  /// La función "crearRelacionesDocenteAsignatura" se usa para crear relaciones entre docentes y asignaturas
  /// en la base de datos.
  /// Recibe una session, una lista de ids de asignaturas, un id de docente y un id de comision.
  /// Devuelve un Future<bool> que indica si la operacion fue exitosa.
  Future<bool> asignarDocenteAAsignatura(
    Session session, {
    required List<int> idsAsignaturas,
    required int idDocente,
    required int idComision,
  }) async {
    return servicio.asignarDocenteAAsignatura(
      session,
      idsAsignaturas: idsAsignaturas,
      idDocente: idDocente,
      idComision: idComision,
    );
  }

  Future<void> desasignarUsuarioAAsignatura(
    Session session, {
    required int idDocente,
    required int comisionId,
    required int asignaturaId,
  }) async {
    return servicio.desasignarUsuarioAAsignatura(
      session,
      idDocente: idDocente,
      comisionId: comisionId,
      asignaturaId: asignaturaId,
    );
  }
}
