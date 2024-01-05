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

  /// Lista de asignaturas del curso a supervisar
  final List<Asignatura> listaAsignaturas;

  /// Fecha del periodo a supervisar
  final DateTime? fecha;

  List<Asignatura> get asignaturasFaltantes => [];
  // TODO(anyone): Ver como saber si una asignatura no tiene fecha de envio
  // listaAsignaturas.where((asignatura) => asignatura.fecha == null).toList();
}

/// {@template BlocSupervisionEnvioCalificacionesEstadoInicial}
/// Estado inicial de los componentes de la pantalla
/// 'Supervision de envio deCalificaciones'
/// {@endtemplate}
class BlocSupervisionEnvioCalificacionesEstadoInicial
    extends BlocSupervisionEnvioCalificacionesEstado {
  /// {@macro BlocSupervisionEnvioCalificacionesEstadoInicial}
  const BlocSupervisionEnvioCalificacionesEstadoInicial() : super._();
}

/// {@template BlocSupervisionEnvioCalificacionesEstadoCargando}
/// Estado de cargando de los componentes de la pantalla
/// 'Supervision de envio de Calificaciones'
/// {@endtemplate}
class BlocSupervisionEnvioCalificacionesEstadoCargando
    extends BlocSupervisionEnvioCalificacionesEstado {
  /// {@macro BlocSupervisionEnvioCalificacionesEstadoCargando}
  BlocSupervisionEnvioCalificacionesEstadoCargando.desde(super.otro)
      : super.desde();
}

/// {@template BlocSupervisionEnvioCalificacionesEstadoExitoso}
/// Estado exitoso general de los componentes de la pantalla
/// 'Supervision de envio de Calificaciones'
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
/// Estado de error de los componentes de la pantalla
/// 'Supervision de envio de Calificaciones'
/// {@endtemplate}
class BlocSupervisionEnvioCalificacionesEstadoError
    extends BlocSupervisionEnvioCalificacionesEstado {
  /// {@macro BlocSupervisionEnvioCalificacionesEstadoError}
  BlocSupervisionEnvioCalificacionesEstadoError.desde(super.otro)
      : super.desde();
}
