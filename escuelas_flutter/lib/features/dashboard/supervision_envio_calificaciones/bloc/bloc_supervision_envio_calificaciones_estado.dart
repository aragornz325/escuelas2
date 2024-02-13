part of 'bloc_supervision_envio_calificaciones.dart';

/// {@template BlocSupervisionEnvioCalificacionesEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocSupervisionEnvioCalificacionesEstado {
  /// {@macro BlocSupervisionEnvioCalificacionesEstado}
  const BlocSupervisionEnvioCalificacionesEstado._({
    required this.idComision,
    this.fecha,
    this.listaAsignaturas = const [],
  });

  BlocSupervisionEnvioCalificacionesEstado.desde(
    BlocSupervisionEnvioCalificacionesEstado otro, {
    List<EstadoCalificacionesAsignatura>? listaAsignaturas,
    DateTime? fecha,
    int? idCurso,
  }) : this._(
          idComision: idCurso ?? otro.idComision,
          listaAsignaturas: listaAsignaturas ?? otro.listaAsignaturas,
          fecha: fecha ?? otro.fecha,
        );

  /// Lista de asignaturas del curso a supervisar
  final List<EstadoCalificacionesAsignatura> listaAsignaturas;

  /// Fecha del periodo a supervisar
  final DateTime? fecha;

  int get asignaturasFaltantes => listaAsignaturas
      .where((element) => element.fechaRealizacionSolicitud == null)
      .length;

  /// Id de la comision
  final int idComision;

  bool get exitosoAlEnviarCalificaciones => this
      is BlocSupervisionEnvioCalificacionesEstadoExitosoAlEnviarCalificaciones;

  bool get exitosoAlSolicitarCargaDeCalificaciones => this
      // ignore: lines_longer_than_80_chars
      is BlocSupervisionEnvioCalificacionesEstadoExitosoAlSolicitarCaliFaltantes;
}

/// {@template BlocSupervisionEnvioCalificacionesEstadoInicial}
/// Estado inicial de los componentes de la pantalla
/// 'Supervision de envio deCalificaciones'
/// {@endtemplate}
class BlocSupervisionEnvioCalificacionesEstadoInicial
    extends BlocSupervisionEnvioCalificacionesEstado {
  /// {@macro BlocSupervisionEnvioCalificacionesEstadoInicial}
  const BlocSupervisionEnvioCalificacionesEstadoInicial(
    int idComision,
    DateTime fecha,
  ) : super._(
          idComision: idComision,
          fecha: fecha,
        );
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

// ignore: lines_longer_than_80_chars
/// {@template BlocSupervisionEnvioCalificacionesEstadoExitosoAlSolicitarCaliFaltantes}
/// Estado exitoso al solicitar las calificaciones faltantes para que los
/// docentes puedan cargarlas.
/// {@endtemplate}
class BlocSupervisionEnvioCalificacionesEstadoExitosoAlSolicitarCaliFaltantes
    extends BlocSupervisionEnvioCalificacionesEstado {
  // ignore: lines_longer_than_80_chars
  /// {@macro BlocSupervisionEnvioCalificacionesEstadoExitosoAlSolicitarCaliFaltantes}
  BlocSupervisionEnvioCalificacionesEstadoExitosoAlSolicitarCaliFaltantes.desde(
    super.otro,
  ) : super.desde();
}

// ignore: lines_longer_than_80_chars
/// {@template BlocSupervisionEnvioCalificacionesEstadoExitosoAlEnviarCalificaciones}
/// Estado exitoso cuando se envia las calificaciones a los tutores/padres de
/// los alumnos
/// {@endtemplate}
class BlocSupervisionEnvioCalificacionesEstadoExitosoAlEnviarCalificaciones
    extends BlocSupervisionEnvioCalificacionesEstado {
  // ignore: lines_longer_than_80_chars
  /// {@macro BlocSupervisionEnvioCalificacionesEstadoExitosoAlEnviarCalificaciones}
  BlocSupervisionEnvioCalificacionesEstadoExitosoAlEnviarCalificaciones.desde(
    super.otro,
  ) : super.desde();
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
