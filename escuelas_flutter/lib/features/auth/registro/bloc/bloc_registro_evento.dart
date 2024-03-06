part of 'bloc_registro.dart';

/// {@template BlocRegistroEvento}
/// Eventos para el bloc de registro
/// {@endtemplate}
abstract class BlocRegistroEvento {
  /// {@macro BlocRegistroEvento}
  const BlocRegistroEvento();
}

/// {@template BlocRegistroEventoRegistrarUsuario}
/// Evento para registrar un usuario en la aplicacion
/// {@endtemplate}
class BlocRegistroEventoRegistrarUsuario extends BlocRegistroEvento {
  /// {@macro BlocRegistroEventoRegistrarUsuario}
  const BlocRegistroEventoRegistrarUsuario({
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.contrasenia,
    required this.documento,
  });
  final String nombre;
  final String apellido;
  final String email;
  final String contrasenia;
  final String documento;
}

/// {@template BlocRegistroEventoRegistrarseConGoogle}
/// Evento para iniciar sesion con google
/// {@endtemplate}
class BlocRegistroEventoRegistrarseConGoogle extends BlocRegistroEvento {
  /// {@macro BlocRegistroEventoRegistrarseConGoogle}
  const BlocRegistroEventoRegistrarseConGoogle();
}
