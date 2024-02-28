part of 'bloc_comunicaciones_cursos.dart';

/// {@template BlocComunicacionesCursosEstado}
/// Estado principal de la pagina de 'Comunicaciones de cursos'.
/// {@endtemplate}
@immutable
sealed class BlocComunicacionesCursosEstado {
  /// {@macro BlocComunicacionesCursosEstado}
  const BlocComunicacionesCursosEstado._({
    this.comisiones = const [],
  });

  BlocComunicacionesCursosEstado.desde(
    BlocComunicacionesCursosEstado otro, {
    List<ComisionDeCurso>? comisiones,
  }) : this._(
          comisiones: comisiones ?? otro.comisiones,
        );

  final List<ComisionDeCurso> comisiones;

  List<Object> get props => [
        comisiones,
      ];
}

/// {@template BlocComunicacionesCursosEstadoInicial}
/// Estado `inicial` de la pagina de 'Comunicaciones de cursos'.
/// {@endtemplate}
class BlocComunicacionesCursosEstadoInicial
    extends BlocComunicacionesCursosEstado {
  /// {@macro BlocComunicacionesCursosEstadoInicial}
  const BlocComunicacionesCursosEstadoInicial() : super._();
}

/// {@template BlocComunicacionesCursosEstadoCargando}
/// Estado `Cargando` de la pagina de 'Comunicaciones de cursos'.
/// {@endtemplate}
class BlocComunicacionesCursosEstadoCargando
    extends BlocComunicacionesCursosEstado {
  /// {@macro BlocComunicacionesCursosEstadoCargando}
  BlocComunicacionesCursosEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocComunicacionesCursosEstadoExitoso}
/// Estado `Exitoso` de la pagina de 'Comunicaciones de cursos'.
/// {@endtemplate}
class BlocComunicacionesCursosEstadoExitoso
    extends BlocComunicacionesCursosEstado {
  /// {@macro BlocComunicacionesCursosEstadoExitoso}
  BlocComunicacionesCursosEstadoExitoso.desde(
    super.otro, {
    super.comisiones,
  }) : super.desde();
}

/// {@template BlocComunicacionesCursosEstadoFallido}
/// Estado `Fallido` de la pagina de 'Comunicaciones de cursos'.
/// {@endtemplate}
class BlocComunicacionesCursosEstadoFallido
    extends BlocComunicacionesCursosEstado {
  /// {@macro BlocComunicacionesCursosEstadoFallido}
  BlocComunicacionesCursosEstadoFallido.desde(super.otro) : super.desde();
}
