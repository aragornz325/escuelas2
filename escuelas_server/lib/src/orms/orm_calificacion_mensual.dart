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
                  t.calificacion.idAsignatura.equals(idAsignatura) &
                  t.numeroDeMes.equals(numeroDeMes);
            }

            return t.calificacion.idComision.equals(idComision) &
                t.calificacion.idAsignatura.equals(idAsignatura);
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
          print(calificacionesMensuales);
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
}
