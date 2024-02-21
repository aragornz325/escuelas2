import 'package:escuelas_server/constants/config.dart';
import 'package:escuelas_server/src/extensiones/extension_comision.dart';
import 'package:escuelas_server/src/extensiones/extension_usuario.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_calificacion.dart';
import 'package:escuelas_server/src/orms/orm_calificacion_mensual.dart';
import 'package:escuelas_server/src/orms/orm_comision.dart';
import 'package:escuelas_server/src/orms/orm_concepto_calificacion.dart';
import 'package:escuelas_server/src/orms/orm_solicitud_nota_mensual.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:escuelas_server/src/servicios/servicio_comunicaciones.dart';
import 'package:escuelas_server/src/servicios/servicio_solicitud.dart';
import 'package:escuelas_server/src/servicios/servicio_usuario.dart';
import 'package:escuelas_server/utils/plantilla_mail_escuelas.dart';
import 'package:serverpod/serverpod.dart';

class ServicioCalificacion extends Servicio<OrmCalificacion> {
  @override
  OrmCalificacion get orm => OrmCalificacion();

  final _ormSolicitudNotaMensual = OrmSolicitudNotaMensual();

  final _ormConceptoCalificacion = OrmConceptoCalificacion();

  final _ormCalificacionMensual = OrmCalificacionMensual();

  final _servicioSolicitud = ServicioSolicitud();

  final _ormCalificacion = OrmCalificacion();

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
solicitudes_calificaciones_mensuales snm
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
rac."idCurso" = c."cursoId"
)
''';

    final query = await session.dbNext.unsafeQueryMappedResults(session, '''
