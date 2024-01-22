import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_asignatura_usuario.dart';
import 'package:escuelas_server/src/orms/orm_calificacion.dart';
import 'package:escuelas_server/src/orms/orm_concepto_calificacion.dart';
import 'package:escuelas_server/src/orms/orm_solicitud_nota_mensual.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:serverpod/serverpod.dart';

class ServicioCalificacion extends Servicio<OrmCalificacion> {
  @override
  OrmCalificacion get orm => OrmCalificacion();

  final OrmSolicitudNotaMensual _ormSolicitudNotaMensual =
      OrmSolicitudNotaMensual();

  final OrmConceptoCalificacion _ormConceptoCalificacion =
      OrmConceptoCalificacion();

  final OrmRelacionAsignaturaUsuario _ormRelacionUsuarioAsignatura =
      OrmRelacionAsignaturaUsuario();

  Future<List<Calificacion>> crearCalificacionesEnBloque(
    Session session, {
    required List<Calificacion> calificaciones,
  }) async {
    return await ejecutarOperacion(
      () => orm.crearCalificaciones(
        session,
        calificaciones: calificaciones,
      ),
    );
  }

  Future<ConceptoCalificacion> crearConceptoDeCalificacion(
    Session session, {
    required String etiqueta,
  }) async {
    final ahora = DateTime.now();

    return await ejecutarOperacion(
      () => _ormConceptoCalificacion.crearConceptoDeCalificacion(
        session,
        conceptoCalificacion: ConceptoCalificacion(
          concepto: etiqueta,
          ultimaModificacion: ahora,
          fechaCreacion: ahora,
        ),
      ),
    );
  }

  Future<List<Calificacion>> obtenerCalificaciones(
    Session session,
    Periodo? periodo,
  ) async =>
      ejecutarOperacion(
        () => orm.obtenerCalificaciones(
          session,
          periodo: periodo,
        ),
      );

  Future<List<ConceptoCalificacion>> obtenerConceptosDeCalificacion(
      Session session) async {
    return await _ormConceptoCalificacion
        .obtenerConceptosDeCalificacion(session);
  }

  Future<List<ComisionOverview>> obtenerInformacionDeVistaGeneralDeComisiones(
    Session session, {
    required int idUsuario,
    required int numeroDeMes,
  }) async {
    List<ComisionOverview> listaDeComisionesRespuesta = [];

    final query = await session.dbNext.unsafeQueryMappedResults(session, '''
SELECT
  c."nombre" AS "nombreDeCurso",
  (
    SELECT
      JSONB_AGG(
        JSON_BUILD_OBJECT(
          'idComision',
          co."id",
          'nombreDeComision',
          co."nombre",
          'listaDeAsignaturas',
          COALESCE(
            (
              SELECT
                JSONB_AGG(
                  JSON_BUILD_OBJECT(
                    'idAsignatura',
                    a."id",
                    'nombreDeAsignatura',
                    a."nombre",
                    'solicitudesDeCalificacionCompletas',
                    CASE
                      WHEN (
                        SELECT
                          s."fechaRealizacion"
                        FROM
                          solicitudes_notas_mensuales snm
                          INNER JOIN solicitudes s ON s."id" = snm."idSolicitud"
                        WHERE
                          snm."idAsignatura" = a."id"
                          AND snm."idComision" = co."id"
                          AND snm."numeroDeMes" = $numeroDeMes
                      ) IS NOT NULL THEN TRUE
                      ELSE FALSE
                    END
                  )
                )
              FROM
                "asignaturas" a
              WHERE
                a."cursoId" = c."id"
            ),
            '[]'::JSONB
          )
        )
      )
    FROM
      "comisiones" co
    WHERE
      co."cursoId" = c."id"
  ) AS "comisiones"
FROM
  "cursos" c
INNER JOIN asignaturas a ON a."cursoId" = c."id"
INNER JOIN r_asignaturas_usuarios rau ON rau."asignaturaId" = a."id"
WHERE rau."usuarioId" = $idUsuario;

''');

    for (var curso in query) {
      final nombreDeCurso = curso['cursos']?['nombreDeCurso'];
      final listaDeComisiones = curso['']?['comisiones'];

      for (var comision in listaDeComisiones) {
        final idComision = comision['idComision'];
        final nombreDeComision = comision['nombreDeComision'];
        List<AsignaturaOverview> listaDeAsignaturas = [];

        for (var asignatura in comision['listaDeAsignaturas']) {
          final idAsignatura = asignatura['idAsignatura'];
          final nombreDeAsignatura = asignatura['nombreDeAsignatura'];
          final solicitudesDeCalificacionCompletas =
              asignatura['solicitudesDeCalificacionCompletas'];

          listaDeAsignaturas.add(
            AsignaturaOverview(
              idAsignatura: idAsignatura,
              nombreDeAsignatura: nombreDeAsignatura,
              solicitudesDeCalificacionCompletas:
                  solicitudesDeCalificacionCompletas,
            ),
          );
        }
        listaDeComisionesRespuesta.add(
          ComisionOverview(
            idComision: idComision,
            nombreDeCurso: nombreDeCurso,
            nombreDeComision: nombreDeComision,
            listaDeAsignaturas: listaDeAsignaturas,
          ),
        );
      }
    }
    return listaDeComisionesRespuesta;
  }
}
