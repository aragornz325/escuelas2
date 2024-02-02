import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmDireccionesdeEmail extends ORM {
  Future<DireccionDeEmail> crearDireccionDeEmail(
    Session session, {
    required DireccionDeEmail direccionDeMail,
  }) async {
    final direccionDeEmail = await ejecutarOperacionOrm(
      session,
      (session) => DireccionDeEmail.db.insert(
        session,
        [direccionDeMail],
      ),
    );

    if (direccionDeEmail.isEmpty) {
      throw ExcepcionCustom(
        titulo: 'no se pudo crear',
        mensaje: 'no se creo la direccion de mail debido a un error inesperado',
        tipoDeError: TipoExcepcion.desconocido,
        codigoError: 560,
      );
    }

    return direccionDeEmail.first;
  }



  Future<DireccionDeEmail> obtenerDireccionDeEmail(
    Session session, {
    required int idUsuario,
  }) async {
    final direccionDeEmail = await ejecutarOperacionOrm(
      session,
      (session) async => await DireccionDeEmail.db.findFirstRow(
        session,
        where: (t) => t.usuarioId.equals(idUsuario),
      ),
    );

    if (direccionDeEmail == null) {
      throw ExcepcionCustom(
        titulo: 'no se encontro',
        mensaje: 'no se encontro la direccion de mail solicitada',
        tipoDeError: TipoExcepcion.noEncontrado,
        codigoError: 404,
      );
    }

    return direccionDeEmail;
  }
}
