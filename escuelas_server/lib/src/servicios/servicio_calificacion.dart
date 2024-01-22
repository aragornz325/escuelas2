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

    final queryAsignaturas = '''
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
                AND snm."idComision" = c."id"
                AND snm."numeroDeMes" = $numeroDeMes
            ) IS NOT NULL THEN TRUE
            ELSE FALSE
          END
        )
      )
    FROM
      "asignaturas" a
      INNER JOIN r_asignatura_curso rac ON rac."idAsignatura" = a."id"
                  WHERE
                    rac."idCurso" = c."id"
    
    )
    ''';

    final query = await session.dbNext.unsafeQueryMappedResults(session, '''
     SELECT DISTINCT ON (c."id")
          c."id",
          c."nombre",
          c."cursoId",
          COALESCE( $queryAsignaturas, '[]'::jsonb) AS "listaDeAsignaturas"
    FROM "comisiones" c
    INNER JOIN r_asignaturas_usuarios rau ON        rau."idComision" = c."id"
    WHERE rau."usuarioId" = $idUsuario
    ''');

    for (var curso in query) {
      final nombreComision = curso['comisiones']?['nombre'];
      final idComision = curso['comisiones']?['id'];

      List<AsignaturaOverview> listaDeAsignaturas = [];

      for (var asignatura in curso['']!['listaDeAsignaturas']) {
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
          nombreDeComision: nombreComision,
          listaDeAsignaturas: listaDeAsignaturas,
        ),
      );
    }
    return listaDeComisionesRespuesta;
  }

  /// La función `obtenerCalificacionesPorAsignaturaPorPeriodo` recupera las calificaciones de una
  /// materia y periodo específico.
  ///
  /// Args:
  ///   session (Session): Un objeto de sesión que representa la sesión o conexión actual a la base de
  /// datos. Se utiliza para ejecutar operaciones de bases de datos.
  ///   idAsignatura (int): El parámetro "idAsignatura" representa el ID de la asignatura de la que se
  /// quieren obtener las calificaciones.
  ///   periodo (Periodo): El parámetro "periodo" es de tipo "Periodo" y es obligatorio.
  ///
  /// Returns:
  ///   el resultado de la función `ejecutarOperacion`, que es el resultado de la función
  /// `orm.obtenerCalificacionesPorAsignaturaPorPeriodo`.
  Future obtenerCalificacionesPorAsignaturaPorPeriodo(
    Session session, {
    required int idAsignatura,
    required Periodo periodo,
  }) async {
    return await ejecutarOperacion(
      () => orm.obtenerCalificacionesPorAsignaturaPorPeriodo(
        session,
        idAsignatura: idAsignatura,
        periodo: periodo,
      ),
    );
  }
}
