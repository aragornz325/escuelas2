import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_comision.dart';
import 'package:escuelas_server/src/orms/orm_usuario_comision.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:escuelas_server/src/servicios/servicio_asignatura.dart';
import 'package:serverpod/serverpod.dart';

class ServicioComision extends Servicio<OrmComision> {
  @override
  OrmComision get orm => OrmComision();
  ServicioAsignatura get servicioAsignatura => ServicioAsignatura();

  final _ormUsuarioComision = OrmUsuarioComision();

  Future<void> asignarUsuarioAComision(
    Session session, {
    required int idComision,
    required int idUsuario,
  }) async =>
      ejecutarOperacion(
        () => _ormUsuarioComision.crearRelacionUsuarioAComision(
          session,
          idComision: idComision,
          idUsuario: idUsuario,
        ),
      );

  Future<List<ComisionDeCurso>> obtenerComisiones(
    Session session,
  ) async =>
      ejecutarOperacion(
        () => orm.obtenerComisiones(session),
      );

  Future<ComisionDeCurso> obtenerComisionesDeCursoPorId(
    Session session, {
    required int idComision,
  }) async {
    final comisiones = await ejecutarOperacion(
      () => orm.obtenerComisionesDeCursoPorId(
        session,
        idComision: idComision,
      ),
    );

    return comisiones.first;
  }

  /// Obtiene las comisiones que tienen solicitudes de calificación mensual
  /// en el mes y año especificados.
  ///
  /// [SupervisionDeCurso] es un modelo que contiene la comisión y la fecha en la
  /// que se le notifico a los estudiantes/padres de familia de sus calificaciones
  /// del mes y año especificados.
  Future<List<SupervisionDeCurso>>
      obtenerComisionesConSolicitudesCalificacionMensual(
    Session session, {
    required int mes,
    required int anio,
  }) async {
    final comisiones = await ejecutarOperacion(
      () => orm.obtenerComisionesConSolicitudesCalificacionMensual(
        session,
        mes: mes,
        anio: anio,
      ),
    );

    final supervisionDeCursos = comisiones
        .map(
          (comision) => SupervisionDeCurso(
            comision: comision,
            // TODO(anyone): Hacer soporte de notificaciones.
            fechaDeNotificacion: null,
          ),
        )
        .toList();

    return supervisionDeCursos;
  }

  /// Obtiene las [ComisionDeCurso] con las asignaturas que tienen.
  Future<List<ComisionConAsignaturas>> listarComisionesConAsignaturas(
    Session session,
  ) async {
    final comisiones = await ejecutarOperacion(
      () => orm.obtenerComisionesConAsignaturas(
        session,
      ),
    );

    return comisiones;
  }

  /// cambia un usuario de una [ComisionDeCurso] a otra
  /// si el usuario no tiene asignada una comision previa lo asigna a la nueva
  Future<bool> cambiarUsuarioDeComision(
    Session session, {
    required int idComision,
    required int idUsuario,
  }) async {
    final relacionPrevia =
        await _ormUsuarioComision.obtenerRelacionConCursoDeUnUsuario(
      session,
      idUsuario: idUsuario,
    );

    final relacion = RelacionComisionUsuario(
      comisionId: idComision,
      usuarioId: idUsuario,
    );

    if (relacionPrevia.isEmpty) {
      await _ormUsuarioComision.crearRelacionUsuarioAComision(
        session,
        idComision: idComision,
        idUsuario: idUsuario,
      );
    } else {
      await session.dbNext.transaction((transaction) async {
        await RelacionComisionUsuario.db.deleteWhere(
          session,
          where: (t) =>
              t.comisionId.equals(
                relacionPrevia.first.comisionId,
              ) &
              t.usuarioId.equals(
                relacionPrevia.first.usuarioId,
              ),
          transaction: transaction,
        );
        await RelacionComisionUsuario.db.insertRow(
          session,
          relacion,
          transaction: transaction,
        );

        return true;
      });
    }

    return true;

  }
  
  Future<List<EstadoCalificacionesAsignatura>> obtenerEstadoDeEnvioDeCalificacionesPorComisionPorMes(
    Session session, {
    required int idComision,
    required int mes,
    required int anio,
  }) async {
    return await ejecutarOperacion(
        () => orm.obtenerEstadoDeEnvioDeCalificacionesPorComisionPorMes(
              session,
              idComision: idComision,
              mes: mes,
              anio: anio,
            ));
  }
}
