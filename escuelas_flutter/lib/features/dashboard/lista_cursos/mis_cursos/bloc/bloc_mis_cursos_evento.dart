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
  const BlocMisCursosEventoInicializar({required this.usuarioId});

  final int usuarioId;
}

/// {@template BlocMisCursosEventoCambiarMes}
/// Cambia el mes de la pagina y trae las materias asignadas al usuario en ese
/// mes
/// {@endtemplate}
class BlocMisCursosEventoCambiarMes extends BlocMisCursosEvento {
  /// {@macro BlocMisCursosEventoCambiarMes}
  const BlocMisCursosEventoCambiarMes({
    required this.periodoSeleccionada,
    required this.usuarioId,
  });

  final int usuarioId;

  /// PeriodoSeleccionado
  final DateTime periodoSeleccionada;
}

/// {@template BlocMisCursosEventoInicializarDirectivo}
/// incializa la pagina,donde si es directivo llama a este evento y trae
/// todas las comisiones de la institucion y sus asignatura
/// {@endtemplate}
class BlocMisCursosEventoInicializarDirectivo extends BlocMisCursosEvento {
  /// {@macro BlocMisCursosEventoInicializarDirectivo}
  const BlocMisCursosEventoInicializarDirectivo();
}
