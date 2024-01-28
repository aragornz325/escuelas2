part of 'bloc_inasistencias.dart';

/// {@template BlocInasistenciasEstado}
/// Bloc que maneja el estado de las inasistencias
/// {@endtemplate}
@immutable
class BlocInasistenciasEstado {
  /// {@macro BlocInasistenciasEstado}
  const BlocInasistenciasEstado._({
    this.comisionesConAsistencias = const [],
    this.fechaActual,
  });

  BlocInasistenciasEstado.desde(
    BlocInasistenciasEstado otro, {
    DateTime? fechaActual,
    List<ComisionConAsistencias>? inasistenciasPorComision,
  }) : this._(
          comisionesConAsistencias:
              inasistenciasPorComision ?? otro.comisionesConAsistencias,
          fechaActual: fechaActual ?? otro.fechaActual,
        );

  /// Fecha en la que se finalizaron las inasistencias
  final DateTime? fechaActual;

  final List<ComisionConAsistencias> comisionesConAsistencias;

  List<Object?> get props => [
        fechaActual,
        comisionesConAsistencias,
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
    super.inasistenciasPorComision,
    super.fechaActual,
  }) : super.desde();
}

/// {@template BlocInasistenciasEstadoExitosoEnvioDeInasistencias}
/// Muestra un popup de que las inasistencias se enviaron.
/// {@endtemplate}
class BlocInasistenciasEstadoExitosoEnvioDeInasistencias
    extends BlocInasistenciasEstado {
  /// {@macro BlocInasistenciasEstadoExitosoEnvioDeInasistencias}
  BlocInasistenciasEstadoExitosoEnvioDeInasistencias.desde(
    super.otro, {
    super.inasistenciasPorComision,
    super.fechaActual,
  }) : super.desde();
}

/// {@template BlocInasistenciasEstadoFallido}
/// Estado Fallido de la pagina de 'inasistencias'
/// {@endtemplate}
class BlocInasistenciasEstadoFallido extends BlocInasistenciasEstado {
  /// {@macro BlocInasistenciasEstadoFallido}
  BlocInasistenciasEstadoFallido.desde(super.otro) : super.desde();
}
