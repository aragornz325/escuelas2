part of 'bloc_comunicaciones.dart';

/// {@template BlocComunicacionesEvento}
/// Bloc que maneja los eventos generales de la pagina 'Comunicaciones'
/// {@endtemplate}
abstract class BlocComunicacionesEvento {
  /// {@macro BlocComunicacionesEvento}
  const BlocComunicacionesEvento();
}

/// {@template BlocComunicacionesEventoInicializar}
/// Evento Inicial que obtiene las Comunicaciones pertinentes
/// {@endtemplate}
class BlocComunicacionesEventoInicializar extends BlocComunicacionesEvento {
  /// {@macro BlocComunicacionesEventoInicializar}
  const BlocComunicacionesEventoInicializar({required this.fecha});

  /// Fecha de la fecha a tomar del calendario
  final DateTime fecha;
}
