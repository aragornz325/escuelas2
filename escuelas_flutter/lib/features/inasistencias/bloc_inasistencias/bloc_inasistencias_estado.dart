part of 'bloc_inasistencias.dart';

/// {@template BlocInasistenciasEstado}
/// Bloc que maneja el estado de las asistencias
/// {@endtemplate}
@immutable
class BlocInasistenciasEstado {
  /// {@macro BlocInasistenciasEstado}
  const BlocInasistenciasEstado._({
    this.asistencias = const [],
    this.cursos = const [],
    this.index = -1,
  });

  BlocInasistenciasEstado.desde(
    BlocInasistenciasEstado otro, {
    List<ComisionDeCurso>? cursos,
    int? index,
    List<List<AsistenciaDiaria>>? asistencias,
  }) : this._(
          cursos: cursos ?? otro.cursos,
          index: index ?? otro.index,
          asistencias: asistencias ?? otro.asistencias,
        );

  /// Lista de los cursos
  final List<ComisionDeCurso> cursos;

  /// Indice del curso
  final int index;

  /// Lista de estados de asistencias de los alumnos
  final List<List<AsistenciaDiaria>> asistencias;

  /// Getter para saber la lista de alumnos con sus asistencias
  List<AsistenciaDiaria> asistenciasDiarias(int idCurso) => asistencias
      .expand(
        (lista) => lista.where((e) => e.comisionId == idCurso),
      )
      .toList();

  List<Object> get props => [
        cursos,
        index,
        asistencias,
      ];
}

/// {@template BlocInasistenciasEstadoInicial}
/// Estado Inicial de la pagina de 'Asistencias'
/// {@endtemplate}
class BlocInasistenciasEstadoInicial extends BlocInasistenciasEstado {
  /// {@macro BlocInasistenciasEstadoInicial}
  const BlocInasistenciasEstadoInicial() : super._();
}

/// {@template BlocInasistenciasEstadoCargando}
/// Estado Cargando de la pagina de 'Asistencias'
/// {@endtemplate}
class BlocInasistenciasEstadoCargando extends BlocInasistenciasEstado {
  /// {@macro BlocInasistenciasEstadoCargando}
  BlocInasistenciasEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocInasistenciasEstadoExitoso}
/// Estado Exitoso de la pagina de 'Asistencias'
/// {@endtemplate}
class BlocInasistenciasEstadoExitoso extends BlocInasistenciasEstado {
  /// {@macro BlocInasistenciasEstadoExitoso}
  BlocInasistenciasEstadoExitoso.desde(
    super.otro, {
    required super.cursos,
    super.index,
    super.asistencias,
  }) : super.desde();
}

/// {@template BlocInasistenciasEstadoFallido}
/// Estado Fallido de la pagina de 'Asistencias'
/// {@endtemplate}
class BlocInasistenciasEstadoFallido extends BlocInasistenciasEstado {
  /// {@macro BlocInasistenciasEstadoFallido}
  BlocInasistenciasEstadoFallido.desde(super.otro) : super.desde();
}
