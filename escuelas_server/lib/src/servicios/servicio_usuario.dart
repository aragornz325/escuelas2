import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_usuario.dart';
import 'package:escuelas_server/src/orms/orm_usuario_pendiente.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart' as auth;

class ServicioUsuario extends Servicio<OrmUsuario> {
  @override
  OrmUsuario get orm => OrmUsuario();

  final OrmUsuarioPendiente _ormUsuarioPendiente = OrmUsuarioPendiente();

  Future<Usuario> obtenerDatosDelUsuario(Session session) async {
    final idUserInfo = await obtenerIdDeUsuarioLogueado(session);

    final datosDeUsuario = await ejecutarOperacion(
      () => orm.buscarUsuario(
        session,
        idUserInfo: idUserInfo,
      ),
    );

    final userInfo = await ejecutarOperacion(
      () => auth.UserInfo.db.findById(
        session,
        datosDeUsuario.idUserInfo,
      ),
    );

    if (userInfo == null) {
      throw ExcepcionCustom(
        titulo: 'Usuario no encontrado.',
        mensaje: 'Usuario no encontrado.',
        tipoDeError: TipoExcepcion.noEncontrado,
        codigoError: 404,
      );
    }

    final userInfoNombresYApellidos = userInfo.fullName?.split('|');

    datosDeUsuario
      ..nombre = userInfoNombresYApellidos?.first ?? ''
      ..apellido = userInfoNombresYApellidos?.last ?? ''
      ..urlFotoDePerfil = userInfo.imageUrl ?? '';

    return datosDeUsuario;
  }

  /// La función "obtenerUsuariosPendientes" recupera usuarios pendientes usando una sesión y devuelve el
  /// resultado.
  ///
  /// Args:
  ///   session (Session): El parámetro "sesión" es un objeto de tipo "Sesión". Se utiliza para
  /// representar una sesión o conexión a una base de datos. Probablemente se esté pasando al método
  /// "orm.obtenerUsuariosPendiente" para recuperar datos de usuario pendientes de la base de datos.
  ///
  /// Returns:
  ///   a `Future<UsuarioPendiente>`.
  Future<UsuarioPendiente> obtenerUsuariosPendientes(Session session) async {
    final result = await ejecutarOperacion(
        () => _ormUsuarioPendiente.obtenerUsuariosPendiente(session));
    return result!;
  }

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
      () => _ormUsuarioPendiente.crearUsuarioPendiente(
        session,
        usuarioPendiente: UsuarioPendiente(
            idUserInfo: usuarioPendiente.idUserInfo,
            nombre: usuarioPendiente.nombre,
            apellido: usuarioPendiente.apellido,
            dni: usuarioPendiente.dni,
            rolSolicitado: usuarioPendiente.rolSolicitado,
            aprobado: usuarioPendiente.aprobado,
            fechaCreacion: ahora,
            ultimaModificacion: ahora),
      ),
    );
    return result;
  }
}
