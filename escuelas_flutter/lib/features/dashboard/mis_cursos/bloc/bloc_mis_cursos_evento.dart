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
/// {@endtemplate}
class BlocMisCursosEventoInicializar extends BlocMisCursosEvento {
  /// {@macro BlocMisCursosEventoicializar}
  const BlocMisCursosEventoInicializar();
}

/// {@template BlocMisCursosEventoCambiarMes}
/// Cambia el mes de la pagina y trae las materias asignadas al usuario en ese
/// mes
/// {@endtemplate}
class BlocMisCursosEventoCambiarMes extends BlocMisCursosEvento {
  /// {@macro BlocMisCursosEventoCambiarMes}
  const BlocMisCursosEventoCambiarMes({
    required this.periodoSeleccionada,
  });

  /// PeriodoSeleccionado
  final DateTime periodoSeleccionada;
}
