part of 'bloc_comunidad_academica.dart';

/// {@template BlocComunidadAcademicaEvento}
/// Eventos para el [BlocComunidadAcademica]
/// {@endtemplate}
abstract class BlocComunidadAcademicaEvento {
  /// {@macro BlocComunidadAcademicaEvento}
  const BlocComunidadAcademicaEvento();
}

/// {@template BlocComunidadAcademicaEventoInicializar}
/// Inicializa la pagina de la comunidad academica
/// {@endtemplate}
class BlocComunidadAcademicaEventoInicializar
    extends BlocComunidadAcademicaEvento {}

/// {@template BlocComunidadAcademicaEventoTraerUsuariosPorRol}
/// Trae los usuarios de la institucion por rol
/// {@endtemplate}
class BlocComunidadAcademicaEventoTraerUsuariosPorRol
    extends BlocComunidadAcademicaEvento {
  /// {@macro BlocComunidadAcademicaEventoTraerUsuariosPorRol}
  const BlocComunidadAcademicaEventoTraerUsuariosPorRol({
    required this.ordenarPor,
    this.idRol,
  });

  /// Id del rol seleccionado
  final int? idRol;

  /// Enum para ordenar los usuarios
  final OrdenarPor ordenarPor;
}

/// {@template BlocComunidadAcademicaEventoOrdenarAlfabeticamente}
/// Ordena los usuarios alfabeticamente
/// {@endtemplate}
class BlocComunidadAcademicaEventoOrdenarAlfabeticamente
    extends BlocComunidadAcademicaEvento {}

/// {@template BlocComunidadAcademicaEventoOrdenarPorCurso}
/// Ordena los usuarios por curso
/// {@endtemplate}
class BlocComunidadAcademicaEventoOrdenarPorCurso
    extends BlocComunidadAcademicaEvento {}

/// {@template BlocComunidadAcademicaEventoOrdenarPorAsignatura}
/// Ordena los usuarios por asignatura
/// {@endtemplate}
class BlocComunidadAcademicaEventoOrdenarPorAsignatura
    extends BlocComunidadAcademicaEvento {}
