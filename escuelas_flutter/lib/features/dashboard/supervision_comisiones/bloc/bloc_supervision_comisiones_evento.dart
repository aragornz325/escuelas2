part of 'bloc_supervision_comisiones.dart';

/// {@template BlocSupervisionComisionesEvento}
/// AGREGAR DOCUMENTACION GENERADA
/// {@endtemplate}
abstract class BlocSupervisionComisionesEvento {
  /// {@macro BlocSupervisionComisionesEvento}
  const BlocSupervisionComisionesEvento();
}

/// {@template BlocSupervisionComisionesEventoInicializar}
/// AGREGAR DOCUMENTACION GENERADA
/// {@endtemplate}
class BlocSupervisionComisionesEventoInicializar
    extends BlocSupervisionComisionesEvento {
  /// {@macro BlocSupervisionComisionesEventoInicializar}
  const BlocSupervisionComisionesEventoInicializar({
    required this.fecha,
  });
  final DateTime fecha;
}
