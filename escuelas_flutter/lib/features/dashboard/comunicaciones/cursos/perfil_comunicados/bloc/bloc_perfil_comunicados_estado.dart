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
  });

  BlocPerfilComunicadosEstado.desde(
    BlocPerfilComunicadosEstado otro,
  ) : this._(
          idUsuario: otro.idUsuario,
          nombreUsuario: otro.nombreUsuario,
        );

  /// Id del usuario a traer sus notificaciones.
  final int idUsuario;

  /// Nombre del usuario/alumno
  final String nombreUsuario;

  List<Object> get props => [
        idUsuario,
        nombreUsuario,
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
    super.otro,
  ) : super.desde();
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
  }) : super.desde();

  ///
  final String? tituloPlantilla;
}
