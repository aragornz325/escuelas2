import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/isar/modelos/usuario/usuario_isar.dart';
import 'package:escuelas_flutter/isar/modelos/usuario_pendiente/usuario_pendiente_isar.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

/// Clase de el servicio de Isar que inicializa la DB local y que tiene
///  funciones de CRUD.
abstract class IsarServicio {
  /// Base de datos isar
  static late Isar isar;

  /// Getter de la instancia de Isar
  Isar get instanciaIsar => isar;

  /// Lista de usuarios actuales
  final List<UsuarioIsar> listaUsuariosActuales = [];

  /// Lista de usuarios pendientes actuales
  final List<UsuarioPendienteIsar> listaUsuariosPendientesActuales = [];

  /// Inicia la base de datos local y asigna un path para guardar los datos.
  static Future<Isar> abrirDB() async {
    if (Isar.instanceNames.isEmpty) {
      final appDocumentosDir = await getApplicationDocumentsDirectory();
      isar = await Isar.open(
        [
          UsuarioIsarSchema,
          UsuarioPendienteIsarSchema,
        ],
        directory: appDocumentosDir.path,
      );
    }
    return Future.value(Isar.getInstance());
  }

  /// Guarda el usuario en la DB local.
  static Future<void> guardarUsuario(Usuario nuevoUsuario) async {
    // Crear un nuevo objeto
    final usuarioIsar = UsuarioIsar()
      ..idUsuario = nuevoUsuario.id
      ..idUserInfo = nuevoUsuario.idUserInfo
      ..nombre = nuevoUsuario.nombre
      ..apellido = nuevoUsuario.apellido
      ..urlFotoDePerfil = nuevoUsuario.urlFotoDePerfil;

    // Guardarlo en la db
    await isar.writeTxn(() => isar.usuarioIsars.put(usuarioIsar));
  }

  /// Guarda el [UsuarioPendiente] en la DB local.
  static Future<void> guardarUsuarioPendiente(
    UsuarioPendiente nuevoUsuarioPendiente,
  ) async {
    // Crear un nuevo objeto
    final usuarioPendienteIsar = UsuarioPendienteIsar()
      ..idUserInfo = nuevoUsuarioPendiente.idUserInfo
      ..nombre = nuevoUsuarioPendiente.nombre
      ..apellido = nuevoUsuarioPendiente.apellido
      ..urlFotoDePerfil = nuevoUsuarioPendiente.urlFotoDePerfil
      ..idRolSolicitado = nuevoUsuarioPendiente.idRolSolicitado
      ..estadoDeSolicitud = nuevoUsuarioPendiente.estadoDeSolicitud;
    // Guardarlo en la db
    await isar
        .writeTxn(() => isar.usuarioPendienteIsars.put(usuarioPendienteIsar));
  }

  /// Trae el usuario de la DB.
  static Future<Usuario?> traerUsuarioActual() async {
    final usuarioObtenido = await isar.usuarioIsars.where().findFirst();
    if (usuarioObtenido == null) {
      return null;
    }

    final usuario = Usuario(
      idUserInfo: usuarioObtenido.idUserInfo,
      nombre: usuarioObtenido.nombre,
      apellido: usuarioObtenido.apellido,
      urlFotoDePerfil: usuarioObtenido.urlFotoDePerfil,
      id: usuarioObtenido.idUsuario,
    );

    return usuario;
  }

  /// Trae el usuario pendiente de la DB.
  static Future<UsuarioPendiente> traerUsuariosPendientes() async {
    final usuarioPendienteObtenido =
        await isar.usuarioPendienteIsars.where().findFirst();

    if (usuarioPendienteObtenido == null) {
      throw Exception('Usuario local inexistente');
    }

    final usuario = UsuarioPendiente(
      idUserInfo: usuarioPendienteObtenido.idUserInfo,
      nombre: usuarioPendienteObtenido.nombre,
      apellido: usuarioPendienteObtenido.apellido,
      urlFotoDePerfil: usuarioPendienteObtenido.urlFotoDePerfil,
      idRolSolicitado: usuarioPendienteObtenido.idRolSolicitado,
      estadoDeSolicitud: usuarioPendienteObtenido.estadoDeSolicitud,
    );

    return usuario;
  }

  /// Borra los datos de la DB.
  static Future<void> borrarDatosDeInstanciaDB() async {
    await isar.writeTxn(() async {
      await isar.clear();
    });
  }

  /// Elimina el usuario pendiente de la DB.
  static Future<void> eliminarUsuariosPendientes() async {
    await isar.writeTxn(() async {
      // Obtén el primer usuario pendiente
      final usuarioPendiente =
          await isar.usuarioPendienteIsars.where().findFirst();

      // Si existe, elimínalo de la DB
      if (usuarioPendiente != null) {
        await isar.writeTxn(() async {
          await isar.usuarioPendienteIsars.clear();
        });
      }
    });
  }

  //?  En el futuro se podria agregar updateUsuario/ updateUsuarioPendiente

  // TODO(ANYONE): Para que funcione en Web deberia estar al menos la version de Isar >= 4.0.0
}
