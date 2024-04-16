part of 'bloc_supervision_comisiones.dart';

/// {@template BlocSupervisionComisionesEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocSupervisionComisionesEstado {
  /// {@macro BlocSupervisionComisionesEstado}
  const BlocSupervisionComisionesEstado._({
    this.listaSupervisionComisiones = const [],
    this.fecha,
  });

  BlocSupervisionComisionesEstado.desde(
    BlocSupervisionComisionesEstado otro, {
    List<SupervisionDeCurso>? listaSupervisionComisiones,
    DateTime? fecha,
  }) : this._(
          listaSupervisionComisiones:
              listaSupervisionComisiones ?? otro.listaSupervisionComisiones,
          fecha: fecha ?? otro.fecha,
        );

  /// Lista de supervisiones de comisiones
  final List<SupervisionDeCurso> listaSupervisionComisiones;

  /// Fecha del selector, para saber que periodo se esta supervisando
  final DateTime? fecha;

  /// Devuelve la fecha de la ultima asignatura cargada
  DateTime? get fechaUltimaAsignaturaCargada {
    DateTime? fechaMasActual;
    for (final supervisionComision in listaSupervisionComisiones) {
      if (supervisionComision
              .comision.solicitudesCalificacionMensual?.isEmpty ??
          true) {
        return null;
      }

      final solicitudMasActual =
          supervisionComision.comision.solicitudesCalificacionMensual?.last;
      final fechaRealizacion = solicitudMasActual?.solicitud?.fechaRealizacion;

      if (fechaMasActual == null ||
          (fechaRealizacion != null &&
              fechaRealizacion.isAfter(fechaMasActual))) {
        fechaMasActual = fechaRealizacion;
      }
    }
    return fechaMasActual;
  }

  /// Devuelve si todas las asignaturas de todas las comisiones estan cargadas
  bool get todasAsignaturasCargadasDeTodasLasComisiones =>
      listaSupervisionComisiones.every(
        (supervisionCurso) =>
            supervisionCurso.comision.solicitudesCalificacionMensual?.every(
              (element) => element.solicitud?.fechaRealizacion != null,
            ) ??
            false,
      );
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

/// {@template BlocSupervisionComisionEstadoCargandoAlMandarEmails}
/// Estado de cargando al enviar los emails de las calificaciones.
/// {@endtemplate}
class BlocSupervisionComisionEstadoCargandoAlMandarEmails
    extends BlocSupervisionComisionesEstado {
  /// {@macro BlocSupervisionComisionEstadoCargandoAlMandarEmails}
  BlocSupervisionComisionEstadoCargandoAlMandarEmails.desde(super.otro)
      : super.desde();
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
    super.listaSupervisionComisiones,
    super.fecha,
  }) : super.desde();
}

/// {@template BlocSupervisionComisionEstadoExitosoAlMandarEmails}
/// Estado exitoso para saber si se mandaron las calificaciones/emails
/// {@endtemplate}
class BlocSupervisionComisionEstadoExitosoAlMandarEmails
    extends BlocSupervisionComisionesEstado {
  /// {@macro BlocSupervisionComisionEstadoExitosoAlMandarEmails}
  BlocSupervisionComisionEstadoExitosoAlMandarEmails.desde(super.otro)
      : super.desde();
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
