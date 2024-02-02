import 'package:escuelas_commons/escuelas_commons.dart';
import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/servicio_usuario.dart';
import 'package:serverpod/serverpod.dart';

class UsuarioEndpoint extends Endpoint with Controller<ServicioUsuario> {
  @override
  ServicioUsuario get servicio => ServicioUsuario();

  Future<Usuario> obtenerDatosDelUsuario(Session session) =>
      ejecutarOperacionControlador(
        session,
        'obtenerDatosDelUsuario',
        () => servicio.obtenerDatosDelUsuario(session),
      );

  Future<Usuario> obtenerUsuario(
    Session session, {
    required int idUsuario,
  }) =>
      servicio.obtenerUsuario(
        session,
        idUsuario: idUsuario,
      );

  /// La función "obtenerUsuarioPendiente" devuelve un objeto Futuro que recupera usuario pendiente
  /// usando una sesión.
  ///
  /// Args:
  ///   session (Session): El parámetro de sesión es un objeto que representa la sesión del usuario
  /// actual. Se utiliza para autenticar y autorizar al usuario que realiza la solicitud.
  Future<UsuarioPendiente?> obtenerDatosDeSolicitudDelUsuario(
          Session session) async =>
      ejecutarOperacionControlador(
        session,
        'obtenerDatosDeSolicitudDelUsuario',
        () => servicio.obtenerDatosDeSolicitudDelUsuario(session),
      );

  /// Obtiene un usuario pendiente a traves de la relacion de [UsuarioPendiente]
  /// con [UserInfo]
  ///
  /// El usuario pendiente se obtiene a traves del id de [UserInfo] dentro del manager.
  Future<UsuarioPendiente?> obtenerUsuarioPendiente(Session session) async =>
      ejecutarOperacionControlador(
        session,
        'obtenerUsuarioPendiente',
        () => servicio.obtenerUsuarioPendiente(session),
      );

  /// Obtiene un usuario pendiente a través del id de [UsuarioPendiente]
  Future<UsuarioPendiente?> obtenerUsuarioPendientePorId(
    Session session, {
    required int idUsuarioPendiente,
  }) async =>
      ejecutarOperacionControlador(
        session,
        'obtenerUsuarioPendientePorId',
        () => servicio.obtenerUsuarioPendientePorId(
          session,
          idUsuarioPendiente: idUsuarioPendiente,
        ),
      );

  /// La función "obtenerUsuariosPendientes" devuelve un objeto Futuro que recupera los
  /// usuarios pendientes usando una sesión.
  ///
  /// Args:
  ///   session (Session): El parámetro de sesión es un objeto que representa la sesión del usuario
  /// actual. Se utiliza para autenticar y autorizar al usuario que realiza la solicitud.
  Future<List<UsuarioPendiente>> obtenerUsuariosPendientes(
          Session session) async =>
      ejecutarOperacionControlador(
        session,
        'obtenerUsuariosPendientes',
        () => servicio.obtenerUsuariosPendientes(session),
      );

  /// La función `enviarSolicitudRegistroDocente` envía una solicitud de registro para
  /// un usuario pendiente.
  ///
  /// Args:
  ///   session (Session): Un objeto de sesión que representa la sesión del usuario actual. Es necesario
  /// para fines de autenticación y autorización.
  ///   usuarioPendiente (UsuarioPendiente): El parámetro "UserPending" es de tipo "UserPending" y es
  /// obligatorio.
  Future<UsuarioPendiente> enviarSolicitudRegistroDocente(
    Session session, {
    required UsuarioPendiente usuarioPendiente,
    required List<AsignaturaSolicitada> asignaturasSolicitadas,
  }) async {
    print('entrando');
    final usuario = ejecutarOperacionControlador(
      session,
      'enviarSolicitudRegistroDocente',
      () => servicio.enviarSolicitudRegistro(
        session,
        usuarioPendiente: usuarioPendiente,
        asignaturasSolicitadas: asignaturasSolicitadas,
        esDocente: true,
      ),
    );
    return usuario;
  }

  /// La función `enviarSoliciturRegistroAlumno` envía una solicitud de registro
  /// para un usuario pendiente.

  Future<UsuarioPendiente> enviarSolicitudRegistroAlumno(
    Session session, {
    required UsuarioPendiente usuarioPendiente,
    required int idComisionDeCursoSolicitada,
  }) async =>
      ejecutarOperacionControlador(
        session,
        'enviarSolicitudRegistroAlumno',
        () => servicio.enviarSolicitudRegistro(
          session,
          usuarioPendiente: usuarioPendiente,
          idComisionDeCursoSolicitada: idComisionDeCursoSolicitada,
        ),
      );

  /// Se utiliza para aceptar o rechazar una solicitud de registro.
  ///
  /// En caso de aprobar la solicitud, se crea un [Usuario].
  Future<void> responderSolicitudDeRegistro(
    Session session, {
    required EstadoDeSolicitud estadoDeSolicitud,
    required int idUsuarioPendiente,
  }) =>
      ejecutarOperacionControlador(
        session,
        'responderSolicitudDeRegistro',
        () => servicio.responderSolicitudDeRegistro(
          session,
          estadoDeSolicitud: estadoDeSolicitud,
          idUsuarioPendiente: idUsuarioPendiente,
        ),
      );

  Future<List<RelacionComisionUsuario>> obtenerListaDeEstudiantesDeComision(
    Session session, {
    required int idComision,
  }) =>
      ejecutarOperacionControlador(
        session,
        'obtenerListaDeEstudiantesDeComision',
        () => servicio.obtenerListaDeEstudiantesDeComision(
          session,
          idComision: idComision,
        ),
        permisoRequerido: PermisoDeUsuario.verUsuario,
      );

  Future<UsuariosOrdenados> obtenerUsuariosPorRolSorteados(
    Session session, {
    required int idRol,
    required OrdenarPor ordenarUsuariosPor,
  }) async {
    return await ejecutarOperacionControlador(
      session,
      'obtenerUsuariosPorRolSorteados',
      () => servicio.obtenerUsuariosPorRolSorteados(
        session,
        idRol: idRol,
        ordenarUsuariosPor: ordenarUsuariosPor,
      ),
    );
  }

  Future<Usuario> obtenerInfoBasicaUsuario(
    Session session,
  ) async {
    return await ejecutarOperacionControlador(
      session,
      'obtenerInfoBasicaUsuario',
      () => servicio.obtenerInfoBasicaUsuario(
        session,
      ),
    );
  }

  /// La función `actualizarUsuario` actualiza un usuario en la base de datos.
  /// Devuelve el usuario actualizado.

  Future<Usuario> actualizarUsuario(
    Session session, {
    required Usuario usuario,
  }) async {
    return await ejecutarOperacionControlador(
      session,
      'actualizarUsuario',
      () => servicio.actualizarUsuario(
        session,
        usuario: usuario,
      ),
    );
  }

  // la funcion `softDeleteUsuario` actualiza el campo `fechaEliminacion` de un usuario
  // en la base de datos y devuelve un valor booleano que indica si la operación fue exitosa.

  Future<bool> softDeleteUsuario(
    Session session, {
    required int idUsuario,
  }) async {
    return await ejecutarOperacionControlador(
      session,
      'eliminarUsuario',
      () => servicio.softDeleteUsuario(
        session,
        idUsuario: idUsuario,
      ),
    );
  }
}
