import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_usuario.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:serverpod/serverpod.dart';

class ServicioUsuario extends Servicio {
  @override
  OrmUsuario get orm => OrmUsuario();

  /// La función "obtenerUsuarioPendiente" recupera un usuario pendiente usando una sesión y devuelve el
  /// resultado.
  ///
  /// Args:
  ///   session (Session): El parámetro "sesión" es un objeto de tipo "Sesión". Se utiliza para
  /// representar una sesión o conexión a una base de datos. Probablemente se esté pasando al método
  /// "orm.obtenerUsuarioPendiente" para recuperar datos de usuario pendientes de la base de datos.
  ///
  /// Returns:
  ///   a `Future<UsuarioPendiente>`.
  Future<UsuarioPendiente?> obtenerUsuarioPendiente(
    Session session, {
    required int idUserInfo,
  }) async =>
      await ejecutarOperacion(
        () => orm.obtenerUsuariosPendiente(
          session,
          idUserInfo: idUserInfo,
        ),
      );

  /// La función `enviarSolicitudRegistro` envía una solicitud de registro para que un usuario pendiente
  /// sea creado en la base de datos.
  ///
  /// Args:
  ///   session (Session): El parámetro de sesión es de tipo Sesión y representa la sesión o conexión
  /// actual a la base de datos. Se utiliza para realizar operaciones de base de datos como crear un
  /// nuevo usuario pendiente de registro.
  ///   usuarioPendiente (UsuarioPendiente): El parámetro "usuarioPendiente" es un objeto de tipo
  /// "UsuarioPendiente" el cual contiene las siguientes propiedades:
  ///
  /// Returns:
  ///   a `Future<UsuarioPendiente>`.
  Future<UsuarioPendiente> enviarSolicitudRegistro(
    Session session, {
    required UsuarioPendiente usuarioPendiente,
  }) async {
    final ahora = DateTime.now();

    final result = await ejecutarOperacion(
      () => orm.crearUsuarioPendiente(
        session,
        usuarioPendiente: UsuarioPendiente(
          idUserInfo: usuarioPendiente.idUserInfo,
          nombre: usuarioPendiente.nombre,
          apellido: usuarioPendiente.apellido,
          dni: usuarioPendiente.dni,
          rolSolicitado: usuarioPendiente.rolSolicitado,
          estadoDeSolitud: EstadoDeSolicitud.pendiente,
          fechaCreacion: ahora,
          ultimaModificacion: ahora,
        ),
      ),
    );
    return result;
  }
}