SELECT DISTINCT ON (c."id")
c."id",
c."nombre",
c."cursoId",
COALESCE( $queryAsignaturas, '[]'::jsonb) AS "listaDeAsignaturas"
FROM "comisiones" c
INNER JOIN r_asignaturas_usuarios rau ON rau."comisionId" = c."id"
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
  Future<CalificacionesMensuales>
      obtenerCalificacionesPorAsignaturaPorPeriodoPorComision(
    Session session, {
    required int numeroDeMes,
    required int numeroDeAnio,
    required int idAsignatura,
    required int idComision,
  }) async {
    final mesesDePeriodo = config.obtenerListaDeMesesPorPeriodo(
      DateTime(numeroDeAnio, numeroDeMes),
    );

    final calificacionesMensualesPorPeriodo = <List<CalificacionMensual>>[];
    for (var mes in mesesDePeriodo) {
      List<CalificacionMensual> calificacionesMensuales =
          await obtenerCalificacionesMensuales(
        session,
        idAsignatura: idAsignatura,
        idComision: idComision,
        numeroDeMes: mes,
      );

      calificacionesMensualesPorPeriodo.add(calificacionesMensuales);
    }

    final solicitudesNotaMensual = await ejecutarOperacion(
      () =>
          _ormSolicitudNotaMensual.obtenerSolicitudesPorAsignaturaComisionyMes(
        session,
        idAsignatura: idAsignatura,
        idComision: idComision,
        numeroDeMes: numeroDeMes,
      ),
    );

    final respuesta = CalificacionesMensuales(
      calificacionesMensualesPorPeriodo: calificacionesMensualesPorPeriodo,
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
                  .firstWhere((element) =>
                      element.estudianteId == c.calificacion?.estudianteId)
                  .id ??
              0
          ..calificacion = null;

        return calificacion;
      },
    ).toList();

    await _ormCalificacionMensual.crearCalificacionesMensuales(
      session,
      calificaciones: calificacionesMensualesActualizadas,
    );

    await ejecutarOperacion(
      () => _servicioSolicitud.actualizarSolicitud(
        session,
        solicitud: solicitud.copyWith(
          fechaRealizacion: DateTime.now(),
        ),
      ),
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

  Future<void> actualizarCalificacionesMensualesEnLote(
    Session session, {
    required List<CalificacionMensual> calificacionesMensuales,
  }) =>
      ejecutarOperacion(() async {
        await _ormCalificacionMensual.actualizarCalificacionesMensualesEnLote(
          session,
          calificacionesMensuales: calificacionesMensuales,
        );

        final calificacion = calificacionesMensuales
            .where((e) => e.calificacion != null)
            .map((e) => e.calificacion!)
            .toList();

        await _ormCalificacion.actualizarCalificacionesEnLote(
          session,
          calificaciones: calificacion,
        );

        return;
      });

  /// TODO(Juanjo): Re-factorizar, eliminar código duplicado, etc.
  Future<bool> enviarCalificacionesPorMesYAnio(
    Session session, {
    required EnvioCalificaciones filtroDeEnvio,
    required int mes,
    required int anio,
    List<int>? idCursos,
    List<int>? idComisiones,
    List<int>? idEstudiantes,
  }) async {
    switch (filtroDeEnvio) {
      case EnvioCalificaciones.todos:
        return await ejecutarOperacion(
          () => _enviarCalificacionesEnGeneral(
            session,
            mes: mes,
            anio: anio,
          ),
        );
      case EnvioCalificaciones.porCurso:
        if (idCursos == null || idCursos.isEmpty) return false;
        return await ejecutarOperacion(
          () => _enviarCalificacionesACursos(
            session,
            idCursos: idCursos,
            mes: mes,
            anio: anio,
          ),
        );
      case EnvioCalificaciones.porComision:
        if (idComisiones == null || idComisiones.isEmpty) return false;
        return await ejecutarOperacion(
          () => _enviarCalificacionesAComisiones(
            session,
            idComisiones: idComisiones,
            mes: mes,
            anio: anio,
          ),
        );
      case EnvioCalificaciones.porEstudiante:
        if (idEstudiantes == null || idEstudiantes.isEmpty) return false;
        return await ejecutarOperacion(
          () => _enviarCalificacionesAEstudiantes(
            session,
            idEstudiantes: idEstudiantes,
            mes: mes,
            anio: anio,
          ),
        );
    }
  }

  Future<bool> _enviarCalificacionesEnGeneral(
    Session session, {
    required int mes,
    required int anio,
  }) async {
    final comisiones = await OrmComision().obtenerComisiones(session);
    final calificaciones = await _ormCalificacion.obtenerCalificaciones(
      session,
      mes: mes,
      anio: anio,
      idComisiones: comisiones.map((e) => e.id!).toList(),
    );

    for (var comision in comisiones) {
      for (var estudiante in comision.listaDeEstudiantes) {
        Map<String, dynamic> asignaturasCalificaciones = {};
        for (var asignatura in comision.listaDeAsignaturas) {
          asignaturasCalificaciones[asignatura.nombre] = calificaciones.where(
            (element) =>
                element.asignaturaId == asignatura.id &&
                element.estudianteId == estudiante.id,
          );
        }

        await ServicioComunicaciones().enviarEmail(
          session,
          direccionEmailDestinatarios:
              estudiante.listaDireccionesDeEmailStrings,
          asuntoDelCorreo:
              '${estudiante.nombre}, ¡tus calificaciones llegaron!',
          contenidoHtmlDelCorreo: PlantillaEmailCalificaciones(
            nombre: estudiante.nombre,
            apellido: estudiante.apellido,
            curso: comision.nombreDelCursoYLaComision,
            calificaciones: asignaturasCalificaciones.toString(),
          ).html(),
        );
      }
    }
    return true;
  }

  Future<bool> _enviarCalificacionesACursos(
    Session session, {
    required int mes,
    required int anio,
    required List<int> idCursos,
  }) async {
    final comisiones = await OrmComision().obtenerComisiones(
      session,
      idCursos: idCursos,
    );
    final calificaciones = await _ormCalificacion.obtenerCalificaciones(session,
        mes: mes,
        anio: anio,
        idComisiones: comisiones.map((e) => e.id!).toList());

    for (var comision in comisiones) {
      for (var estudiante in comision.listaDeEstudiantes) {
        Map<String, dynamic> asignaturasCalificaciones = {};
        for (var asignatura in comision.listaDeAsignaturas) {
          asignaturasCalificaciones[asignatura.nombre] = calificaciones.where(
            (element) =>
                element.asignaturaId == asignatura.id &&
                element.estudianteId == estudiante.id,
          );
        }

        await ServicioComunicaciones().enviarEmail(
          session,
          direccionEmailDestinatarios:
              estudiante.listaDireccionesDeEmailStrings,
          asuntoDelCorreo:
              '${estudiante.nombre}, ¡tus calificaciones llegaron!',
          contenidoHtmlDelCorreo: PlantillaEmailCalificaciones(
            nombre: estudiante.nombre,
            apellido: estudiante.apellido,
            curso: comision.nombreDelCursoYLaComision,
            calificaciones: asignaturasCalificaciones.toString(),
          ).html(),
        );
      }
    }
    return true;
  }

  Future<bool> _enviarCalificacionesAComisiones(
    Session session, {
    required int mes,
    required int anio,
    required List<int> idComisiones,
  }) async {
    final comisiones = await OrmComision().obtenerComisiones(
      session,
      idComisiones: idComisiones,
    );
    final calificaciones = await _ormCalificacion.obtenerCalificaciones(session,
        mes: mes,
        anio: anio,
        idComisiones: comisiones.map((e) => e.id!).toList());

    for (var comision in comisiones) {
      for (var estudiante in comision.listaDeEstudiantes) {
        Map<String, dynamic> asignaturasCalificaciones = {};
        for (var asignatura in comision.listaDeAsignaturas) {
          asignaturasCalificaciones[asignatura.nombre] = calificaciones.where(
            (element) =>
                element.asignaturaId == asignatura.id &&
                element.estudianteId == estudiante.id,
          );
        }

        await ServicioComunicaciones().enviarEmail(
          session,
          direccionEmailDestinatarios:
              estudiante.listaDireccionesDeEmailStrings,
          asuntoDelCorreo:
              '${estudiante.nombre}, ¡tus calificaciones llegaron!',
          contenidoHtmlDelCorreo: PlantillaEmailCalificaciones(
            nombre: estudiante.nombre,
            apellido: estudiante.apellido,
            curso: comision.nombreDelCursoYLaComision,
            calificaciones: asignaturasCalificaciones.toString(),
          ).html(),
        );
      }
    }
    return true;
  }

  Future<bool> _enviarCalificacionesAEstudiantes(
    Session session, {
    required int mes,
    required int anio,
    required List<int> idEstudiantes,
  }) async {
    final comisiones = await OrmComision().obtenerComisiones(
      session,
      idEstudiantesFiltrados: idEstudiantes,
    );
    final calificaciones = await _ormCalificacion.obtenerCalificaciones(
      session,
      mes: mes,
      anio: anio,
      idEstudiantes: idEstudiantes,
    );

    for (var comision
        in comisiones.where((element) => element.estudiantes!.isNotEmpty)) {
      for (var estudiante in comision.listaDeEstudiantes) {
        Map<String, dynamic> asignaturasCalificaciones = {};
        for (var asignatura in comision.listaDeAsignaturas) {
          asignaturasCalificaciones[asignatura.nombre] = calificaciones.where(
            (element) =>
                element.asignaturaId == asignatura.id &&
                element.estudianteId == estudiante.id,
          );
        }

        await ServicioComunicaciones().enviarEmail(
          session,
          direccionEmailDestinatarios:
              estudiante.listaDireccionesDeEmailStrings,
          asuntoDelCorreo:
              '${estudiante.nombre}, ¡tus calificaciones llegaron!',
          contenidoHtmlDelCorreo: PlantillaEmailCalificaciones(
            nombre: estudiante.nombre,
            apellido: estudiante.apellido,
            curso: comision.nombreDelCursoYLaComision,
            calificaciones: asignaturasCalificaciones.toString(),
          ).html(),
        );
      }
    }
    return true;
  }

  Future<List<CalificacionMensual>> listarMisCalificacionesMensualesPorMes(
    Session session, {
    required int mes,
    required int anio,
  }) async {
    final usuario = await ServicioUsuario().obtenerDatosDelUsuario(session);

    return await OrmCalificacionMensual()
        .listarMisCalificacionesMensualesPorMes(
      session,
      idUsuario: usuario.id!,
      numeroDeMes: mes,
      anio: anio,
    );
  }

  Future<List<CalificacionMensual>> listarMisCalificacionesAnualesPorAsignatura(
    Session session, {
    required idAsignatura,
    required int anio,
  }) async {
    final usuario = await ServicioUsuario().obtenerDatosDelUsuario(session);

    return await OrmCalificacionMensual()
        .listarMisCalificacionesAnualesPorAsignatura(
      session,
      idUsuario: usuario.id!,
      idAsignatura: idAsignatura,
      anio: anio,
    );
  }
}
