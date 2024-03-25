part of 'bloc_perfil_usuario_pendiente.dart';

/// {@template BlocPerfilUsuarioPendienteEvento}
/// Clase padrede los eventos de [BlocPerfilUsuarioPendiente]
/// {@endtemplate}
abstract class BlocPerfilUsuarioPendienteEvento {
  /// {@macro BlocPerfilUsuarioPendienteEvento}
  const BlocPerfilUsuarioPendienteEvento();
}

/// {@template BlocPerfilUsuarioPendienteEventoTraerusuarioPendiente}
/// Trae todos los datos del usuario pendiente
/// {@endtemplate}
class BlocPerfilUsuarioPendienteEventoTraerUsuarioPendiente
    extends BlocPerfilUsuarioPendienteEvento {
  /// {@macro BlocPerfilUsuarioPendienteEventoTraerusuarioPendiente}
  const BlocPerfilUsuarioPendienteEventoTraerUsuarioPendiente({
    required this.idUsuarioPendiente,
  });

  /// Id del usuario al que se le va a asignar un rol
  final int? idUsuarioPendiente;
}

/// {@template BlocPerfilUsuarioPendienteEventoAceptarSolicitud}
/// Acepta la solicitud de un usuario
/// {@endtemplate}
class BlocPerfilUsuarioPendienteEventoAceptarSolicitud
    extends BlocPerfilUsuarioPendienteEvento {}

/// {@template BlocPerfilUsuarioPendienteEventoAceptarSolicitud}
/// Rechaza la solicitud de un usuario.
/// {@endtemplate}
class BlocPerfilUsuarioPendienteEventoRechazarSolicitud
    extends BlocPerfilUsuarioPendienteEvento {}
