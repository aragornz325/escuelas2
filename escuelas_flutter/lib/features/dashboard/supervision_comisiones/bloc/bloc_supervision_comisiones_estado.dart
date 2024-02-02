part of 'bloc_supervision_comisiones.dart';

/// {@template BlocSupervisionComisionesEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocSupervisionComisionesEstado {
  /// {@macro BlocSupervisionComisionesEstado}
  const BlocSupervisionComisionesEstado._({
    this.listaComisiones = const [],
  });

  BlocSupervisionComisionesEstado.desde(
    BlocSupervisionComisionesEstado otro, {
    List<SupervisionDeCurso>? listaComisiones,
  }) : this._(
          listaComisiones: listaComisiones ?? otro.listaComisiones,
        );

  final List<SupervisionDeCurso> listaComisiones;

  bool get todasMateriasCargadas => true;

  bool get habilitacionCargaDeCalificaciones => true;

  DateTime get fechaUltimaMateriaCargada => DateTime.now();
}

/// {@template BlocSupervisionComisionEstadoInicial}
/// Estado inicial de los componentes de la pantalla 'Supervision Comisiones'
/// {@endtemplate}
class BlocSupervisionComisionEstadoInicial
    extends BlocSupervisionComisionesEstado {
  /// {@macro BlocSupervisionComisionEstadoInicial}
  const BlocSupervisionComisionEstadoInicial() : super._();
}

/// {@template BlocSupervisionComisionEstadoCargando}
/// Estado de cargando de los componentes de la pantalla
/// 'Supervision Comisiones'
/// {@endtemplate}
class BlocSupervisionComisionEstadoCargando
    extends BlocSupervisionComisionesEstado {
  /// {@macro BlocSupervisionComisionEstadoCargando}
  BlocSupervisionComisionEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocSupervisionComisionEstadoExitoso}
/// Estado exitoso general de los componentes de la pantalla
/// 'Supervision Comisiones'
/// {@endtemplate}
class BlocSupervisionComisionEstadoExitoso
    extends BlocSupervisionComisionesEstado {
  /// {@macro BlocSupervisionComisionEstadoExitoso}
  BlocSupervisionComisionEstadoExitoso.desde(
    super.otro, {
    super.listaComisiones,
  }) : super.desde();
}

/// {@template BlocSupervisionComisionEstadoError}
/// Estado de error de los componentes de la pantalla
/// 'Supervision Comisiones'
/// {@endtemplate}
class BlocSupervisionComisionEstadoError
    extends BlocSupervisionComisionesEstado {
  /// {@macro BlocSupervisionComisionEstadoError}
  BlocSupervisionComisionEstadoError.desde(super.otro) : super.desde();
}
