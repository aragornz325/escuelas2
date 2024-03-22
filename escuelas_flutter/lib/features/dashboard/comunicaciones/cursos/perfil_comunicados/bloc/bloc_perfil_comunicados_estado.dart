part of 'bloc_perfil_comunicados.dart';

/// {@template BlocPerfilComunicadosEstado}
/// Estado principal de la pagina de 'Perfil de Comunicados'.
/// {@endtemplate}
@immutable
sealed class BlocPerfilComunicadosEstado {
  /// {@macro BlocPerfilComunicadosEstado}
  const BlocPerfilComunicadosEstado._({
    required this.idUsuario,
    required this.nombreUsuario,
    this.plantillas = const [],
    this.notificaciones = const [],
  });

  BlocPerfilComunicadosEstado.desde(
    BlocPerfilComunicadosEstado otro, {
    List<PlantillaComunicacion>? plantillas,
    List<HiloDeNotificaciones>? notificaciones,
  }) : this._(
          plantillas: plantillas ?? otro.plantillas,
          notificaciones: notificaciones ?? otro.notificaciones,
          idUsuario: otro.idUsuario,
          nombreUsuario: otro.nombreUsuario,
        );

  /// Id del usuario a traer sus notificaciones.
  final int idUsuario;

  /// Nombre del usuario/alumno
  final String nombreUsuario;

  /// Lista de plantillas para la creacion de notificaciones.
  final List<PlantillaComunicacion> plantillas;

  /// Lista de notificaciones
  final List<HiloDeNotificaciones> notificaciones;

  List<Object> get props => [
        idUsuario,
        nombreUsuario,
        plantillas,
        notificaciones,
      ];
}

/// {@template BlocPerfilComunicadosEstadoInicial}
/// Estado `inicial` de la pagina de 'Perfil de Comunicados'.
/// {@endtemplate}
final class BlocPerfilComunicadosEstadoInicial
    extends BlocPerfilComunicadosEstado {
  /// {@macro BlocPerfilComunicadosEstadoInicial}
  const BlocPerfilComunicadosEstadoInicial({
    required super.idUsuario,
    required super.nombreUsuario,
  }) : super._();
}

/// {@template BlocPerfilComunicadosEstadoCargando}
/// Estado `Cargando` de la pagina de 'Perfil de Comunicados'.
/// {@endtemplate}
class BlocPerfilComunicadosEstadoCargando extends BlocPerfilComunicadosEstado {
  /// {@macro BlocPerfilComunicadosEstadoCargando}
  BlocPerfilComunicadosEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocPerfilComunicadosEstadoExitoso}
/// Estado `Exitoso` de la pagina de 'Perfil de Comunicados'.
/// {@endtemplate}
class BlocPerfilComunicadosEstadoExitoso extends BlocPerfilComunicadosEstado {
  /// {@macro BlocPerfilComunicadosEstadoExitoso}
  BlocPerfilComunicadosEstadoExitoso.desde(
    super.otro, {
    super.plantillas,
    super.notificaciones,
  }) : super.desde();
}

/// {@template BlocPerfilComunicadosEstadoFallido}
/// Estado `Fallido` de la pagina de 'Perfil de Comunicados'.
/// {@endtemplate}
class BlocPerfilComunicadosEstadoFallido extends BlocPerfilComunicadosEstado {
  /// {@macro BlocPerfilComunicadosEstadoFallido}
  BlocPerfilComunicadosEstadoFallido.desde(super.otro) : super.desde();
}

/// {@template BlocPerfilComunicadosEstadoExitosoAlCrearNotificacion}
/// Estado `Exitoso` al crear notificacion de la pagina de
/// 'Perfil de Comunicados'.
/// {@endtemplate}
class BlocPerfilComunicadosEstadoExitosoAlCrearNotificacion
    extends BlocPerfilComunicadosEstado {
  /// {@macro BlocPerfilComunicadosEstadoExitosoAlCrearNotificacion}
  BlocPerfilComunicadosEstadoExitosoAlCrearNotificacion.desde(
    super.otro, {
    this.tituloPlantilla,
    super.notificaciones,
  }) : super.desde();

  /// Titulo de la plantilla al crear una nueva notificacion.
  final String? tituloPlantilla;
}
