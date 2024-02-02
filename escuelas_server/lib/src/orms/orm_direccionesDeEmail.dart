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

  /// La función `obtenerDireccionDeEmail` recupera una dirección de correo electrónico asociada con un
  /// ID de usuario de una base de datos usando un ORM.
  /// 
  /// Args:
  ///   session (Session): 
  ///   idUsuario (int): La identificación del usuario del cual desea obtener la dirección de correo
  /// electrónico.
  
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
      return DireccionDeEmail(
        id: 0,
        usuarioId: 0,
        direccionDeEmail: '',
        fechaCreacion: DateTime.now(),
        ultimaModificacion: DateTime.now(),
      );
    }

    return direccionDeEmail;
  }

  /// La función `obtenerDireccionDeEmailPorId` recupera una dirección de correo electrónico por su ID y
  /// lanza una excepción si no se encuentra la dirección.
  /// 
  /// Args:
  ///   session (Session): 
  ///   idDireccionDeEmail (int): El parámetro "idDireccionDeEmail" es un número entero que representa
  /// el identificador único de una dirección de correo electrónico.

  Future<DireccionDeEmail> obtenerDireccionDeEmailPorId(
    Session session, {
    required int idDireccionDeEmail,
  }) async {
    final direccionDeEmail = await ejecutarOperacionOrm(
      session,
      (session) async => await DireccionDeEmail.db.findById(
        session,
        idDireccionDeEmail,
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

 /// La función `actualizarDireccionDeEmail` actualiza una dirección de correo electrónico determinada
 /// en una base de datos usando un ORM y devuelve la dirección de correo electrónico actualizada.
 /// 
 ///   direccionDeEmail (DireccionDeEmail): El parámetro `direccionDeEmail` es de tipo
 /// `DireccionDeEmail` y es obligatorio. Representa la dirección de correo electrónico que debe
 /// actualizarse.

  Future<DireccionDeEmail> actualizarDireccionDeEmail(
    Session session, {
    required DireccionDeEmail direccionDeEmail,
  }) async {
    final direccionDeEmailActualizada = await ejecutarOperacionOrm(
      session,
      (session) => DireccionDeEmail.db.update(
        session,
        [direccionDeEmail],
      ),
    );

    if (direccionDeEmailActualizada.isEmpty) {
      throw ExcepcionCustom(
        titulo: 'no se actualizo',
        mensaje: 'no se actualizo la direccion de mail solicitada',
        tipoDeError: TipoExcepcion.desconocido,
        codigoError: 560,
      );
    }

    return direccionDeEmailActualizada.first;
  }
}
