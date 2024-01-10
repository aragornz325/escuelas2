part of 'bloc_inasistencias.dart';

/// {@template BlocInasistenciasEstado}
/// Bloc que maneja el estado de las inasistencias
/// {@endtemplate}
@immutable
class BlocInasistenciasEstado {
  /// {@macro BlocInasistenciasEstado}
  const BlocInasistenciasEstado._({
    this.asistenciaAModificar = const [],
    this.todasInasistencias = const [],
    this.inasistencias = const [],
    this.comisiones = const [],
    this.fechaActual,
  });

  BlocInasistenciasEstado.desde(
    BlocInasistenciasEstado otro, {
    List<ComisionDeCurso>? comisiones,
    DateTime? fechaActual,
    List<List<AsistenciaDiaria>>? inasistencias,
    List<AsistenciaDiaria>? asistenciaAModificar,
    List<AsistenciaDiaria>? todasInasistencias,
  }) : this._(
          comisiones: comisiones ?? otro.comisiones,
          asistenciaAModificar:
              asistenciaAModificar ?? otro.asistenciaAModificar,
          inasistencias: inasistencias ?? otro.inasistencias,
          fechaActual: fechaActual ?? otro.fechaActual,
          todasInasistencias: todasInasistencias ?? otro.todasInasistencias,
        );

  /// Lista de las comisiones de los cursos
  final List<ComisionDeCurso> comisiones;

  /// Lista de estados de inasistencias de los alumnos
  final List<List<AsistenciaDiaria>> inasistencias;

  /// Fecha en la que se finalizaron las inasistencias
  final DateTime? fechaActual;

  /// Lista de todas las inasistencias
  final List<AsistenciaDiaria> todasInasistencias;

  /// Lista de alumnos con sus inasistencias a modificar.
  final List<AsistenciaDiaria> asistenciaAModificar;

  /// Getter para saber la lista de alumnos con sus inasistencias
  List<AsistenciaDiaria> asistenciasDiarias(int idCurso) => inasistencias
      .expand(
        (lista) => lista.where((e) => e.comisionId == idCurso),
      )
      .toList();

  List<Object?> get props => [
        comisiones,
        fechaActual,
        inasistencias,
        todasInasistencias,
        asistenciaAModificar,
      ];
}

/// {@template BlocInasistenciasEstadoInicial}
/// Estado Inicial de la pagina de 'inasistencias'
/// {@endtemplate}
class BlocInasistenciasEstadoInicial extends BlocInasistenciasEstado {
  /// {@macro BlocInasistenciasEstadoInicial}
  const BlocInasistenciasEstadoInicial() : super._();
}

/// {@template BlocInasistenciasEstadoCargando}
/// Estado Cargando de la pagina de 'inasistencias'
/// {@endtemplate}
class BlocInasistenciasEstadoCargando extends BlocInasistenciasEstado {
  /// {@macro BlocInasistenciasEstadoCargando}
  BlocInasistenciasEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocInasistenciasEstadoExitoso}
/// Estado Exitoso de la pagina de 'inasistencias'
/// {@endtemplate}
class BlocInasistenciasEstadoExitoso extends BlocInasistenciasEstado {
  /// {@macro BlocInasistenciasEstadoExitoso}
  BlocInasistenciasEstadoExitoso.desde(
    super.otro, {
    required super.comisiones,
    super.inasistencias,
    super.fechaActual,
    super.asistenciaAModificar,
    super.todasInasistencias,
  }) : super.desde();
}

/// {@template BlocInasistenciasEstadoFallido}
/// Estado Fallido de la pagina de 'inasistencias'
/// {@endtemplate}
class BlocInasistenciasEstadoFallido extends BlocInasistenciasEstado {
  /// {@macro BlocInasistenciasEstadoFallido}
  BlocInasistenciasEstadoFallido.desde(super.otro) : super.desde();
}
