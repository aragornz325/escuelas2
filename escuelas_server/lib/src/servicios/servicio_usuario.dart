import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_direccionesDeEmail.dart';
import 'package:escuelas_server/src/orms/orm_userInfo.dart';
import 'package:escuelas_server/src/orms/orm_usuario.dart';
import 'package:escuelas_server/src/orms/orm_usuario_comision.dart';
import 'package:escuelas_server/src/orms/orm_usuario_pendiente.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:escuelas_server/src/servicios/servicio_asignatura.dart';
import 'package:escuelas_server/src/servicios/servicio_comision.dart';
import 'package:escuelas_server/src/servicios/servicio_direccion_de_mail.dart';
import 'package:escuelas_server/src/servicios/servicio_rol.dart';
import 'package:escuelas_server/src/servicios/servicio_user_info.dart';
import 'package:escuelas_server/src/utils/listado_alfabetico.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart' as auth;

class ServicioUsuario extends Servicio<OrmUsuario> {
  @override
  OrmUsuario get orm => OrmUsuario();

  OrmUserInfo get ormUserInfo => OrmUserInfo();

  ServicioUserInfo get userInfo => ServicioUserInfo();

  ServicioDireccionDeMail get servicioDeEmail => ServicioDireccionDeMail();

  final OrmUsuarioPendiente _ormUsuarioPendiente = OrmUsuarioPendiente();

  final OrmUsuarioComision _ormUsuarioComision = OrmUsuarioComision();

  final ServicioAsignatura _servicioAsignatura = ServicioAsignatura();

  final ServicioComision _servicioComision = ServicioComision();

  final ServicioRol _servicioRol = ServicioRol();

  Future<Usuario> obtenerInfoBasicaUsuario(Session session) async {
    final idUserInfo = await obtenerIdDeUsuarioLogueado(session);
    return await ejecutarOperacion(
      () async => orm.obtenerInfoBasicaUsuario(
        session,
        idUserInfo: idUserInfo,
      ),
    );
  }

  Future<String?> obtenerEmailConDni(
    Session session, {
    required String dni,
  }) async {
    return ormUserInfo.traerEmailDeUsuarioConUseridentifier(
      session,
      userIdentifier: dni,
    );
  }

  Future<Usuario> crearUsuario(
    Session session, {
    required Usuario nuevoUsuario,
  }) async {
    final ahora = DateTime.now();

    final usuario = await ejecutarOperacion(
      () => orm.crearUsuario(
        session,
        nuevoUsuario: nuevoUsuario
          ..fechaCreacion = ahora
          ..ultimaModificacion = ahora,
      ),
    );

    if (usuario.id == null) {
      throw ExcepcionCustom(tipoDeError: TipoExcepcion.desconocido);
    }

    final userInfo = await ormUserInfo.traerInformacionDeUsuario(session,
        idUserInfo: usuario.idUserInfo);

    if (userInfo.email == null) {
      throw ExcepcionCustom(tipoDeError: TipoExcepcion.desconocido);
    }

    await ejecutarOperacion(
      () => OrmDireccionesdeEmail().insertarUnRegistroEnDb(
        session,
        nuevoRegistro: DireccionDeEmail(
          usuarioId: usuario.id!,
          direccionDeEmail: userInfo.email!,
          etiqueta: EtiquetaDireccionEmail.personalPrimario,
          ultimaModificacion: ahora,
          fechaCreacion: ahora,
        ),
      ),
    );

    return usuario;
  }

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

    final userInfoNombresYApellidos = userInfo.fullName?.split(' ');

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
    List<AsignaturaSolicitada>? asignaturasSolicitadas,
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
          ..ultimaModificacion = ahora
          ..comisionSolicitadaId = idComisionDeCursoSolicitada,
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
      // Inserta id de usuario pendiente en asignaturas solicitadas
      final asignaturas = asignaturasSolicitadas
          ?.map((a) => a..idUsuarioPendiente = usuarioPendienteCreado.id ?? 0)
          .toList();

