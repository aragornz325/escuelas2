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
    this.tituloPlantilla,
  });

  ///
  final String? tituloPlantilla;
}

/// {@template BlocPerfilComunicadosEventoMarcarNotificacionComoLeidas}
/// Evento para marcar una notificacion como leida.
/// {@endtemplate}
class BlocPerfilComunicadosEventoMarcarNotificacionComoLeidas
    extends BlocPerfilComunicadosEvento {
  /// {@macro BlocPerfilComunicadosEventoMarcarNotificacionComoLeidas}
}

/// {@template BlocPerfilComunicadosEventoCrearComentario}
/// Evento para crear un comentario en una notificacion.
/// {@endtemplate}
class BlocPerfilComunicadosEventoCrearComentario
    extends BlocPerfilComunicadosEvento {
  /// {@macro BlocPerfilComunicadosEventoCrearComentario}
}

/// {@template BlocPerfilComunicadosEventoNotificacionMarcarTodasComoLeidas}
/// Evento para marcar todas las notificaciones como leidas.
/// {@endtemplate}
class BlocPerfilComunicadosEventoNotificacionMarcarTodasComoLeidas
    extends BlocPerfilComunicadosEvento {
  /// {@macro BlocPerfilComunicadosEventoNotificacionMarcarTodasComoLeidas}
}
