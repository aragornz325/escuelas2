import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_usuario.dart';
import 'package:escuelas_server/src/orms/orm_usuario_pendiente.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:escuelas_server/src/servicios/servicio_asignatura.dart';
import 'package:escuelas_server/src/servicios/servicio_comision.dart';
import 'package:escuelas_server/src/servicios/servicio_curso.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart' as auth;

class ServicioUsuario extends Servicio<OrmUsuario> {
  @override
  OrmUsuario get orm => OrmUsuario();

  final OrmUsuarioPendiente _ormUsuarioPendiente = OrmUsuarioPendiente();

  final ServicioAsignatura _servicioAsignatura = ServicioAsignatura();

  final ServicioComision _servicioComision = ServicioComision();

  final ServicioCurso _servicioCurso = ServicioCurso();

  Future<Usuario> obtenerDatosDelUsuario(Session session) async {
    final idUserInfo = await obtenerIdDeUsuarioLogueado(session);

    final datosDeUsuario = await ejecutarOperacion(
      () => orm.obtenerUsuario(
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

  Future<Usuario> obtenerUsuario(
    Session session, {
    required int idUsuario,
  }) async {
    return orm.obtenerUsuario(
      session,
      idUsuario: idUsuario,
    );
  }

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
  Future<UsuarioPendiente?> obtenerDatosDeSolicitudDelUsuario(
      Session session) async {
    final idUserInfo = await obtenerIdDeUsuarioLogueado(session);

    return await ejecutarOperacion(
      () => _ormUsuarioPendiente.obtenerUsuarioPendiente(
        session,
        idUserInfo: idUserInfo,
      ),
    );
  }

  /// Obtiene un usuario pendiente a traves de la relacion de [UsuarioPendiente]
  /// con [UserInfo]
  ///
  /// El usuario pendiente se obtiene a traves del id de [UserInfo] dentro del manager.
  Future<UsuarioPendiente?> obtenerUsuarioPendiente(Session session) async =>
      ejecutarOperacion(
        () async => _ormUsuarioPendiente.obtenerUsuarioPendiente(
          session,
          idUserInfo: await obtenerIdDeUsuarioLogueado(session),
        ),
      );

  /// Obtiene un usuario pendiente a través del id de [UsuarioPendiente]
  Future<UsuarioPendiente?> obtenerUsuarioPendientePorId(
    Session session, {
    required int idUsuarioPendiente,
  }) async {
    return await ejecutarOperacion(
      () => _ormUsuarioPendiente.obtenerUsuarioPendiente(
        session,
        idUsuarioPendiente: idUsuarioPendiente,
      ),
    );
  }

  /// La función "obtenerUsuariosPendientes" recupera los usuarios pendientes usando una sesión y devuelve el
  /// resultado.
  ///
  /// Args:
  ///   session (Session): El parámetro "sesión" es un objeto de tipo "Sesión". Se utiliza para
  /// representar una sesión o conexión a una base de datos. Probablemente se esté pasando al método
  /// "orm.obtenerUsuariosPendientes" para recuperar datos de usuario pendientes de la base de datos.
  Future<List<UsuarioPendiente>> obtenerUsuariosPendientes(
          Session session) async =>
      await ejecutarOperacion(
        () => _ormUsuarioPendiente.obtenerUsuariosPendientes(session),
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
    List<Asignatura>? asignaturasASolicitar,
    ComisionDeCurso? comisionDeCurso,
    bool esDocente = false,
  }) async {
    final ahora = DateTime.now();

    final usuarioPendienteCreado = await ejecutarOperacion(
      () => _ormUsuarioPendiente.crearUsuarioPendiente(
        session,
        usuarioPendiente: UsuarioPendiente(
          idUserInfo: usuarioPendiente.idUserInfo,
          nombre: usuarioPendiente.nombre,
          apellido: usuarioPendiente.apellido,
          urlFotoDePerfil: usuarioPendiente.urlFotoDePerfil,
          dni: usuarioPendiente.dni,
          rolSolicitado: usuarioPendiente.rolSolicitado,
          estadoDeSolicitud: EstadoDeSolicitud.pendiente,
          fechaCreacion: ahora,
          ultimaModificacion: ahora,
        ),
      ),
    );

    if (esDocente) {
      List<AsignaturaSolicitada> asignaturasSolicitadas = [];

      // Crea  una lista de [AsignaturaSolicitada] a partir de las asignaturas a solicitar.
      for (final asignatura in (asignaturasASolicitar ?? <Asignatura>[])) {
        final cursoSolicitado = await _servicioCurso.obtenerCursoPorId(
          session,
          id: asignatura.idCurso,
        );

        asignaturasSolicitadas.add(
          AsignaturaSolicitada(
            idAsignatura: asignatura.id ?? 0,
            idUsuarioPendiente: usuarioPendienteCreado.id ?? 0,
            ultimaModificacion: ahora,
            fechaCreacion: ahora,
            nombreAsignatura: asignatura.nombre,
            nombreCurso: cursoSolicitado.nombre,
          ),
        );
      }

      await ejecutarOperacion(
        () => _servicioAsignatura.crearAsignaturasSolicitadas(
          session,
          asignaturasSolicitadas: asignaturasSolicitadas,
        ),
      );
    } else {
      await ejecutarOperacion(
        () => _servicioComision.crearComisionSolicitada(
          session,
          idComision: comisionDeCurso?.id ?? 0,
          idUsuarioPendiente: usuarioPendienteCreado.id ?? 0,
          nombreComision: comisionDeCurso?.nombre ?? '',
        ),
      );
    }

    return usuarioPendienteCreado;
  }

  /// La función `actualizarUsuarioPendiente` actualiza un usuario pendiente.
  Future<void> actualizarUsuarioPendiente(
    Session session, {
    required UsuarioPendiente usuarioPendiente,
  }) async {
    final ahora = DateTime.now();

    return ejecutarOperacion(
      () => _ormUsuarioPendiente.actualizarUsuarioPendiente(
        session,
        usuarioPendiente: usuarioPendiente..ultimaModificacion = ahora,
      ),
    );
  }
}
