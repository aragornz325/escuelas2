part of 'bloc_calificaciones_anuales.dart';

/// {@template BlocCalificacionesAnualesEstado}
/// Bloc que maneja el estado de las calificaciones anuales de un alumno.
/// {@endtemplate}
@immutable
class BlocCalificacionesAnualesEstado {
  /// {@macro BlocCalificacionesAnualesEstado}
  const BlocCalificacionesAnualesEstado._({
    this.listaCalificacionesAnuales = const [],
  });

  BlocCalificacionesAnualesEstado.desde(
    BlocCalificacionesAnualesEstado otro, {
    List<CalificacionMensual>? listaCalificacionesAnuales,
  }) : this._(
          listaCalificacionesAnuales:
              listaCalificacionesAnuales ?? otro.listaCalificacionesAnuales,
        );

  List<Object?> get props => [
        listaCalificacionesAnuales,
      ];

  /// Lista de las calificaciones anuales del alumno.
  final List<CalificacionMensual?> listaCalificacionesAnuales;

  /// Obtiene el nombre de la asignatura, si bien es una lista
  /// de [CalificacionMensual]
  /// todas comparten el mismo ID, son la misma asignatura todos los elementos.
  String get nombreAsignatura {
    if (listaCalificacionesAnuales.isEmpty) {
      return '';
    }
    return listaCalificacionesAnuales.first?.calificacion?.asignatura?.nombre ??
        '';
  }

  /// Obtiene el promedio anual del alumno de la asignatura.
  double get promedioAsignaturaAnual {
    final calificaciones = listaCalificacionesAnuales
        .where((calificacion) => calificacion?.calificacion?.index != null)
        .map((calificacion) => calificacion!.calificacion!.index);

    if (calificaciones.isEmpty) {
      return 0;
    }

    final suma = calificaciones.fold(
      0,
      (acumulador, valorCalificacion) => acumulador + valorCalificacion,
    );
    final promedio = suma / calificaciones.length;

    return double.parse(promedio.toStringAsFixed(2));
  }

  /// Trae la lista de calificaciones por mes, para luego emparejar
  /// el mes con la calificacion.
  List<CalificacionMensual?> traerListaCalificacionesPorMes(int monthIndex) {
    return listaCalificacionesAnuales
        .where((calificacion) => calificacion?.numeroDeMes == monthIndex + 1)
        .toList();
  }

  /// Obtiene el valor de la calificacion de acuerdo al index del enum Meses.
  int? obtenerCalificacionPorMes(int monthIndex) {
    final calificacionList = traerListaCalificacionesPorMes(monthIndex);

    return calificacionList.isEmpty
        ? null
        : calificacionList.first?.calificacion?.index;
  }
}

/// {@template BlocCalificacionesAnualesEstadoInicial}
/// Estado Inicial de la pagina de Calificaciones Anuales
/// {@endtemplate}
class BlocCalificacionesAnualesEstadoInicial
    extends BlocCalificacionesAnualesEstado {
  /// {@macro BlocCalificacionesAnualesEstadoInicial}
  const BlocCalificacionesAnualesEstadoInicial() : super._();
}

/// {@template BlocCalificacionesAnualesEstadoCargando}
/// Estado Cargando de la pagina de Calificaciones Anuales
/// {@endtemplate}
class BlocCalificacionesAnualesEstadoCargando
    extends BlocCalificacionesAnualesEstado {
  /// {@macro BlocCalificacionesAnualesEstadoCargando}
  BlocCalificacionesAnualesEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocCalificacionesAnualesEstadoExitoso}
/// Estado Exitoso de la pagina Calificaciones Anuales
/// {@endtemplate}
class BlocCalificacionesAnualesEstadoExitoso
    extends BlocCalificacionesAnualesEstado {
  /// {@macro BlocCalificacionesAnualesEstadoExitoso}
  BlocCalificacionesAnualesEstadoExitoso.desde(
    super.otro, {
    super.listaCalificacionesAnuales,
  }) : super.desde();
}

/// {@template BlocCalificacionesAnualesEstadoFallido}
/// Estado Fallido de la pagina Calificaciones Anuales
/// {@endtemplate}
class BlocCalificacionesAnualesEstadoFallido
    extends BlocCalificacionesAnualesEstado {
  /// {@macro BlocCalificacionesAnualesEstadoFallido}
  BlocCalificacionesAnualesEstadoFallido.desde(super.otro) : super.desde();
}
