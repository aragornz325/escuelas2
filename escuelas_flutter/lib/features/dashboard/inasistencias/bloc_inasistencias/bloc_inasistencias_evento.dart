part of 'bloc_inasistencias.dart';

/// {@template BlocInasistenciasEvento}
/// Bloc que maneja los eventos generales de la pagina 'Asistencias'
/// {@endtemplate}
abstract class BlocInasistenciasEvento {
  /// {@macro BlocInasistenciasEvento}
  const BlocInasistenciasEvento();
}

/// {@template BlocInasistenciasEventoInicializar}
/// Evento Inicial que obtiene todos los cursos para tomar asistencias
/// {@endtemplate}
class BlocInasistenciasEventoInicializar extends BlocInasistenciasEvento {
  /// {@macro BlocInasistenciasEventoInicializar}
  const BlocInasistenciasEventoInicializar({required this.fecha});

  /// Fecha de la fecha a tomar del calendario
  final DateTime fecha;
}

/// {@template BlocInasistenciasEventoCrearInasistencias}
/// Evento para crear las inasistencias de los estudiantes de una
/// comision en particular.
/// {@endtemplate}
class BlocInasistenciasEventoCrearInasistencias
    extends BlocInasistenciasEvento {
  /// {@macro BlocInasistenciasEventoCrearInasistencias}
  const BlocInasistenciasEventoCrearInasistencias({
    required this.idComision,
    required this.inasistencias,
  });

  /// Id de la comision a modificar si se tomo asistencia.
  final int idComision;

  /// Lista de inasistencias a crear
  final List<AsistenciaDiaria> inasistencias;
}

/// {@template BlocInasistenciasEventoEditarInasistencias}
/// Evento para crear las inasistencias de los estudiantes de una
/// comision en particular.
/// {@endtemplate}
class BlocInasistenciasEventoEditarInasistencias
    extends BlocInasistenciasEvento {
  /// {@macro BlocInasistenciasEventoEditarInasistencias}
  const BlocInasistenciasEventoEditarInasistencias({
    required this.idComision,
    required this.inasistencias,
  });

  /// Id de la comision a modificar si se tomo asistencia.
  final int idComision;

  /// Lista de inasistencias a modificar
  final List<AsistenciaDiaria> inasistencias;
}
