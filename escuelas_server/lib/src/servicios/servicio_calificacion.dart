import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_asignatura.dart';
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

  Future<List<ComisionOverview>>
      obtenerInformacionDeVistaGeneralDeComisiones(
    Session session, {
    required int idUsuario,
    required int numeroDeMes,
  }) async {
    List<ComisionOverview> listaDeComisionesRespuesta = [];

    final query = await session.dbNext.unsafeQueryMappedResults(session, '''
select
  c."nombre" as "nombreDeCurso",
  (
    select
      jsonb_agg(
        json_build_object(
          'idComision',
          co."id",
          'nombreDeComision',
          co."nombre",
          'listaDeAsignaturas',
          coalesce(
            (
              select
                jsonb_agg(
                  json_build_object(
                    'idAsignatura',
                    a."id",
                    'nombreDeAsignatura',
                    a."nombre",
                    'solicitudesDeCalificacionCompletas',
                    case
                      when (
                        select
                          s."fechaRealizacion"
                        from
                          solicitudes_notas_mensuales snm
                          inner join solicitudes s on s."id" = snm."idSolicitud"
                        where
                          snm."idAsignatura" = a."id"
                          and snm."idComision" = co."id"
                          and snm."numeroDeMes" = $numeroDeMes
                      ) is not null then true
                      else false
                    end
                  )
                )
              from
                "asignaturas" a
              where
                a."idCurso" = c."id"
            ),
            '[]'::jsonb
          )
        )
      )
    from
      "comisiones" co
    where
      co."idCurso" = c."id"
  ) as "comisiones"
from
  "cursos" c
inner join asignaturas a on a."idCurso" = c."id"
inner join r_asignaturas_usuarios rau on rau."asignaturaId" = a."id"
where rau."usuarioId" = $idUsuario;
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
