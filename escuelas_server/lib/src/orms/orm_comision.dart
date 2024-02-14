import 'package:escuelas_server/src/funciones.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmComision extends ORM {
  Future<List<ComisionDeCurso>> obtenerComisiones(
    Session session, {
    List<int>? idCursos,
    List<int>? idComisiones,
    List<int>? idEstudiantesFiltrados,
  }) async =>
      ejecutarOperacionOrm(
        session,
        (session) => ComisionDeCurso.db.find(
          session,
          where: (t) {
            final expresionCursos = (idCursos != null && idCursos.isNotEmpty)
                ? t.cursoId.inSet(idCursos.toSet())
                : t.id.notEquals(null);
            final expresionComisiones =
                (idComisiones != null && idComisiones.isNotEmpty)
                    ? t.id.inSet(idComisiones.toSet())
                    : t.id.notEquals(null);

            return expresionCursos & expresionComisiones;
          },
          include: ComisionDeCurso.include(
            curso: Curso.include(
              asignaturas: Asignatura.includeList(
                include: Asignatura.include(),
              ),
            ),
            estudiantes: RelacionComisionUsuario.includeList(
              where: (t) {
                final expresionEstudiantes = (idEstudiantesFiltrados != null &&
                        idEstudiantesFiltrados.isNotEmpty)
                    ? t.usuarioId.inSet(idEstudiantesFiltrados.toSet())
                    : t.id.notEquals(null);

                return expresionEstudiantes;
              },
              include: RelacionComisionUsuario.include(
                usuario: Usuario.include(
                  direccionesDeEmail: DireccionDeEmail.includeList(
                    include: DireccionDeEmail.include(),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Future<List<ComisionConAsignaturas>> obtenerComisionesConAsignaturas(
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
    List<ComisionConAsignaturas> comisionesConAsignaturas = [];
    for (var comisionMap in respuesta) {
      var comision = {
        'comision': comisionMap['comisiones'],
        'curso': comisionMap['cursos'],
        'asignaturas': comisionMap['']?['asignaturas'] ?? []
      };

      comisionesConAsignaturas.add(
        ComisionConAsignaturas(
          comision: ComisionDeCurso(
            cursoId: comision['curso']['curso_id'],
            anioLectivo: comision['comision']['anio_lectivo'],
            id: comision['comision']['comision_id'],
            nombre: comision['comision']['nombre_comision'],
            curso: Curso(
              id: comision['curso']['curso_id'],
              nombre: comision['curso']['nombre_curso'],
            ),
            ultimaModificacion: DateTime.now(),
          ),
          asignaturas: comision['asignaturas']
              .map<Asignatura>(
                (asignatura) => Asignatura(
                  id: asignatura['asignatura_id'],
                  nombre: asignatura['nombre_asignatura'],
                ),
              )
              .toList(),
        ),
      );
    }

    return comisionesConAsignaturas;
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

  /// Obtiene una lista de las asignaturas dentro de una comisión, junto al nombre del docente,
  /// y la fecha en que las calificaciones del mes y el año indicados fueron cargadas.
  Future<List<EstadoCalificacionesAsignatura>>
      obtenerEstadoDeEnvioDeCalificacionesPorComisionPorMes(
    Session session, {
    required int idComision,
    required int mes,
    required int anio,
  }) async {
    final listaQuery = await ejecutarOperacionOrm(
      session,
      (session) => session.dbNext.unsafeQueryMappedResults(session, '''
SELECT 
  a."${Asignatura.t.id.columnName}" as "idAsignatura",
  a."${Asignatura.t.nombre.columnName}" AS "nombreAsignatura",
  u."${Usuario.t.id.columnName}" AS "idUsuario",
  CONCAT(u."${Usuario.t.nombre.columnName}", ' ', u."${Usuario.t.apellido.columnName}") AS "nombreDocente",
  sol."${Solicitud.t.id.columnName}" AS "idSolicitud",
  sol."${Solicitud.t.fechaRealizacion.columnName}" AS "fechaRealizacionSolicitud"
FROM ${RelacionAsignaturaUsuario.t.tableName} rau 
INNER JOIN ${Usuario.t.tableName} u ON u."${Usuario.t.id.columnName}" = rau."${RelacionAsignaturaUsuario.t.usuarioId.columnName}"
INNER JOIN ${Asignatura.t.tableName} a ON a."${Asignatura.t.id.columnName}" = rau."${RelacionAsignaturaUsuario.t.asignaturaId.columnName}"
INNER JOIN ${SolicitudCalificacionMensual.t.tableName} scm ON scm."${SolicitudCalificacionMensual.t.idAsignatura.columnName}" = a."${Asignatura.t.id.columnName}"
INNER JOIN ${Solicitud.t.tableName} sol ON sol."${Solicitud.t.id.columnName}" = scm."${SolicitudCalificacionMensual.t.solicitudId.columnName}"
WHERE 
  scm.mes = $mes AND
  scm.anio = $anio AND
  rau."comisionId" = $idComision;
'''),
    );

    return listaQuery
        .map(
          (e) => EstadoCalificacionesAsignatura.fromJson(
            extenderMap(e),
            Protocol(),
          ),
        )
        .toList();
  }
}
