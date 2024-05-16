import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmCalificacionMensual extends ORM {
  Future<List<CalificacionMensual>> crearCalificacionesMensuales(
    Session session, {
    required List<CalificacionMensual> calificaciones,
  }) async =>
      ejecutarOperacionOrm(
        session,
        (session) => CalificacionMensual.db.insert(
          session,
          calificaciones,
        ),
      );

  Future<List<CalificacionMensual>> obtenerCalificacionesMensuales(
    Session session, {
    int? numeroDeMes,
    required int idAsignatura,
    required int idComision,
  }) async =>
      ejecutarOperacionOrm(
        session,
        (session) => CalificacionMensual.db.find(
          session,
          where: (t) {
            if (numeroDeMes != null) {
              return t.calificacion.idComision.equals(idComision) &
                  t.calificacion.asignaturaId.equals(idAsignatura) &
                  t.numeroDeMes.equals(numeroDeMes);
            }

            return t.calificacion.idComision.equals(idComision) &
                t.calificacion.asignaturaId.equals(idAsignatura);
          },
          include: CalificacionMensual.include(
            calificacion: Calificacion.include(
              estudiante: Usuario.include(),
            ),
          ),
        ),
      );

  Future<List<CalificacionMensual>> actualizarCalificacionesMensualesEnLote(
    Session session, {
    required List<CalificacionMensual> calificacionesMensuales,
  }) async =>
      ejecutarOperacionOrm(
        session,
        (session) async {
          final calificacionMensual = await CalificacionMensual.db.update(
            session,
            calificacionesMensuales,
          );

          // if (calificacionMensual.isEmpty) {
          //   throw ExcepcionCustom(
          //     titulo: 'no se actualizo',
          //     mensaje: 'no se pudo actualizar el registro',
          //     tipoDeError: TipoExcepcion.desconocido,
          //     codigoError: 560,
          //   );
          // }
          return calificacionMensual;
        },
      );

  Future<List<int>> eliminarCalificaciones(
    Session session, {
    required List<CalificacionMensual> calificaciones,
  }) async =>
      ejecutarOperacionOrm(
        session,
        (session) => CalificacionMensual.db.delete(
          session,
          calificaciones,
        ),
      );

  Future<List<CalificacionMensual>> listarMisCalificacionesAnualesPorAsignatura(
    Session session, {
    required int idUsuario,
    required int idAsignatura,
    required int anio,
  }) async {
    return ejecutarOperacionOrm(
      session,
      (session) => CalificacionMensual.db.find(
        session,
        where: (t) {
          return t.calificacion.estudianteId.equals(idUsuario) &
              t.numeroDeAnio.equals(anio) &
              t.calificacion.asignaturaId.equals(idAsignatura);
        },
        include: CalificacionMensual.include(
          calificacion: Calificacion.include(
            asignatura: Asignatura.include(),
          ),
        ),
      ),
    );
  }

  Future<List<CalificacionMensual>> listarMisCalificacionesMensualesPorMes(
    Session session, {
    required int idUsuario,
    required int numeroDeMes,
    required int anio,
  }) async {
    //TODO(Juanjo): que esto liste por comisión, asi si hay notas
    // que no se hayan cargado tambien aparecen en la lista (con S/C)
    return ejecutarOperacionOrm(
      session,
      (session) => CalificacionMensual.db.find(
        session,
        where: (t) {
          return t.calificacion.estudianteId.equals(idUsuario) &
              t.numeroDeMes.equals(numeroDeMes);
        },
        include: CalificacionMensual.include(
          calificacion: Calificacion.include(
            asignatura: Asignatura.include(),
          ),
        ),
      ),
    );
  }

  Future<List<CalificacionMensual>> obtenerCalificacionesEnvioMensual(
    Session session, {
    Periodo? periodo,
    int? mes,
    int? anio,
    List<int>? idComisiones,
    List<int>? idEstudiantes,
  }) async {
    return await ejecutarOperacionOrm(
      session,
      (session) => CalificacionMensual.db.find(
        session,
        where: (t) {
          final expresionPeriodo = periodo != null
              ? t.calificacion.fechaCreacion.between(
                  periodo.fechaInicio,
                  periodo.fechaFin,
                )
              : t.id.notEquals(null);
          final expresionMes =
              mes != null ? t.numeroDeMes.equals(mes) : t.id.notEquals(null);
          final expresionAnio =
              anio != null ? t.numeroDeAnio.equals(anio) : t.id.notEquals(null);
          final expresionComisiones =
              (idComisiones != null && idComisiones.isNotEmpty)
                  ? t.calificacion.idComision.inSet(idComisiones.toSet())
                  : t.id.notEquals(null);
          final expresionEstudiantes =
              (idEstudiantes != null && idEstudiantes.isNotEmpty)
                  ? t.calificacion.estudianteId.inSet(idEstudiantes.toSet())
                  : t.id.notEquals(null);

          return expresionPeriodo &
              expresionMes &
              expresionAnio &
              expresionComisiones &
              expresionEstudiantes &
              t.calificacion.estudiante.fechaEliminacion.equals(null);
        },
        include: CalificacionMensual.include(calificacion: Calificacion.include(),)
      ),
    );
  }
}
