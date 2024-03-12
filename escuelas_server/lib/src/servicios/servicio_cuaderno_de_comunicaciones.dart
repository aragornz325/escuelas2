import 'package:escuelas_server/src/excepciones/excepcion_endpoint.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_comentario_hilo_notificaciones.dart';
import 'package:escuelas_server/src/orms/orm_hilo_de_notificaciones.dart';
import 'package:escuelas_server/src/orms/orm_plantilla_comunicacion.dart';
import 'package:escuelas_server/src/orms/orm_relacion_comentario_usuario.dart';
import 'package:escuelas_server/src/orms/orm_relacion_hilo_de_notificacion_usuario.dart';
import 'package:escuelas_server/src/orms/orm_usuario.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:serverpod/serverpod.dart';

class ServicioCuadernoDeComunicaciones extends Servicio {
  final _ormHiloDeNotificaciones = OrmHiloDeNotificaciones();

  final _ormComentariosHiloDeNotificaciones =
      OrmComentariosHiloDeNotificaciones();

  final _ormPlantillaComunicacion = OrmPlantillaComunicacion();

  final _ormRelacionHiloDeNotificacionesUsuario =
      OrmRelacionHiloDeNotificacionesUsuario();

  final _ormOrmRelacionComentarioHiloDeNotificacionesUsuario =
      OrmRelacionComentarioHiloDeNotificacionesUsuario();

  /// Crea la Notificación en la base de datos.
  Future<HiloDeNotificaciones> crearHiloDeNotificaciones(
    Session session, {
    required int idEstudiante,
    required String titulo,
    required String mensaje,
    required bool crearNuevaPlantilla,
    required bool necesitaSupervision,
  }) async {
    final ahora = DateTime.now();
    final autor = await OrmUsuario().obtenerInfoBasicaUsuario(session,
        idUserInfo: await obtenerIdDeUsuarioLogueado(session));

    if (autor.id == null) {
      throw ExcepcionCustom.fromJson(errorDesconocido, Protocol());
    }

    if (crearNuevaPlantilla) {
      await ejecutarOperacion(
        () => _ormPlantillaComunicacion.crearPlantillaComunicacion(
          session,
          plantillaComunicacion: PlantillaComunicacion(
            titulo: titulo,
            nota: mensaje,
            necesitaSupervision: necesitaSupervision,
            ultimaModificacion: ahora,
            fechaCreacion: ahora,
          ),
        ),
      );
    }

    final nuevoHiloDeNotificaciones = await ejecutarOperacion(
      () => _ormHiloDeNotificaciones.crearHiloDeNotificaciones(
        session,
        hiloDeNotificaciones: HiloDeNotificaciones(
          autor: autor,
          titulo: titulo,
          ultimaModificacion: ahora,
          fechaCreacion: ahora,
          estudianteId: idEstudiante,
          autorId: autor.id!,
          necesitaSupervision: necesitaSupervision,
        ),
      ),
    );

    await ejecutarOperacion(
      () => _ormRelacionHiloDeNotificacionesUsuario.crearRelacion(
        session,
        relacion: RelacionHiloDeNotificacionesUsuario(
          usuarioId: autor.id!,
          hiloDeNotificacionesId: nuevoHiloDeNotificaciones.id!,
          ultimaModificacion: ahora,
          fechaCreacion: ahora,
        ),
        usuarioId: autor.id!,
      ),
    );

    if (nuevoHiloDeNotificaciones.id == null) {
      throw ExcepcionCustom.fromJson(errorDesconocido, Protocol());
    }

    final nuevoComentario = await ejecutarOperacion(
      () => _ormComentariosHiloDeNotificaciones
          .crearComentarioHiloDeNotificaciones(
        session,
        comentario: ComentarioHiloDeNotificaciones(
          relacionComentarioHiloDeNotificacionesUsuarioId: 0,
          contenido: mensaje,
          idHiloDeNotificaciones: nuevoHiloDeNotificaciones.id!,
          autorId: autor.id!,
          fechaCreacion: ahora,
          ultimaModificacion: ahora,
        ),
      ),
    );
    final nuevaRelacion = await ejecutarOperacion(
      () => _ormOrmRelacionComentarioHiloDeNotificacionesUsuario.crearRelacion(
        session,
        relacion: RelacionComentarioHiloDeNotificacionesUsuario(
          usuarioId: autor.id!,
          comentarioId: nuevoComentario.id!,
          ultimaModificacion: ahora,
          fechaCreacion: ahora,
        ),
        usuarioId: autor.id!,
      ),
    );
    if (nuevaRelacion.id == null) {
      throw ExcepcionCustom.fromJson(errorDesconocido, Protocol());
    }
    return nuevoHiloDeNotificaciones
      ..comentarios = [
        nuevoComentario
          ..relacionComentarioHiloDeNotificacionesUsuarioId = nuevaRelacion.id!
      ];
  }

