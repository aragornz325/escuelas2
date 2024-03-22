part of 'bloc_comunicaciones_lista_cursos.dart';

/// {@template BlocComunicacionesListaCursosEvento}
/// Evento principal de la pagina de 'Comunicaciones de cursos'.
/// {@endtemplate}
@immutable
sealed class BlocComunicacionesListaCursosEvento {
  /// {@macro BlocComunicacionesListaCursosEvento}
  const BlocComunicacionesListaCursosEvento();
}

/// {@template BlocComunicacionesListaCursosEventoInicializar}
/// Evento `incializar` de la pagina de 'Comunicaciones de cursos'.
/// {@endtemplate}
class BlocComunicacionesListaCursosEventoInicializar
    extends BlocComunicacionesListaCursosEvento {
  /// {@macro BlocComunicacionesListaCursosEventoInicializar}
  const BlocComunicacionesListaCursosEventoInicializar();
}
