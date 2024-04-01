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
    this.nombreUsuario,
  });

  /// Id del usuario a traer y luego modificar.
  final int idUsuario;

  /// Nombre del usuario.
  final String? nombreUsuario;
}

/// {@template BlocEditarPerfilEventoGuardarCambios}
/// Evento para guardar los cambios hechos del alumno
/// {@endtemplate}
class BlocEditarPerfilEventoGuardarCambios extends BlocEditarPerfilEvento {
  /// {@macro BlocEditarPerfilEventoGuardarCambios}
  const BlocEditarPerfilEventoGuardarCambios({
    this.telefono,
    this.email,
    this.factorSanguineo,
    this.edad,
    this.nombreTutor,
    this.apellidoTutor,
    this.vinculo,
    this.emailTutor,
    this.telefonoTutor,
    this.observaciones,
  });

  /// Telefono a guardar del usuario.
  final String? telefono;

  /// Email a guardar del usuario.
  final String? email;

  /// Factor sanguineo a guardar del usuario.
  final String? factorSanguineo;

  /// Edad a guardar del usuario.
  final String? edad;

  /// Nombre del tutor a guardar del usuario.
  final String? nombreTutor;

  /// Apellido del tutor a guardar del usuario.
  final String? apellidoTutor;

  /// Vinculo del tutor al alumno a guardar del usuario.
  final String? vinculo;

  /// email del tutor a guardar del usuario.
  final String? emailTutor;

  /// Telefono del tutor a guardar del usuario.
  final String? telefonoTutor;

  /// Observaciones a guardar del usuario.
  final String? observaciones;
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
    required this.antiguaPassword,
    required this.nuevaPassword,
  });

  final String antiguaPassword;

  final String nuevaPassword;
}
