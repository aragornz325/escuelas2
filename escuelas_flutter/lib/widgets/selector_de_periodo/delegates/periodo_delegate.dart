import 'package:escuelas_flutter/widgets/selector_de_periodo/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// {@template PeriodoDelegate}
/// Delegado para el selector de periodo.
/// {@endtemplate}
abstract class PeriodoDelegate {
  /// {@macro PeriodoDelegate}
  PeriodoDelegate(PeriodoDelSelector periodoInicial)
      : periodoActual = periodoInicial;

  /// El periodo actualmente seleccionado
  PeriodoDelSelector periodoActual;

  /// Los periodos anterior al actualmente seleccionado
  List<PeriodoDelSelector> get periodosAnterior => throw UnimplementedError();

  /// Cantidad de periodos visibles tiene que ser impar
  /// (Ej: 3, 5, 7, etc.)
  int get cantidadDePeriodosVisibles => throw UnimplementedError();

  /// Los periodos posterior al actualmente seleccionado
  List<PeriodoDelSelector> get periodosPosteriores =>
      throw UnimplementedError();

  /// Representa el periodo actualmente seleccionado
  Widget buildPeriodoActual({required PeriodoDelSelector periodo}) =>
      DefaultPeriodoActual(periodo: periodo);

  /// Representa los widgets de los periodos anteriores
  Widget buildPeriodosAnteriores({
    required void Function() onSeleccionarPeriodo,
    required PeriodoDelSelector periodo,
  }) =>
      DefaultPeriodoAnterior(
        onSeleccionarPeriodo: onSeleccionarPeriodo,
        periodo: periodo,
      );

  /// Representa los widgets de los periodos posteriores
  Widget buildPeriodosPosteriores({
    required void Function() onSeleccionarPeriodo,
    required PeriodoDelSelector periodo,
  }) =>
      DefaultPeriodoPosterior(
        onSeleccionarPeriodo: onSeleccionarPeriodo,
        periodo: periodo,
      );
}

/// {@template Periodo}
/// Representa un periodo de tiempo
/// {@endtemplate}
class PeriodoDelSelector {
  /// {@macro Periodo}
  PeriodoDelSelector({
    required this.etiqueta,
    required this.fechaDesde,
    required this.fechaHasta,
  });

  /// La etiqueta del periodo
  final String etiqueta;

  /// La fecha del periodo
  final DateTime fechaDesde;
  final DateTime fechaHasta;
}
