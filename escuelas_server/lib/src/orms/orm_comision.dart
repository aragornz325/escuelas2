import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmComision extends ORM {
  Future<List<ComisionDeCurso>> obtenerComisiones(
    Session session,
  ) async =>
      ejecutarOperacionOrm(
        session,
        (session) => ComisionDeCurso.db.find(
          session,
          include: ComisionDeCurso.include(
            curso: Curso.include(),
            estudiantes: RelacionComisionUsuario.includeList(
              include: RelacionComisionUsuario.include(
                usuario: Usuario.include(),
              ),
            ),
          ),
        ),
      );

  Future<List<ComisionDeCurso>> obtenerComisionesDeCursoPorId(
    Session session, {
    required int idComision,
  }) async =>
      ejecutarOperacionOrm(
        session,
        (session) => ComisionDeCurso.db.find(
          session,
          where: (comision) => comision.id.equals(idComision),
          include: ComisionDeCurso.include(
            curso: Curso.include(),
            estudiantes: RelacionComisionUsuario.includeList(
              include: RelacionComisionUsuario.include(
                usuario: Usuario.include(),
              ),
            ),
          ),
        ),
      );

  /// Obtiene las comisiones que tienen solicitudes de calificación mensual
  /// en el mes y año especificados.
  Future<List<ComisionDeCurso>>
      obtenerComisionesConSolicitudesCalificacionMensual(
    Session session, {
    required int mes,
    required int anio,
  }) async =>
          ejecutarOperacionOrm(
            session,
            (session) => ComisionDeCurso.db.find(
              session,
              where: (comision) => comision.solicitudesCalificacionMensual.any(
                (solicitud) =>
                    solicitud.mes.equals(mes) &
                    solicitud.anio.equals(
                      anio,
                    ),
              ),
              include: ComisionDeCurso.include(
                solicitudesCalificacionMensual:
                    SolicitudCalificacionMensual.includeList(
                  include: SolicitudCalificacionMensual.include(
                    solicitud: Solicitud.include(),
                  ),
                ),
              ),
            ),
          );
}
