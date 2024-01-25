import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_calificacion.dart';
import 'package:escuelas_server/src/orms/orm_calificacion_mensual.dart';
import 'package:escuelas_server/src/orms/orm_concepto_calificacion.dart';
import 'package:escuelas_server/src/orms/orm_solicitud_nota_mensual.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:escuelas_server/src/servicios/servicio_solicitud.dart';
import 'package:escuelas_server/src/servicios/servicio_usuario.dart';
import 'package:serverpod/serverpod.dart';

class ServicioCalificacion extends Servicio<OrmCalificacion> {
  @override
  OrmCalificacion get orm => OrmCalificacion();

  final _ormSolicitudNotaMensual = OrmSolicitudNotaMensual();

  final _ormConceptoCalificacion = OrmConceptoCalificacion();

  final _ormCalificacionMensual = OrmCalificacionMensual();

  final _servicioSolicitud = ServicioSolicitud();

  final _servicioUsuario = ServicioUsuario();

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
                INNER JOIN solicitudes s ON s."id" = snm."solicitudId"
              WHERE
                snm."idAsignatura" = a."id"
                AND snm."comisionId" = c."id"
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
    INNER JOIN r_asignaturas_usuarios rau ON        rau."comisionId" = c."id"
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
  Future<CalificacionesMensuales> obtenerCalificacionesPorAsignaturaPorPeriodo(
    Session session, {
    required int numeroDeMes,
    required int numeroDeAnio,
    required int idAsignatura,
    required int idComision,
  }) async {
    List<CalificacionMensual> calificacionesMensuales =
        await obtenerCalificacionesMensuales(
      session,
      idAsignatura: idAsignatura,
      idComision: idComision,
      numeroDeMes: numeroDeMes,
    );

    final solicitudesNotaMensual = await ejecutarOperacion(
      () =>
          _ormSolicitudNotaMensual.obtenerSolicitudesPorAsignaturaComisionyMes(
        session,
        idAsignatura: idAsignatura,
        idComision: idComision,
        numeroDeMes: numeroDeMes,
      ),
    );

    // TODO(anyone):
    // Analizar si es lo mejor esto de mandar las calificaciones
    // vacias en caso de una instancia en la que se haya hecho una solicitud
    // pero no se hayan creado las calificaciones mensuales
    if (solicitudesNotaMensual.isNotEmpty && calificacionesMensuales.isEmpty) {
      final estudiantes = await ejecutarOperacion(
        () => _servicioUsuario.obtenerListaDeEstudiantesDeComision(
          session,
          idComision: idComision,
        ),
      );

      final idAutor = await obtenerIdDeUsuarioLogueado(session);

      // Creamos una calificacion mensual vacia para cada estudiante
      calificacionesMensuales = estudiantes.map((e) {
        return CalificacionMensual(
          calificacion: Calificacion(
            idAsignatura: idAsignatura,
            idComision: idComision,
            estudianteId: e.id ?? 0,
            fechaCreacion: DateTime.now(),
            ultimaModificacion: DateTime.now(),
            idAutor: idAutor,
            idInstanciaDeEvaluacion: 0,
            tipoCalificacion: TipoCalificacion.numericoDecimal,
            index: 0,
            diferencial: '0',
          ),
          numeroDeMes: numeroDeMes,
          calificacionId: 0,
        );
      }).toList();
    }

    final respuesta = CalificacionesMensuales(
      calificacionesMensuales: calificacionesMensuales,
      solicitudNotaMensual:
          solicitudesNotaMensual.isEmpty ? null : solicitudesNotaMensual.first,
    );

    return respuesta;
  }

  Future<void> cargarCalificacionesMensualesPorSolicitud(
    Session session, {
    required int idSolicitud,
    required List<CalificacionMensual> calificacionesMensuales,
  }) async {
    final solicitudMensual = await _ormSolicitudNotaMensual
        .obtenerSolicitudNotaMensualPorIdSolicitud(
      session,
      idSolicitud: idSolicitud,
    );

    final solicitud = solicitudMensual.solicitud;

    if (solicitud == null) {
      throw ExcepcionCustom(
        titulo: 'Solicitud no encontrada',
        mensaje: 'la solicitud no fue encontrada',
        tipoDeError: TipoExcepcion.noEncontrado,
        codigoError: 404,
      );
    }

    if (solicitud.fechaRealizacion != null) {
      throw ExcepcionCustom(
        titulo: 'Solicitud ya realizada',
        mensaje: 'la solicitud ya fue realizada',
        tipoDeError: TipoExcepcion.solicitudIncorrecta,
        codigoError: 400,
      );
    }

    await ejecutarOperacion(
      () => _servicioSolicitud.actualizarSolicitud(
        session,
        solicitud: solicitud.copyWith(
          fechaRealizacion: DateTime.now(),
        ),
      ),
    );

    final calificaciones = calificacionesMensuales.map((e) {
      final calificacion = e.calificacion;

      if (calificacion == null) {
        throw ExcepcionCustom(
          titulo: 'Calificacion no encontrada',
          mensaje: 'la calificacion no fue encontrada',
          tipoDeError: TipoExcepcion.desconocido,
          codigoError: 560,
        );
      }

      return calificacion;
    }).toList();

    final calificacionesCreadas = await orm.crearCalificaciones(
      session,
      calificaciones: calificaciones,
    );

    final calificacionesMensualesActualizadas = calificacionesMensuales.map(
      (c) {
        // Insertamos el id de la calificacion creada en la calificacion mensual
        final calificacion = c
          ..calificacionId = calificacionesCreadas
                  .firstWhere((element) => element.id == c.calificacion?.id)
                  .id ??
              0;

        return calificacion;
      },
    ).toList();

    await _ormCalificacionMensual.crearCalificacionesMensuales(
      session,
      calificaciones: calificacionesMensualesActualizadas,
    );
  }

  Future<List<CalificacionMensual>> obtenerCalificacionesMensuales(
    Session session, {
    required int idAsignatura,
    required int idComision,
    int? numeroDeMes,
  }) async =>
      await ejecutarOperacion(
        () => _ormCalificacionMensual.obtenerCalificacionesMensuales(
          session,
          idAsignatura: idAsignatura,
          idComision: idComision,
          numeroDeMes: numeroDeMes,
        ),
      );
}
