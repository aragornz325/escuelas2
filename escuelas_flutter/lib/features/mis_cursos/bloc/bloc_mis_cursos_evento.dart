part of 'bloc_mis_cursos.dart';

/// {@template BlocMisCursosEvento}
/// Clase padre de los eventos de 'Mis Cursos'
/// {@endtemplate}
abstract class BlocMisCursosEvento {
  /// {@macro BlocMisCursosEvento}
  const BlocMisCursosEvento();
}

/// {@template BlocMisCursosEventoicializar}
/// Inicializa la pagina, en este caso, trae las materias asignadas al usuario
class BlocMisCursosEventoInicializar extends BlocMisCursosEvento {}
