part of 'bloc_supervision_envio_calificaciones.dart';

/// {@template BlocSupervisionEnvioCalificacionesEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocSupervisionEnvioCalificacionesEstado {
  /// {@macro BlocSupervisionEnvioCalificacionesEstado}
  const BlocSupervisionEnvioCalificacionesEstado._({
    this.fecha,
    this.listaAsignaturas = const [],
  });

  BlocSupervisionEnvioCalificacionesEstado.desde(
    BlocSupervisionEnvioCalificacionesEstado otro, {
    List<Asignatura>? listaAsignaturas,
    DateTime? fecha,
  }) : this._(
          listaAsignaturas: listaAsignaturas ?? otro.listaAsignaturas,
          fecha: fecha ?? otro.fecha,
        );
  final List<Asignatura> listaAsignaturas;
  final DateTime? fecha;
}

/// {@template BlocSupervisionEnvioCalificacionesEstadoInicial}
/// Estado inicial de los componentes de la pantalla 'Inicio'
/// {@endtemplate}
class BlocSupervisionEnvioCalificacionesEstadoInicial
    extends BlocSupervisionEnvioCalificacionesEstado {
  /// {@macro BlocSupervisionEnvioCalificacionesEstadoInicial}
  const BlocSupervisionEnvioCalificacionesEstadoInicial() : super._();
}

/// {@template BlocSupervisionEnvioCalificacionesEstadoCargando}
/// Estado de cargando de los componentes de la pantalla 'Inicio'
/// {@endtemplate}
class BlocSupervisionEnvioCalificacionesEstadoCargando
    extends BlocSupervisionEnvioCalificacionesEstado {
  /// {@macro BlocSupervisionEnvioCalificacionesEstadoCargando}
  BlocSupervisionEnvioCalificacionesEstadoCargando.desde(super.otro)
      : super.desde();
}

/// {@template BlocSupervisionEnvioCalificacionesEstadoExitoso}
/// Estado exitoso general de los componentes de la pantalla 'Inicio'
/// {@endtemplate}
class BlocSupervisionEnvioCalificacionesEstadoExitoso
    extends BlocSupervisionEnvioCalificacionesEstado {
  /// {@macro BlocSupervisionEnvioCalificacionesEstadoExitoso}
  BlocSupervisionEnvioCalificacionesEstadoExitoso.desde(
    super.otro, {
    super.listaAsignaturas,
    super.fecha,
  }) : super.desde();
}

/// {@template BlocSupervisionEnvioCalificacionesEstadoFallido}
/// Estado de error de los componentes de la pantalla 'Inicio'
/// {@endtemplate}
class BlocSupervisionEnvioCalificacionesEstadoError
    extends BlocSupervisionEnvioCalificacionesEstado {
  /// {@macro BlocSupervisionEnvioCalificacionesEstadoError}
  BlocSupervisionEnvioCalificacionesEstadoError.desde(super.otro)
      : super.desde();
}
