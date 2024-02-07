import 'dart:convert';
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

  Future<List> obtenerComisionesConAsignaturas(
    Session session,
  ) async {
    final respuesta = await ejecutarOperacionOrm(
      session,
      (session) => session.dbNext.unsafeQueryMappedResults(session, '''
SELECT
    comisiones.id AS comision_id,
    comisiones.nombre AS nombre_comision,
    comisiones."anioLectivo" AS anio_lectivo,
    cursos.id AS curso_id,
    cursos.nombre AS nombre_curso,
    json_agg(
        json_build_object(
            'asignatura_id', asignaturas.id,
            'nombre_asignatura', asignaturas.nombre
        )
    ) FILTER (WHERE asignaturas.id IS NOT NULL) AS asignaturas
FROM
    comisiones
JOIN cursos ON comisiones."cursoId" = cursos.id
LEFT JOIN r_asignatura_curso ON cursos.id = r_asignatura_curso."idCurso"
    AND r_asignatura_curso."fechaEliminacion" IS NULL
LEFT JOIN asignaturas ON r_asignatura_curso."idAsignatura" = asignaturas.id
    AND asignaturas."fechaEliminacion" IS NULL
WHERE
    comisiones."fechaEliminacion" IS NULL
    AND cursos."fechaEliminacion" IS NULL
GROUP BY
    comisiones.id, cursos.id
ORDER BY
    comisiones.id, cursos.id;
'''),
    );

    return respuesta;
  }

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

  Future<List<ComisionDeCurso>> listarComisionesConAsignaturas(
          Session session) async =>
      ejecutarOperacionOrm(
        session,
        (session) => ComisionDeCurso.db.find(
          session,
        ),
      );
}
