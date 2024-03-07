part of 'bloc_perfil_comunicados.dart';

/// {@template BlocPerfilComunicadosEvento}
/// Evento principal de la pagina de 'Perfil de Comunicados'.
/// {@endtemplate}
@immutable
class BlocPerfilComunicadosEvento {
  /// {@macro BlocPerfilComunicadosEvento}
}

/// {@template BlocPerfilComunicadosEventoInicializar}
/// Evento `incializar` de la pagina de 'Perfil de Comunicados'.
/// {@endtemplate}
class BlocPerfilComunicadosEventoInicializar
    extends BlocPerfilComunicadosEvento {
  /// {@macro BlocPerfilComunicadosEventoInicializar}
}

/// {@template BlocPerfilComunicadosEventoCrearNotificacion}
/// Evento para crear una nueva notificacion.
/// {@endtemplate}
class BlocPerfilComunicadosEventoCrearNotificacion
    extends BlocPerfilComunicadosEvento {
  /// {@macro BlocPerfilComunicadosEventoCrearNotificacion}
  BlocPerfilComunicadosEventoCrearNotificacion({
    required this.descripcion,
    required this.necesitaSupervision,
    required this.crearNuevaPlantilla,
    this.tituloPlantilla,
  });

  /// El titulo de la plantilla
  final String? tituloPlantilla;


  /// Descripcion de la notificacion
  final String descripcion;

  /// Indica si la notificacion necesita supervision.
  final bool necesitaSupervision;

  /// Indica si la notificacion necesita crear una plantilla
  final bool crearNuevaPlantilla;
}

/// {@template BlocPerfilComunicadosEventoMarcarNotificacionComoLeidas}
/// Evento para marcar una notificacion como leida.
/// {@endtemplate}
class BlocPerfilComunicadosEventoMarcarNotificacionComoLeidas
    extends BlocPerfilComunicadosEvento {
  /// {@macro BlocPerfilComunicadosEventoMarcarNotificacionComoLeidas}
  BlocPerfilComunicadosEventoMarcarNotificacionComoLeidas({
    required this.notificacion,
  });

  /// Notificacion a marcar como leida
  final HiloDeNotificaciones notificacion;
}

/// {@template BlocPerfilComunicadosEventoCrearComentario}
/// Evento para crear un comentario en una notificacion.
/// {@endtemplate}
class BlocPerfilComunicadosEventoCrearComentario
    extends BlocPerfilComunicadosEvento {
  /// {@macro BlocPerfilComunicadosEventoCrearComentario}
  BlocPerfilComunicadosEventoCrearComentario({
    required this.idHiloDeNotificacion,
    required this.comentario,
  });

  /// Id de la notificacion
  final int idHiloDeNotificacion;

  /// Comentario
  final String comentario;
}

/// {@template BlocPerfilComunicadosEventoNotificacionMarcarTodasComoLeidas}
/// Evento para marcar todas las notificaciones como leidas.
/// {@endtemplate}
class BlocPerfilComunicadosEventoNotificacionMarcarTodasComoLeidas
    extends BlocPerfilComunicadosEvento {
  /// {@macro BlocPerfilComunicadosEventoNotificacionMarcarTodasComoLeidas}
  BlocPerfilComunicadosEventoNotificacionMarcarTodasComoLeidas();
}
