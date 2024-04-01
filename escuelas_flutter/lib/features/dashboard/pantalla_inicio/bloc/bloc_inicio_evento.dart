part of 'bloc_inicio.dart';

/// {@template BlocInicioEvento}
/// Clase padre de los eventos de [BlocInicio].
/// {@endtemplate}
abstract class BlocInicioEvento {
  /// {@macro BlocInicioEvento}
  const BlocInicioEvento();
}

/// {@template BlocInicioEventoTraerInfoInicial}
/// Evento que trae la informacion relacionada con los permisos del usuario.
/// {@endtemplate}
class BlocInicioEventoInicializar extends BlocInicioEvento {
  /// {@macro BlocInicioEventoTraerInfoInicial}
  BlocInicioEventoInicializar();
}

/// {@template BlocInicioEventoCambiarContrasenia}
/// Evento para cambiar la contraseña del usuario.
/// {@endtemplate}
class BlocInicioEventoCambiarContrasenia extends BlocInicioEvento {
  /// {@macro BlocInicioEventoCambiarContrasenia}
  BlocInicioEventoCambiarContrasenia(this.nuevaContrasenia);

  /// Nueva contraseña
  final String nuevaContrasenia;
}
