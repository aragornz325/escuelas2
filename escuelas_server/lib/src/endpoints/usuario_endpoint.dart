import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/servicios/servicio_usuario.dart';
import 'package:serverpod/serverpod.dart';

class UsuarioEndpoint extends Endpoint with Controller<ServicioUsuario> {
  @override
  ServicioUsuario get servicio => ServicioUsuario();

  Future<Usuario> obtenerDatosDelUsuario(Session session) =>
      ejecutarOperacionControlador(
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
        'obtenerDatosDeSolicitudDelUsuario',
        () => servicio.obtenerDatosDeSolicitudDelUsuario(session),
      );

  /// Obtiene un usuario pendiente a traves de la relacion de [UsuarioPendiente]
  /// con [UserInfo]
  ///
  /// El usuario pendiente se obtiene a traves del id de [UserInfo] dentro del manager.
  Future<UsuarioPendiente?> obtenerUsuarioPendiente(Session session) async =>
      ejecutarOperacionControlador(
        'obtenerUsuarioPendiente',
        () => servicio.obtenerUsuarioPendiente(session),
      );

  /// Obtiene un usuario pendiente a través del id de [UsuarioPendiente]
  Future<UsuarioPendiente?> obtenerUsuarioPendientePorId(
    Session session, {
    required int idUsuarioPendiente,
  }) async =>
      ejecutarOperacionControlador(
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
    required List<Asignatura> asignaturasASolicitar,
  }) async =>
      ejecutarOperacionControlador(
        'enviarSolicitudRegistroDocente',
        () => servicio.enviarSolicitudRegistro(
          session,
          usuarioPendiente: usuarioPendiente,
          asignaturasASolicitar: asignaturasASolicitar,
          esDocente: true,
        ),
      );

  /// La función `enviarSoliciturRegistroAlumno` envía una solicitud de registro
  /// para un usuario pendiente.
  ///
  /// Args:
  ///   session (Session): Un objeto de sesión que representa la sesión del usuario actual. Es necesario
  /// para fines de autenticación y autorización.
  ///   usuarioPendiente (UsuarioPendiente): El parámetro "UserPending" es de tipo "UserPending" y es
  /// obligatorio.
  Future<UsuarioPendiente> enviarSolicitudRegistroAlumno(
    Session session, {
    required UsuarioPendiente usuarioPendiente,
    required ComisionDeCurso comisionDeCurso,
  }) async =>
      ejecutarOperacionControlador(
        'enviarSolicitudRegistroAlumno',
        () => servicio.enviarSolicitudRegistro(
          session,
          usuarioPendiente: usuarioPendiente,
          comisionDeCurso: comisionDeCurso,
        ),
      );

  /// Se utiliza para aceptar o rechazar una solicitud de registro.
  ///
  /// En caso de aprobar la solicitud, se crea un [Usuario].
  Future<void> responderSolicitudDeRegistro(
    Session session, {
    required UsuarioPendiente usuarioPendiente,
  }) =>
      ejecutarOperacionControlador(
        'responderSolicitudDeRegistro',
        () => servicio.responderSolicitudDeRegistro(
          session,
          usuarioPendiente: usuarioPendiente,
        ),
      );

  Future<List<RelacionComisionUsuario>> obtenerListaDeEstudiantesDeComision(
    Session session, {
    required int idComision,
  }) =>
      ejecutarOperacionControlador(
        'obtenerListaDeEstudiantesDeComision',
        () => servicio.obtenerListaDeEstudiantesDeComision(
          session,
          idComision: idComision,
        ),
      );
}
