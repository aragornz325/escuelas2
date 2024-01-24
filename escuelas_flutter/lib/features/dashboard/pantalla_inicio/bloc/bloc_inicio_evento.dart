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
