import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_asignatura_usuario.dart';
import 'package:escuelas_server/src/orms/orm_docente.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:serverpod/serverpod.dart';

class ServicioDocente extends Servicio<OrmDocente> {
  @override
  OrmDocente get orm => OrmDocente();
  OrmRelacionAsignaturaUsuario get ormRelacionAsignaturaUsuario =>
      OrmRelacionAsignaturaUsuario();

  //la funcion crearRelacionesDocenteAsignatura se usa para crear relaciones entre docentes y asignaturas
  //en la base de datos
  //recibe una session, una lista de ids de asignaturas, un id de docente y un id de comision
  //devuelve un Future<bool> que indica si la operacion fue exitosa
  Future<bool> asignarDocenteAAsignatura(
    Session session, {
    required List<int> idsAsignaturas,
    required int idDocente,
    required int idComision,
  }) async {
    final ahora = DateTime.now();

    logger.info('Creando relaciones entre docente y asignaturas');
    final relaciones = idsAsignaturas.map((idAsignatura) {
      return RelacionAsignaturaUsuario(
        asignaturaId: idAsignatura,
        usuarioId: idDocente,
        comisionId: idComision,
        ultimaModificacion: ahora,
        fechaCreacion: ahora,
      );
    }).toList();

    logger.info('ejecutando la operacion de orm');
    ejecutarOperacion(
      () => orm.crearRelacionesDocenteAsignatura(
        session,
        relacionAsignaturaUsuario: relaciones,
      ),
    );
    logger.info('se crearon todas las relaciones');
    return true;
  }

  //la funcion eliminarRelacionUsuarioAAsignaturas se usa para eliminar relaciones entre usuarios y asignaturas
  //en la base de datos
  //recibe una session, una lista de asignaturas solicitadas, un id de usuario, un id de comision y un id de asignatura
  //devuelve un Future<void> que indica si la operacion fue exitosa
  Future<void> desasignarUsuarioAAsignatura(
    Session session, {
    required int idDocente,
    required int comisionId,
    required int asignaturaId,
  }) async {
    ejecutarOperacion(
      () => ormRelacionAsignaturaUsuario.desasignarUsuarioAAsignatura(
        session,
        idDocente: idDocente,
        comisionId: comisionId,
        asignaturaId: asignaturaId,
      ),
    );
  }
}
