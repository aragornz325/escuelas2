part of 'bloc_perfil_usuario.dart';

/// {@template BlocPerfilUsuarioEvento}
/// Clase padre de los eventos de [BlocPerfilUsuario].
/// {@endtemplate}
abstract class BlocPerfilUsuarioEvento {
  /// {@macro BlocPerfilUsuarioEvento}
  const BlocPerfilUsuarioEvento();
}

/// {@template BlocPerfilUsuarioEventoTraerUsuario}
/// Trae todos los datos del usuario
/// {@endtemplate}
class BlocPerfilUsuarioEventoTraerUsuario extends BlocPerfilUsuarioEvento {
  /// {@macro BlocPerfilUsuarioEventoTraerUsuario}
  const BlocPerfilUsuarioEventoTraerUsuario({
    required this.idUsuario,
  });

  /// Id del usuario que se va a mostrar en ui
  final int? idUsuario;
}
