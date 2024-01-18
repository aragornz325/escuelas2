import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_usuario.dart';
import 'package:escuelas_server/src/orms/orm_usuario_comision.dart';
import 'package:escuelas_server/src/orms/orm_usuario_pendiente.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:escuelas_server/src/servicios/servicio_asignatura.dart';
import 'package:escuelas_server/src/servicios/servicio_comision.dart';
import 'package:escuelas_server/src/servicios/servicio_curso.dart';
import 'package:escuelas_server/src/servicios/servicio_rol.dart';
import 'package:escuelas_server/src/utils/listado_alfabetico.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart' as auth;

class ServicioUsuario extends Servicio<OrmUsuario> {
  @override
  OrmUsuario get orm => OrmUsuario();

  final OrmUsuarioPendiente _ormUsuarioPendiente = OrmUsuarioPendiente();

  final OrmUsuarioComision _ormUsuarioComision = OrmUsuarioComision();

  final ServicioAsignatura _servicioAsignatura = ServicioAsignatura();

  final ServicioComision _servicioComision = ServicioComision();

  final ServicioCurso _servicioCurso = ServicioCurso();

  final ServicioRol _servicioRol = ServicioRol();

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
    int? idComisionDeCursoSolicitada,
    bool esDocente = false,
  }) async {
    final ahora = DateTime.now();

    final idUserInfo = await obtenerIdDeUsuarioLogueado(session);

    final usuarioExistente = await ejecutarOperacion(
      () => _ormUsuarioPendiente.obtenerUsuarioPendiente(
        session,
        idUserInfo: idUserInfo,
      ),
    );

    if (usuarioExistente != null) {
      throw ExcepcionCustom(
        titulo: 'Usuario pendiente ya existe.',
        mensaje: 'Usuario pendiente ya existe.',
        tipoDeError: TipoExcepcion.solicitudIncorrecta,
        codigoError: 400,
      );
    }

    final usuarioPendienteCreado = await ejecutarOperacion(
      () => _ormUsuarioPendiente.crearUsuarioPendiente(
        session,
        usuarioPendiente: usuarioPendiente
          ..idUserInfo = idUserInfo
          ..estadoDeSolicitud = EstadoDeSolicitud.pendiente
          ..fechaCreacion = ahora
          ..ultimaModificacion = ahora,
      ),
    );

    if (usuarioPendienteCreado.id == null) {
      throw ExcepcionCustom(
        titulo: 'Error al crear solicitud.',
        mensaje: 'Error al crear solicitud.',
        tipoDeError: TipoExcepcion.desconocido,
        codigoError: 500,
      );
    }

    if (esDocente) {
      List<AsignaturaSolicitada> asignaturasSolicitadas = [];

      // Crea  una lista de [AsignaturaSolicitada] a partir de las asignaturas a solicitar.
      for (final asignatura in (asignaturasASolicitar ?? <Asignatura>[])) {
        if (asignatura.id == null) {
          continue;
        }
        asignaturasSolicitadas.add(
          AsignaturaSolicitada(
            asignaturaId: asignatura.id!,
            idUsuarioPendiente: usuarioPendienteCreado.id!,
            ultimaModificacion: ahora,
            fechaCreacion: ahora,
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
      if (idComisionDeCursoSolicitada == null) {
        throw ExcepcionCustom(
          titulo: 'Error de solicitud.',
          mensaje: 'Debe ingresarse un ID de comisión de curso solicitada.',
          tipoDeError: TipoExcepcion.solicitudIncorrecta,
          codigoError: 400,
        );
      }

      /// TODO(anyone): BORRAR CON EL CAMBIO EN EL CAMPO `comisionSolicitada` DEL MODELO `UsuarioPendiente`.
      final comisionSolicitadaCreada = await ejecutarOperacion(
        () => _servicioComision.crearComisionSolicitada(
          session,
          idComision: idComisionDeCursoSolicitada,
          idUsuarioPendiente: usuarioPendienteCreado.id!,
        ),
      );

      if (comisionSolicitadaCreada.id == null) {
        throw ExcepcionCustom(
          titulo: 'Error al crear comision solicitada.',
          mensaje: 'Error al crear comision solicitada.',
          tipoDeError: TipoExcepcion.desconocido,
          codigoError: 500,
        );
      }
      usuarioPendienteCreado.comisionSolicitadaId = comisionSolicitadaCreada.id!;

      await actualizarUsuarioPendiente(
        session,
        usuarioPendiente: usuarioPendienteCreado,
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

  /// La función `actualizarUsuarioPendiente` actualiza un usuario pendiente.
  Future<void> responderSolicitudDeRegistro(
    Session session, {
    required UsuarioPendiente usuarioPendiente,
  }) async {
    switch (usuarioPendiente.estadoDeSolicitud) {
      case EstadoDeSolicitud.aprobado:
        await _onSolicitudAprobada(
          session,
          usuarioPendiente: usuarioPendiente,
        );
      case EstadoDeSolicitud.rechazado:
        return ejecutarOperacion(
          () => _ormUsuarioPendiente.eliminarUsuarioPendiente(
            session,
            id: usuarioPendiente.id ?? 0,
          ),
        );
      case EstadoDeSolicitud.pendiente:
        return;
    }
  }

  Future<void> _onSolicitudAprobada(
    Session session, {
    required UsuarioPendiente usuarioPendiente,
  }) async {
    final ahora = DateTime.now();

    final usuario = await ejecutarOperacion(
      () => orm.crearUsuario(
        session,
        nuevoUsuario: Usuario(
          idUserInfo: usuarioPendiente.idUserInfo,
          nombre: usuarioPendiente.nombre,
          apellido: usuarioPendiente.apellido,
          urlFotoDePerfil: usuarioPendiente.urlFotoDePerfil,
          fechaCreacion: ahora,
          ultimaModificacion: ahora,
        ),
      ),
    );

    final idUsuario = usuario.id;
    final asignaturasSolicitadas = usuarioPendiente.asignaturasSolicitadas;
    final comisionSolicitada = usuarioPendiente.comisionSolicitada;

    if (idUsuario == null) {
      throw ExcepcionCustom(
        titulo: 'Error al crear el usuario.',
        mensaje: 'Error al crear el usuario.',
        tipoDeError: TipoExcepcion.noEncontrado,
        codigoError: 404,
      );
    }

    await ejecutarOperacion(
      () => _servicioRol.asignarRolAUsuario(
        session,
        idUsuario: idUsuario,
        idRol: usuarioPendiente.idRolSolicitado,
      ),
    );

    if (asignaturasSolicitadas != null && asignaturasSolicitadas.isNotEmpty) {
      await ejecutarOperacion(
        () => _servicioAsignatura.asignarAsignaturasSolicitadas(
          session,
          asignaturasSolicitadas: asignaturasSolicitadas,
          usuarioId: idUsuario,
        ),
      );
    } else if (comisionSolicitada != null) {
      await ejecutarOperacion(
        () => _servicioComision.asignarUsuarioAComision(
          session,
          idComision: comisionSolicitada.comisionId,
          idUsuario: idUsuario,
        ),
      );
    }

    return ejecutarOperacion(
      () => _ormUsuarioPendiente.actualizarUsuarioPendiente(
        session,
        usuarioPendiente: usuarioPendiente..ultimaModificacion = ahora,
      ),
    );
  }

  Future<List<RelacionComisionUsuario>> obtenerListaDeEstudiantesDeComision(
    Session session, {
    required int idComision,
  }) async {
    return ejecutarOperacion(
      () => _ormUsuarioComision.obtenerRelacionesComisionUsuario(
        session,
        idComision: idComision,
      ),
    );
  }

  Future<UsuariosOrdenados> obtenerUsuariosPorRolSorteados(
    Session session, {
    required int idRol,
    required OrdenarPor ordenarUsuariosPor,
  }) async {
    final usuarios = await ejecutarOperacion(
      () => orm.obtenerUsuarios(session, idRol: idRol),
    );

    final usuariosListados = <UsuariosListados>[];

    final opcionesDeOrdenamiento = <OrdenarPor>[OrdenarPor.apellido];

    final contienenAsignaturas = usuarios.any(
      (usuario) =>
          usuario.asignaturas != null && usuario.asignaturas!.isNotEmpty,
    );

    if (contienenAsignaturas) {
      opcionesDeOrdenamiento.add(OrdenarPor.asignatura);
    }

    final contienenComisiones = usuarios.any(
      (usuario) => usuario.comisiones != null && usuario.comisiones!.isNotEmpty,
    );

    if (contienenComisiones) {
      opcionesDeOrdenamiento.add(OrdenarPor.curso);
    }

    switch (ordenarUsuariosPor) {
      case OrdenarPor.apellido:
        for (var letra in listaAlfabetica) {
          final usuariosLetra = usuarios
              .where((usuario) => usuario.apellido
                  .toUpperCase()
                  .startsWith(letra.toUpperCase()))
              .toList();

          usuariosListados.add(
            UsuariosListados(
              etiquetaDelIndexListado: letra,
              usuarios: usuariosLetra,
            ),
          );
        }
      case OrdenarPor.curso:
        final comisiones = await ejecutarOperacion(
          () => _servicioComision.obtenerComisiones(session),
        );

        for (var comision in comisiones) {
          final usuariosDeComision = usuarios
              .where((usuario) =>
                  usuario.asignaturas?.any((comisionUsuario) =>
                      comisionUsuario.asignaturaId == comision.id) ??
                  false)
              .toList();

          usuariosListados.add(
            UsuariosListados(
              etiquetaDelIndexListado: comision.nombre,
              usuarios: usuariosDeComision,
            ),
          );
        }

      case OrdenarPor.asignatura:
        final asignaturas = await ejecutarOperacion(
          () => _servicioAsignatura.obtenerAsignaturas(session),
        );

        for (var asignatura in asignaturas) {
          final usuariosAsignatura = usuarios
              .where((usuario) =>
                  usuario.asignaturas?.any((asignaturaUsuario) =>
                      asignaturaUsuario.asignaturaId == asignatura.id) ??
                  false)
              .toList();

          usuariosListados.add(
            UsuariosListados(
              etiquetaDelIndexListado: asignatura.nombre,
              usuarios: usuariosAsignatura,
            ),
          );
        }
    }

    return UsuariosOrdenados(
      opcionesDeOrdenamiento: opcionesDeOrdenamiento,
      usuariosListados: usuariosListados,
    );
  }
}
