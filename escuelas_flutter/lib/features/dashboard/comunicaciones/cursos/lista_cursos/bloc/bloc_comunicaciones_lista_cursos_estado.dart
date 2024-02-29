part of 'bloc_comunicaciones_lista_cursos.dart';

/// {@template BlocComunicacionesListaCursosEstado}
/// Estado principal de la pagina de 'Comunicaciones de cursos'.
/// {@endtemplate}
@immutable
sealed class BlocComunicacionesListaCursosEstado {
  /// {@macro BlocComunicacionesListaCursosEstado}
  const BlocComunicacionesListaCursosEstado._({
    this.comisiones = const [],
  });

  BlocComunicacionesListaCursosEstado.desde(
    BlocComunicacionesListaCursosEstado otro, {
    List<ComisionDeCurso>? comisiones,
  }) : this._(
          comisiones: comisiones ?? otro.comisiones,
        );

  final List<ComisionDeCurso> comisiones;

  List<Object> get props => [
        comisiones,
      ];
}

/// {@template BlocComunicacionesListaCursosEstadoInicial}
/// Estado `inicial` de la pagina de 'Comunicaciones de cursos'.
/// {@endtemplate}
class BlocComunicacionesListaCursosEstadoInicial
    extends BlocComunicacionesListaCursosEstado {
  /// {@macro BlocComunicacionesListaCursosEstadoInicial}
  const BlocComunicacionesListaCursosEstadoInicial() : super._();
}

/// {@template BlocComunicacionesListaCursosEstadoCargando}
/// Estado `Cargando` de la pagina de 'Comunicaciones de cursos'.
/// {@endtemplate}
class BlocComunicacionesListaCursosEstadoCargando
    extends BlocComunicacionesListaCursosEstado {
  /// {@macro BlocComunicacionesListaCursosEstadoCargando}
  BlocComunicacionesListaCursosEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocComunicacionesListaCursosEstadoExitoso}
/// Estado `Exitoso` de la pagina de 'Comunicaciones de cursos'.
/// {@endtemplate}
class BlocComunicacionesListaCursosEstadoExitoso
    extends BlocComunicacionesListaCursosEstado {
  /// {@macro BlocComunicacionesListaCursosEstadoExitoso}
  BlocComunicacionesListaCursosEstadoExitoso.desde(
    super.otro, {
    super.comisiones,
  }) : super.desde();
}

/// {@template BlocComunicacionesListaCursosEstadoFallido}
/// Estado `Fallido` de la pagina de 'Comunicaciones de cursos'.
/// {@endtemplate}
class BlocComunicacionesListaCursosEstadoFallido
    extends BlocComunicacionesListaCursosEstado {
  /// {@macro BlocComunicacionesListaCursosEstadoFallido}
  BlocComunicacionesListaCursosEstadoFallido.desde(super.otro) : super.desde();
}
