part of 'bloc_editar_perfil.dart';

/// {@template BlocEditarPerfilEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}

@immutable
sealed class BlocEditarPerfilEstado {
  /// {@macro BlocEditarPerfilEstado}
  const BlocEditarPerfilEstado._({
    this.nombreUsuario = '',
    this.usuario,
    this.telefono,
    this.email,
    this.factorSanguineo,
    this.edad,
    this.dni,
    this.nuevaPassword,
    this.conRequerimientoDeCambioDePassword,
  });

  BlocEditarPerfilEstado.desde(
    BlocEditarPerfilEstado otro, {
    Usuario? usuario,
    String? edad,
    String? email,
    String? telefono,
    String? nombreUsuario,
    String? factorSanguineo,
    String? dni,
    String? nuevaPassword,
    bool? conRequerimientoDeCambioDePassword,
  }) : this._(
          edad: edad ?? otro.edad,
          email: email ?? otro.email,
          usuario: usuario ?? otro.usuario,
          telefono: telefono ?? otro.telefono,
          dni: dni ?? otro.dni,
          nombreUsuario: nombreUsuario ?? otro.nombreUsuario,
          factorSanguineo: factorSanguineo ?? otro.factorSanguineo,
          nuevaPassword: nuevaPassword ?? otro.nuevaPassword,
          conRequerimientoDeCambioDePassword:
              conRequerimientoDeCambioDePassword ??
                  otro.conRequerimientoDeCambioDePassword,
        );

  /// Nombre del usuario.
  final String nombreUsuario;

  /// Información del usuario a traer y luego modificar.
  final Usuario? usuario;

  /// Son los datos a guardar
  final String? telefono;
  final String? email;
  final String? factorSanguineo;
  final String? edad;
  final String? dni;
  final String? nuevaPassword;
  final bool? conRequerimientoDeCambioDePassword;
}

/// {@template BlocEditarPerfilEstadoInitial}
/// Estado inicial de los componentes de la pantalla 'Editar perfil de usuario'
/// {@endtemplate}

class BlocEditarPerfilEstadoInitial extends BlocEditarPerfilEstado {
  /// {@macro BlocEditarPerfilEstadoInitial}
  const BlocEditarPerfilEstadoInitial() : super._();
}

/// {@template BlocEditarPerfilEstadoCargando}
/// Estado de cargando de los componentes de la pantalla 'Editar perfil de
/// usuario'
/// {@endtemplate}
class BlocEditarPerfilEstadoCargando extends BlocEditarPerfilEstado {
  /// {@macro BlocEditarPerfilEstadoCargando}
  BlocEditarPerfilEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocEditarPerfilEstadoExitoso}
/// Estado exitoso de los componentes de la pantalla 'Editar perfil de usuario'
/// {@endtemplate}
class BlocEditarPerfilEstadoExitoso extends BlocEditarPerfilEstado {
  /// {@macro BlocEditarPerfilEstadoExitoso}
  BlocEditarPerfilEstadoExitoso.desde(
    super.otro, {
    super.usuario,
    super.telefono,
    super.email,
    super.factorSanguineo,
    super.edad,
    super.dni,
    super.nombreUsuario,
  }) : super.desde();
}

/// {@template BlocEditarPerfilEstadoExitoso}
/// Estado exitoso cuando guardas los cambios en la base de datos.
/// {@endtemplate}
class BlocEditarPerfilEstadoExitosoAlActualizar extends BlocEditarPerfilEstado {
  /// {@macro BlocEditarPerfilEstadoExitoso}
  BlocEditarPerfilEstadoExitosoAlActualizar.desde(super.otro) : super.desde();
}

/// {@template BlocEditarPerfilEstadoExitosoEditarPassword}
/// Estado exitoso cuando guarda la contraseña nueva en la base de datos.
/// {@endtemplate}
class BlocEditarPerfilEstadoExitosoEditarPassword
    extends BlocEditarPerfilEstado {
  /// {@macro BlocEditarPerfilEstadoExitosoEditarPassword}
  BlocEditarPerfilEstadoExitosoEditarPassword.desde(
    super.otro, {
    super.nuevaPassword,
    super.conRequerimientoDeCambioDePassword,
  }) : super.desde();
}

/// {@template BlocEditarPerfilEstadoFallido}
/// Estado de error de los componentes de la pantalla 'Editar perfil de usuario'
/// {@endtemplate}
class BlocEditarPerfilEstadoError extends BlocEditarPerfilEstado {
  /// {@macro BlocEditarPerfilEstadoError}
  BlocEditarPerfilEstadoError.desde(super.otro) : super.desde();
}
