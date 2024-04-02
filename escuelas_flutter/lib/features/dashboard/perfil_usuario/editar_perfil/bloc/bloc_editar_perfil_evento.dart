part of 'bloc_editar_perfil.dart';

/// {@template BlocEditarPerfilEvento}
/// Eventos de los componentes de la pantalla 'Editar perfil de usuario'.
/// {@endtemplate}

@immutable
sealed class BlocEditarPerfilEvento {
  /// {@macro BlocEditarPerfilEvento}
  const BlocEditarPerfilEvento();
}

/// {@template BlocEditarPerfilEventoTraerUsuario}
/// Evento para traer el alumno y su informacion.
/// {@endtemplate}
class BlocEditarPerfilEventoTraerUsuario extends BlocEditarPerfilEvento {
  /// {@macro BlocEditarPerfilEventoTraerUsuario}
  const BlocEditarPerfilEventoTraerUsuario({
    required this.idUsuario,
  });

  /// Id del usuario a traer y luego modificar.
  final int idUsuario;
}

/// {@template BlocEditarPerfilEventoGuardarCambios}
/// Evento para guardar los cambios hechos del alumno
/// {@endtemplate}
class BlocEditarPerfilEventoGuardarCambios extends BlocEditarPerfilEvento {
  /// {@macro BlocEditarPerfilEventoGuardarCambios}
  const BlocEditarPerfilEventoGuardarCambios({
    this.usuario,
    this.telefono,
    this.email,
    this.factorSanguineo,
    this.edad,
    this.dni,
  });

  final Usuario? usuario;

  /// Telefono a guardar del usuario.
  final String? telefono;

  /// Email a guardar del usuario.
  final String? email;

  /// Factor sanguineo a guardar del usuario.
  final String? factorSanguineo;

  /// Edad a guardar del usuario.
  final String? edad;

  /// DNI a guardar del usuario.
  final String? dni;
}

/// {@template BlocEditarPerfilEventoGuardarCambios}
/// Evento para guardar los cambios hechos del alumno
/// {@endtemplate}
class BlocEditarPerfilEventoConfirmarCambios extends BlocEditarPerfilEvento {
  /// {@macro BlocEditarPerfilEventoGuardarCambios}
  const BlocEditarPerfilEventoConfirmarCambios();
}

class BlocEditarPerfilEventoEditarPassword extends BlocEditarPerfilEvento {
  const BlocEditarPerfilEventoEditarPassword({
    required this.nuevaPassword,
    required this.idUsuario,
    required this.conRequerimientoDeCambioDePassword,
  });

  final String nuevaPassword;
  final int idUsuario;
  final bool conRequerimientoDeCambioDePassword;
}