  /// Trae la lista de Notificacioneses
  Future<List<HiloDeNotificaciones>> listarHilosDeNotificacionesPorUsuario(
    Session session, {
    required int idUsuario,
  }) async =>
      ejecutarOperacion(
        () => _ormHiloDeNotificaciones.listarHilosDeNotificaciones(
          session,
          idUsuario: idUsuario,
        ),
      );

  /// Elimina lista de notificaciones
  Future<bool> eliminarHilosDeNotificaciones(
    Session session, {
    required List<int> idHiloDeNotificaciones,
  }) async =>
      ejecutarOperacion(
        () => _ormHiloDeNotificaciones.eliminarHilosDeNotificaciones(
          session,
          idHiloDeNotificaciones: idHiloDeNotificaciones,
        ),
      );

  Future<HiloDeNotificaciones> marcarComoLeidoHiloDeNotificaciones(
    Session session, {
    required HiloDeNotificaciones hiloDeNotificaciones,
  }) async {
    final ahora = DateTime.now();

    if (hiloDeNotificaciones.comentarios == null) {
      throw ExcepcionCustom.fromJson(errorDesconocido, Protocol());
    }
    await ComentarioHiloDeNotificaciones.db.update(
        session,
        hiloDeNotificaciones.comentarios == null
            ? hiloDeNotificaciones.comentarios!
                .map((e) => e..fechaLectura = ahora)
                .toList()
            : <ComentarioHiloDeNotificaciones>[]);

    return await ejecutarOperacion(
      () => _ormHiloDeNotificaciones.modificarHiloDeNotificaciones(
        session,
        hiloDeNotificaciones: hiloDeNotificaciones,
      ),
    );
  }

  Future<List<HiloDeNotificaciones>>
      marcarComoLeidosTodosComentariosHiloDeNotificaciones(
    Session session, {
    required List<HiloDeNotificaciones> hiloDeNotificaciones,
  }) async {
    return await ejecutarOperacion(
      () => _ormHiloDeNotificaciones.marcarTodaslosHiloDeNotificacionesLeidas(
        session,
        hiloDeNotificaciones: hiloDeNotificaciones,
      ),
    );
  }

  /// Crea un nuevo comentario de notificacion
  Future<ComentarioHiloDeNotificaciones>
      agregarComentarioEnHiloDeNotificaciones(
    Session session, {
    required int idHiloDeNotificaciones,
    required String comentario,
  }) async {
    final ahora = DateTime.now();
    final autor = await OrmUsuario().obtenerInfoBasicaUsuario(session,
        idUserInfo: await obtenerIdDeUsuarioLogueado(session));

    if (autor.id == null) {
      throw ExcepcionCustom.fromJson(errorDesconocido, Protocol());
    }

    final nuevoComentario = await ejecutarOperacion(
      () => _ormComentariosHiloDeNotificaciones
          .crearComentarioHiloDeNotificaciones(
        session,
        comentario: ComentarioHiloDeNotificaciones(
          relacionComentarioHiloDeNotificacionesUsuarioId: 0,
          autor: autor,
          contenido: comentario,
          idHiloDeNotificaciones: idHiloDeNotificaciones,
          autorId: autor.id!,
          fechaCreacion: ahora,
          ultimaModificacion: ahora,
        ),
      ),
    );

    final nuevaRelacion =
        await _ormOrmRelacionComentarioHiloDeNotificacionesUsuario
            .crearRelacion(
      session,
      relacion: RelacionComentarioHiloDeNotificacionesUsuario(
        usuarioId: autor.id!,
        comentarioId: nuevoComentario.id!,
        ultimaModificacion: ahora,
        fechaCreacion: ahora,
      ),
      usuarioId: autor.id!,
    );
    if (nuevaRelacion.id == null) {
      throw ExcepcionCustom.fromJson(errorDesconocido, Protocol());
    }
    return nuevoComentario
      ..relacionComentarioHiloDeNotificacionesUsuarioId = nuevaRelacion.id!;
  }

  /// Elimina un comentario de la notificacion.
  Future<bool> eliminarComentarioEnHiloDeNotificaciones(
    Session session, {
    required int idComentario,
  }) async =>
      ejecutarOperacion(
        () => _ormComentariosHiloDeNotificaciones
            .eliminarComentarioHiloDeNotificaciones(
          session,
          idComentario: idComentario,
        ),
      );
}
