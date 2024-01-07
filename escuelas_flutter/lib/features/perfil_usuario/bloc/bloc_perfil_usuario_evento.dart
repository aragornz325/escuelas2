part of 'bloc_perfil_usuario.dart';

/// {@template BlocPerfilUsuarioEvento}
/// Clase padre de los eventos de [BlocPerfilUsuario].
/// {@endtemplate}
abstract class BlocPerfilUsuarioEvento {
  /// {@macro BlocPerfilUsuarioEvento}
  const BlocPerfilUsuarioEvento();
}

/// {@template BlocPerfilUsuarioEventoInicializar}
/// Inicializa la pagina, es decir, trae todos los datos del usuario
/// {@endtemplate}
class BlocPerfilUsuarioEventoInicializar extends BlocPerfilUsuarioEvento {
  /// {@macro BlocPerfilUsuarioEventoInicializar}
  const BlocPerfilUsuarioEventoInicializar({
    required this.idUsuario,
  });

  /// Id del usuario que se va a asignar un rol
  final int? idUsuario;
}

/// {@template BlocPerfilUsuarioEventoAceptarSolicitud}
/// Acepta la solicitud de un usuario
/// {@endtemplate}
class BlocPerfilUsuarioEventoAceptarSolicitud extends BlocPerfilUsuarioEvento {}
