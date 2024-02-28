part of 'bloc_comunicaciones_cursos.dart';

/// {@template BlocComunicacionesCursosEvento}
/// Evento principal de la pagina de 'Comunicaciones de cursos'.
/// {@endtemplate}
@immutable
sealed class BlocComunicacionesCursosEvento {
  /// {@macro BlocComunicacionesCursosEvento}
  const BlocComunicacionesCursosEvento();
}

/// {@template BlocComunicacionesCursosEventoInicializar}
/// Evento `incializar` de la pagina de 'Comunicaciones de cursos'.
/// {@endtemplate}
class BlocComunicacionesCursosEventoInicializar
    extends BlocComunicacionesCursosEvento {
  /// {@macro BlocComunicacionesCursosEventoInicializar}
  const BlocComunicacionesCursosEventoInicializar();
}