      await ejecutarOperacion(
        () => _servicioAsignatura.crearAsignaturasSolicitadas(
          session,
          asignaturasSolicitadas: asignaturas ?? [],
        ),
      );
    }

    return usuarioPendienteCreado;
  }

  Future<UsuarioPendiente> enviarSolicitudRegistroDirectivo(
    Session session, {
    required UsuarioPendiente usuarioPendiente,
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
    required EstadoDeSolicitud estadoDeSolicitud,
    required int idUsuarioPendiente,
  }) async {
    switch (estadoDeSolicitud) {
      case EstadoDeSolicitud.aprobado:
        await _onSolicitudAprobada(
          session,
          idUsuarioPendiente: idUsuarioPendiente,
        );
      case EstadoDeSolicitud.rechazado:
        return ejecutarOperacion(
          () => _ormUsuarioPendiente.eliminarUsuarioPendiente(
            session,
            id: idUsuarioPendiente,
          ),
        );
      case EstadoDeSolicitud.pendiente:
        return;
    }
  }

  Future<void> _onSolicitudAprobada(
    Session session, {
    required int idUsuarioPendiente,
  }) async {
    final ahora = DateTime.now();

    final usuarioPendiente = await ejecutarOperacion(
      () => _ormUsuarioPendiente.obtenerUsuarioPendiente(
        session,
        idUsuarioPendiente: idUsuarioPendiente,
      ),
    );

    if (usuarioPendiente == null) {
      throw ExcepcionCustom(
        titulo: 'Usuario pendiente no encontrado.',
        mensaje: 'Usuario pendiente no encontrado.',
        tipoDeError: TipoExcepcion.noEncontrado,
        codigoError: 404,
      );
    }

    if (usuarioPendiente.estadoDeSolicitud != EstadoDeSolicitud.pendiente) {
      throw ExcepcionCustom(
        titulo: 'La solicitud de registro ya fue respondida.',
        mensaje: 'La solicitud de registro ya fue respondida.',
        tipoDeError: TipoExcepcion.solicitudIncorrecta,
        codigoError: 404,
      );
    }

    final usuario = await ejecutarOperacion(
      () => crearUsuario(
        session,
        nuevoUsuario: Usuario(
          idUserInfo: usuarioPendiente.idUserInfo,
          nombre: usuarioPendiente.nombre,
          apellido: usuarioPendiente.apellido,
          dni: usuarioPendiente.dni,
          urlFotoDePerfil: usuarioPendiente.urlFotoDePerfil,
          fechaCreacion: ahora,
          ultimaModificacion: ahora,
          necesitaCambiarPassword: false,
        ),
      ),
    );

    final idUsuario = usuario.id;

    final comisionSolicitada = usuarioPendiente.comisionSolicitada;
    final asignaturasSolicitadas = usuarioPendiente.asignaturasSolicitadas;

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
        // TODO(anyone):
        // Por ahora el id de organizacion siempre va a ser 1
        // ese id va a ser referente a la organizacion de la escuela
        // `Redemptoris Missio`
        idOrganizacion: 1,
      ),
    );

    if (asignaturasSolicitadas!.isNotEmpty) {
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
          idComision: comisionSolicitada.id!,
          idUsuario: idUsuario,
        ),
      );
    }

    await ejecutarOperacion(
      () => _ormUsuarioPendiente.actualizarUsuarioPendiente(
        session,
        usuarioPendiente: usuarioPendiente
          ..estadoDeSolicitud = EstadoDeSolicitud.aprobado
          ..ultimaModificacion = ahora,
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

  Future<List<Usuario>> listarUsuariosSegunRol(
    Session session, {
    required int idRol,
    required String? nombre,
    required String? apellido,
  }) async {
    return await ejecutarOperacion(
      () => orm.obtenerUsuarios(
        session,
        idRol: idRol,
        nombre: nombre,
        apellido: apellido,
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
        Map<String, List<Usuario>> usuariosPorLetra = {};
        usuarios
          ..sort((u1, u2) => u1.apellido.compareTo(u2.apellido))
          ..forEach((u) {
            var letra = u.apellido[0].toUpperCase();
            usuariosPorLetra[letra] = [u, ...usuariosPorLetra[letra] ?? []];
          });
        usuariosPorLetra.forEach((key, value) {
          usuariosListados.add(
            UsuariosListados(
              etiquetaDelIndexListado: key,
              usuarios: value,
            ),
          );
        });

      case OrdenarPor.curso:
        final comisiones = await ejecutarOperacion(
          () => _servicioComision.obtenerComisiones(session),
        );

        for (var comision in comisiones) {
          final usuariosDeComision = usuarios
              .where((usuario) =>
                  usuario.comisiones?.any((comisionUsuario) =>
                      comisionUsuario.comisionId == comision.id) ??
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

  Future<List<Usuario>> obtenerUsuariosEnLote(
    Session session, {
    required List<int> ids,
  }) async =>
      ejecutarOperacion(
        () => orm.obtenerUsuariosEnLote(
          session,
          ids: ids,
        ),
      );

  Future<List<int>> obtenerIdsDeUsuariosDocentes(
    Session session,
  ) async =>
      ejecutarOperacion(
        () => orm.obtenerIdsDeUsuariosDocentes(
          session,
        ),
      );

  /// La función `actualizarUsuario` actualiza un usuario con un objeto `Usuario` usando una sesión y un ORM.
  /// Args:
  ///  session (Session): Un objeto de sesión utilizado para operaciones de bases de datos.
  /// usuario (Usuario): Un objeto `Usuario` que representa la información del usuario que se va a actualizar.
  /// Returns:
  /// a `Futuro<Usuario>`.
  Future<Usuario> actualizarUsuario(
    Session session, {
    required Usuario usuario,
  }) async {
    return await ejecutarOperacion(() async {
      final ahora = DateTime.now();

      logger.info(
        'buscando el UserInfo',
      );
      final userInfoData = await userInfo.traerInformacionDeUsuario(
        session,
        idUserInfo: usuario.idUserInfo,
      );
      logger.info(
        'userInfo encontrado: $userInfo',
      );

      logger.info(
        'verificando direccion de Email',
      );
      final direccionDeEmail = await servicioDeEmail.obtenerDireccionDeEmail(
        session,
        idUsuario: usuario.id!,
      );

      if (direccionDeEmail.id != 0 &&
          usuario.direccionesDeEmail?.first != null) {
        logger.info(
          'direccion de Email encontrada: se va a actualizar',
        );
        await servicioDeEmail.actualizarDireccionDeEmail(session,
            direccionDeEmail: usuario.direccionesDeEmail!.first);
      } else {
        logger.info(
          'direccion de Email no encontrada: se va a crear',
          await servicioDeEmail.crearDireccionDeEmail(
            session,
            idUsuario: usuario.id!,
            idUserInfo: usuario.idUserInfo,
          ),
        );
      }

      final emailAuth = await auth.EmailAuth.db.findFirstRow(
        session,
        where: (p0) => p0.userId.equals(userInfoData.id),
      );

      String email = '';
      if (usuario.direccionesDeEmail != null &&
          usuario.direccionesDeEmail!.isNotEmpty) {
        email = usuario.direccionesDeEmail!.first.direccionDeEmail;
      } else {
        email = userInfoData.userIdentifier;
      }

      logger.info(
        'creando userInfo a partir de usuario: $usuario',
      );
      final userInfoADb = auth.UserInfo(
        id: userInfoData.id,
        userIdentifier: usuario.dni ?? userInfoData.userIdentifier,
        userName: usuario.nombre,
        fullName: '${usuario.nombre};${usuario.apellido}',
        email: usuario.direccionesDeEmail?.first.direccionDeEmail ??
            userInfoData.email,
        created: userInfoData.created,
        scopeNames: userInfoData.scopeNames,
        blocked: userInfoData.blocked,
        imageUrl: usuario.urlFotoDePerfil,
      );

      logger.info(
        'iniciando la transaccion para actualizar el usuario y el userInfo',
      );

      final resultado = await session.dbNext.transaction(
        (transaction) async {
          await Usuario.db.update(
            session,
            [
              usuario..ultimaModificacion = ahora,
            ],
            transaction: transaction,
          );
          await auth.UserInfo.db.update(
            session,
            [userInfoADb],
            transaction: transaction,
          );
          if (emailAuth != null) {
            await auth.EmailAuth.db.updateRow(
                session,
                emailAuth
                  ..email =
                      usuario.direccionesDeEmail?.first.direccionDeEmail ??
                          userInfoData.email!);
          }
          return true;
        },
      );

      if (!resultado) {
        throw ExcepcionCustom(
          titulo: 'Error al actualizar el usuario',
          mensaje: 'error en la transaccion de la base de datos',
          tipoDeError: TipoExcepcion.desconocido,
          codigoError: 500,
        );
      }

      logger.info(
        'usuario actualizado con exito... obteniendo datos del usuario actualizado',
      );
      final usuarioActualizado = await obtenerDatosDelUsuario(
        session,
      );
      return usuarioActualizado;
    });
  }

  Future<bool> softDeleteUsuario(
    Session session, {
    required int idUsuario,
  }) async {
    return await ejecutarOperacion(() async {
      final ahora = DateTime.now();
      logger.info('obteniendo usuario');
      final usuario = await orm.obtenerUsuario(
        session,
        idUsuario: idUsuario,
      );

      logger.info('actualizando usuario');
      await orm.actualizarUsuario(
        session,
        usuario: usuario
          ..fechaEliminacion = ahora
          ..ultimaModificacion = ahora,
      );
      logger.info('usuario eliminado con exito');
      return true;
    });
  }

  Future<DireccionDeEmail> agregarDireccionDeEmailDeContactoAUsuario(
    Session session, {
    required int idUsuario,
    required String direccionDeEmail,
    required EtiquetaDireccionEmail etiqueta,
  }) async {
    if (etiqueta == EtiquetaDireccionEmail.personalPrimario) {
      throw ExcepcionCustom(tipoDeError: TipoExcepcion.solicitudIncorrecta);
    }
    final ahora = DateTime.now();
    final usuario = await ejecutarOperacion(
      () {
        return orm.obtenerUnRegistroEnDbPorFiltro(
          session,
          filtroCondicional: Usuario.t.id.equals(
                idUsuario,
              ) &
              Usuario.t.fechaEliminacion.equals(null),
        );
      },
    );

    if (usuario == null) {
      throw ExcepcionCustom(tipoDeError: TipoExcepcion.solicitudIncorrecta);
    }

    final direccionDeEmailAgregada = await ejecutarOperacion(
      () => OrmDireccionesdeEmail().crearDireccionDeEmail(
        session,
        direccionDeMail: DireccionDeEmail(
          usuarioId: idUsuario,
          direccionDeEmail: direccionDeEmail,
          etiqueta: etiqueta,
          ultimaModificacion: ahora,
          fechaCreacion: ahora,
        ),
      ),
    );

    return direccionDeEmailAgregada;
  }

  Future<int> eliminarDireccionDeEmailDeContactoDeUsuario(
    Session session, {
    required int idDireccionDeEmail,
  }) async {
    final direccionBorrada = await OrmDireccionesdeEmail()
        .borrarFisicamenteVariosRegistrosEnDbPorFiltro(
      session,
      filtroCondicional: DireccionDeEmail.t.id.equals(idDireccionDeEmail),
    );

    if (direccionBorrada.isEmpty) {
      return 0;
    }

    return direccionBorrada.first;
  }

  Future<DireccionDeEmail> modificarDireccionDeEmailDeContactoDeUsuario(
    Session session, {
    required int idDireccionDeEmail,
    required String nuevaDireccionDeEmail,
    EtiquetaDireccionEmail? nuevaEtiqueta,
  }) async {
    final direccionDeEmailAModificar =
        await OrmDireccionesdeEmail().obtenerDireccionDeEmailPorId(
      session,
      idDireccionDeEmail: idDireccionDeEmail,
    );

    final usuario = await orm.obtenerUnRegistroEnDbPorId(session,
        idDelRegistro: direccionDeEmailAModificar.usuarioId);

    if (direccionDeEmailAModificar.etiqueta ==
        EtiquetaDireccionEmail.personalPrimario) {
      await _modificarDireccionDeEmailDeCuentaDeUsuario(
        session,
        usuario!.idUserInfo,
        nuevaDireccionDeEmail,
      );
    }

    return await OrmDireccionesdeEmail().actualizarUnRegistroEnDb(
      session,
      registroEnDb: direccionDeEmailAModificar
        ..direccionDeEmail = nuevaDireccionDeEmail
        ..etiqueta = nuevaEtiqueta ?? direccionDeEmailAModificar.etiqueta,
    );
  }

  Future<bool> _modificarDireccionDeEmailDeCuentaDeUsuario(
    Session session,
    int idUserInfo,
    String nuevaDireccionDeEmail,
  ) async {
    final emailAuth = await ejecutarOperacion(
      () => auth.EmailAuth.db.findFirstRow(
        session,
        where: (p0) => p0.userId.equals(idUserInfo),
      ),
    );

    final userInfo = await ejecutarOperacion(
      () => ormUserInfo.traerInformacionDeUsuario(
        session,
        idUserInfo: idUserInfo,
      ),
    );

    await ejecutarOperacion(
      () => auth.EmailAuth.db.updateRow(
        session,
        emailAuth!..email = nuevaDireccionDeEmail,
      ),
    );

    await ejecutarOperacion(
      () => auth.UserInfo.db.updateRow(
        session,
        userInfo..email = nuevaDireccionDeEmail,
      ),
    );

    return true;
  }
}
