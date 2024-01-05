import 'package:escuelas_flutter/widgets/selector_de_periodo/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// {@template PeriodoDelegate}
/// Delegado para el selector de periodo.
/// {@endtemplate}
abstract class PeriodoDelegate {
  /// {@macro PeriodoDelegate}
  PeriodoDelegate(Periodo periodoInicial) : periodoActual = periodoInicial;

  /// El periodo actualmente seleccionado
  Periodo periodoActual;

  /// Los periodos anterior al actualmente seleccionado
  List<Periodo> get periodosAnterior => throw UnimplementedError();

  /// Cantidad de periodos visibles tiene que ser impar
  /// (Ej: 3, 5, 7, etc.)
  int get cantidadDePeriodosVisibles => throw UnimplementedError();

  /// Los periodos posterior al actualmente seleccionado
  List<Periodo> get periodosPosteriores => throw UnimplementedError();

  /// Representa el periodo actualmente seleccionado
  Widget buildPeriodoActual({required Periodo periodo}) =>
      DefaultPeriodoActual(periodo: periodo);

  /// Representa los widgets de los periodos anteriores
  Widget buildPeriodosAnteriores({
    required void Function() onSeleccionarPeriodo,
    required Periodo periodo,
  }) =>
      DefaultPeriodoAnterior(
        onSeleccionarPeriodo: onSeleccionarPeriodo,
        periodo: periodo,
      );

  /// Representa los widgets de los periodos posteriores
  Widget buildPeriodosPosteriores({
    required void Function() onSeleccionarPeriodo,
    required Periodo periodo,
  }) =>
      DefaultPeriodoPosterior(
        onSeleccionarPeriodo: onSeleccionarPeriodo,
        periodo: periodo,
      );
}

/// {@template Periodo}
/// Representa un periodo de tiempo
/// {@endtemplate}
class Periodo {
  /// {@macro Periodo}
  Periodo({
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
