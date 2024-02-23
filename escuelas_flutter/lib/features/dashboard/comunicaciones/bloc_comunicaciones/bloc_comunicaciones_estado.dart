part of 'bloc_comunicaciones.dart';

/// {@template BlocComunicacionesEstado}
/// Bloc que maneja el estado de las Comunicaciones
/// {@endtemplate}
@immutable
class BlocComunicacionesEstado {
  /// {@macro BlocComunicacionesEstado}
  const BlocComunicacionesEstado._({
    this.fechaActual,
  });

  BlocComunicacionesEstado.desde(
    BlocComunicacionesEstado otro, {
    DateTime? fechaActual,
  }) : this._(
          fechaActual: fechaActual ?? otro.fechaActual,
        );

  /// Fecha en la que se finalizaron las Comunicaciones
  final DateTime? fechaActual;

  List<Object?> get props => [
        fechaActual,
      ];
}

/// {@template BlocComunicacionesEstadoInicial}
/// Estado Inicial de la pagina de 'Comunicaciones'
/// {@endtemplate}
class BlocComunicacionesEstadoInicial extends BlocComunicacionesEstado {
  /// {@macro BlocComunicacionesEstadoInicial}
  const BlocComunicacionesEstadoInicial() : super._();
}

/// {@template BlocComunicacionesEstadoCargando}
/// Estado Cargando de la pagina de 'Comunicaciones'
/// {@endtemplate}
class BlocComunicacionesEstadoCargando extends BlocComunicacionesEstado {
  /// {@macro BlocComunicacionesEstadoCargando}
  BlocComunicacionesEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocComunicacionesEstadoExitoso}
/// Estado Exitoso de la pagina de 'Comunicaciones'
/// {@endtemplate}
class BlocComunicacionesEstadoExitoso extends BlocComunicacionesEstado {
  /// {@macro BlocComunicacionesEstadoExitoso}
  BlocComunicacionesEstadoExitoso.desde(
    super.otro, {
    super.fechaActual,
  }) : super.desde();
}

/// {@template BlocComunicacionesEstadoFallido}
/// Estado Fallido de la pagina de 'Comunicaciones'
/// {@endtemplate}
class BlocComunicacionesEstadoFallido extends BlocComunicacionesEstado {
  /// {@macro BlocComunicacionesEstadoFallido}
  BlocComunicacionesEstadoFallido.desde(super.otro) : super.desde();
}
