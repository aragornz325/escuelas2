part of 'bloc_usuarios_pendientes.dart';

/// {@template BlocUsuariosPendientesEvento}
/// Clase padre de los eventos de [BlocUsuariosPendientes].
/// {@endtemplate}
abstract class BlocUsuariosPendientesEvento {
  /// {@macro BlocUsuariosPendientesEvento}
  const BlocUsuariosPendientesEvento();
}

/// {@template BlocUsuariosPendientesEventoInicializar}
/// Inicializa la pagina, es decir, trae todos los usuarios pendientes a asignar
/// un rol
/// {@endtemplate}
class BlocUsuariosPendientesEventoInicializar
    extends BlocUsuariosPendientesEvento {
  /// {@macro BlocUsuariosPendientesEventoInicializar}
  const BlocUsuariosPendientesEventoInicializar({
    this.idUsuario,
  });

  /// Id del usuario que se va a asignar un rol
  final int? idUsuario;
}
