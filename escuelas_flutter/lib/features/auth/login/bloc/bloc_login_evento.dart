part of 'bloc_login.dart';

/// {@template BlocLoginEvento}
/// AGREGAR DOCUMENTACION GENERADA
/// {@endtemplate}
abstract class BlocLoginEvento {
  /// {@macro BlocLoginEvento}
  const BlocLoginEvento();
}

/// {@template BlocLoginEventoHabilitarBotonIngresar}
/// Habilita el boton de ingresar segun si se cumplen las validaciones
/// {@endtemplate}
class BlocLoginEventoHabilitarBotonIngresar extends BlocLoginEvento {
  /// {@macro BlocLoginEventoHabilitarBotonIngresar}
  const BlocLoginEventoHabilitarBotonIngresar({
    required this.password,
    required this.dni,
  });

  /// Dni del usuario
  final String dni;

  /// Contraseña del usuario
  final String password;
}

/// {@template BlocLoginEventoIniciarSesionConCredenciales}
/// Maneja la informacion del usuario para poder iniciar sesión con credenciales
/// {@endtemplate}
class BlocLoginEventoIniciarSesionConCredenciales extends BlocLoginEvento {
  /// {@macro BlocLoginEventoIniciarSesionConCredenciales}
  const BlocLoginEventoIniciarSesionConCredenciales({
    required this.password,
    required this.dniOEmail,
  });

  /// Dni del usuario
  final String dniOEmail;

  /// Contraseña del usuario
  final String password;
}

/// {@template BlocLoginEventoIniciarSesionConGoogle}
/// Evento para iniciar sesion con google
/// {@endtemplate}
class BlocLoginEventoIniciarSesionConGoogle extends BlocLoginEvento {
  /// {@macro BlocLoginEventoIniciarSesionConGoogle}
  const BlocLoginEventoIniciarSesionConGoogle();
}
