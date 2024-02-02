import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_comision.dart';
import 'package:escuelas_server/src/orms/orm_usuario_comision.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:serverpod/serverpod.dart';

class ServicioComision extends Servicio<OrmComision> {
  @override
  OrmComision get orm => OrmComision();

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
}
