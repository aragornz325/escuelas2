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
          titulo: titulo,
          ultimaModificacion: ahora,
          fechaCreacion: ahora,
          estudianteId: idEstudiante,
          necesitaSupervision: necesitaSupervision,
        ),
      ),
    );

    await ejecutarOperacion(
      () => _ormRelacionHiloDeNotificacionesUsuario
          .crearRelacionesHiloDeNotificacionesUsuario(
        session,
        relaciones: [
          RelacionHiloDeNotificacionesUsuario(
            idUsuario: autor.id!,
            hiloDeNotificacionesId: nuevoHiloDeNotificaciones.id!,
            ultimaModificacion: ahora,
            fechaCreacion: ahora,
          ),
          RelacionHiloDeNotificacionesUsuario(
            idUsuario: idEstudiante,
            hiloDeNotificacionesId: nuevoHiloDeNotificaciones.id!,
            ultimaModificacion: ahora,
            fechaCreacion: ahora,
          ),
        ],
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
          contenido: mensaje,
          idHiloDeNotificaciones: nuevoHiloDeNotificaciones.id!,
          autorId: autor.id!,
          fechaCreacion: ahora,
          ultimaModificacion: ahora,
        ),
      ),
    );

    if (nuevoComentario.id == null) {
      throw ExcepcionCustom.fromJson(errorDesconocido, Protocol());
    }

    ejecutarOperacion(
      () => _ormOrmRelacionComentarioHiloDeNotificacionesUsuario
          .crearRelacionesComentarioHiloDeNotificacionesUsuario(session,
              relaciones: [
            RelacionComentarioHiloDeNotificacionesUsuario(
              idUsuario: idEstudiante,
              comentarioId: nuevoComentario.id!,
              ultimaModificacion: ahora,
              fechaCreacion: ahora,
            ),
          ]),
    );

    return nuevoHiloDeNotificaciones
      ..comentarios = [
        nuevoComentario..autor = autor,
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

  Future<void> marcarComoLeidoHiloDeNotificaciones(
    Session session, {
    required int idHiloDeNotificaciones,
  }) async {
    final ahora = DateTime.now();
    final usuario = await OrmUsuario().obtenerInfoBasicaUsuario(session,
        idUserInfo: await obtenerIdDeUsuarioLogueado(session));

    final hiloDeNotificaciones =
      await _ormHiloDeNotificaciones.obtenerUnRegistroEnDbPorFiltro(
    session,
    filtroCondicional:
        HiloDeNotificaciones.t.id.equals(idHiloDeNotificaciones) &
            HiloDeNotificaciones.t.fechaEliminacion.equals(null),
    incluirObjetos: HiloDeNotificaciones.include(
      comentarios: ComentarioHiloDeNotificaciones.includeList(
        where: (t) =>
            t.fechaEliminacion.equals(null),
        include: ComentarioHiloDeNotificaciones.include(
          destinatarios:
              RelacionComentarioHiloDeNotificacionesUsuario.includeList(
            where: (p0) => p0.idUsuario.equals(usuario.id) & p0.fechaDeLectura.equals(null) & p0.fechaEliminacion.equals(null),
            include: RelacionComentarioHiloDeNotificacionesUsuario.include(),
          ),
        ),
      ),
    ),
  );

  if (hiloDeNotificaciones == null ||
      hiloDeNotificaciones.comentarios == null) {
    throw ExcepcionCustom.fromJson(errorDesconocido, Protocol());
  }

  final relacion = hiloDeNotificaciones.comentarios!
      .expand((e) => e.destinatarios!.map((e) => e..fechaDeLectura = ahora))
      .toList();

  _ormOrmRelacionComentarioHiloDeNotificacionesUsuario
      .actualizarVariosRegistrosEnDb(
    session,
    registrosEnDb: relacion,
  );
  }

  Future<void> marcarComoLeidosTodosLosHilosDeNotificaciones(
    Session session, {
    required List<int> idHilosDeNotificaciones,
  }) async {
    final ahora = DateTime.now();
    final usuario = await OrmUsuario().obtenerInfoBasicaUsuario(session,
        idUserInfo: await obtenerIdDeUsuarioLogueado(session));

    final hilosDeNotificaciones =
        await _ormHiloDeNotificaciones.listarRegistrosEnDbPorFiltro(
      session,
      filtroCondicional:
          HiloDeNotificaciones.t.id.inSet(idHilosDeNotificaciones.toSet()) & HiloDeNotificaciones.t.fechaEliminacion.equals(null),
      incluirObjetos: HiloDeNotificaciones.include(
        comentarios: ComentarioHiloDeNotificaciones.includeList(
        where: (t) =>
            t.fechaEliminacion.equals(null),
        include: ComentarioHiloDeNotificaciones.include(
          destinatarios:
              RelacionComentarioHiloDeNotificacionesUsuario.includeList(
            where: (p0) => p0.idUsuario.equals(usuario.id) & p0.fechaDeLectura.equals(null) & p0.fechaEliminacion.equals(null),
            include: RelacionComentarioHiloDeNotificacionesUsuario.include(),
          ),
        ),
      ),
      ),
    );

    for (var hilo in hilosDeNotificaciones) {
      if (hilo.comentarios == null) {
        continue;
      }
      final relaciones = hilo.comentarios!
          .expand(
            (e) => e.destinatarios!.map(
              (e) => e..fechaDeLectura = ahora,
            ),
          )
          .toList();
      _ormOrmRelacionComentarioHiloDeNotificacionesUsuario
          .actualizarVariosRegistrosEnDb(
        session,
        registrosEnDb: relaciones,
      );
    }
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

    final hiloDeNotificaciones =
        await _ormHiloDeNotificaciones.obtenerUnRegistroEnDbPorId(
      session,
      idDelRegistro: idHiloDeNotificaciones,
      incluirObjetos: HiloDeNotificaciones.include(
        participantes: RelacionHiloDeNotificacionesUsuario.includeList(
          where: (p0) => p0.idUsuario.notEquals(autor.id),
          include: RelacionHiloDeNotificacionesUsuario.include(),
        ),
      ),
    );

    if (hiloDeNotificaciones == null ||
        hiloDeNotificaciones.participantes == null ||
        hiloDeNotificaciones.participantes!.isEmpty) {
      throw ExcepcionCustom.fromJson(errorDesconocido, Protocol());
    }

    final nuevoComentario = await ejecutarOperacion(
      () => _ormComentariosHiloDeNotificaciones
          .crearComentarioHiloDeNotificaciones(
        session,
        comentario: ComentarioHiloDeNotificaciones(
          autor: autor,
          contenido: comentario,
          idHiloDeNotificaciones: idHiloDeNotificaciones,
          autorId: autor.id!,
          fechaCreacion: ahora,
          ultimaModificacion: ahora,
        ),
      ),
    );

    if (nuevoComentario.id == null) {
      throw ExcepcionCustom.fromJson(errorDesconocido, Protocol());
    }

    _ormOrmRelacionComentarioHiloDeNotificacionesUsuario
        .crearRelacionesComentarioHiloDeNotificacionesUsuario(
      session,
      relaciones: hiloDeNotificaciones.participantes!
          .map(
            (e) => RelacionComentarioHiloDeNotificacionesUsuario(
              idUsuario: e.idUsuario,
              comentarioId: nuevoComentario.id!,
              ultimaModificacion: ahora,
              fechaCreacion: ahora,
            ),
          )
          .toList(),
    );

    return nuevoComentario..autor = autor;
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
