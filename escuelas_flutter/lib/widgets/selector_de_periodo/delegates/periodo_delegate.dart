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

  int get cantidadDePeriodosVisibles => throw UnimplementedError();

  /// Los periodos posterior al actualmente seleccionado
  List<Periodo> get periodosPosteriores => throw UnimplementedError();

  Widget buildPeriodoActual({required Periodo periodo}) =>
      DefaultPeriodoActual(periodo: periodo);

  Widget buildPeriodosAnteriores({
    required void Function() onSeleccionarPeriodo,
    required Periodo periodo,
  }) =>
      DefaultPeriodoAnterior(
          onSeleccionarPeriodo: onSeleccionarPeriodo, periodo: periodo);

  Widget buildPeriodosPosteriores({
    required void Function() onSeleccionarPeriodo,
    required Periodo periodo,
  }) =>
      DefaultPeriodoPosterior(
          onSeleccionarPeriodo: onSeleccionarPeriodo, periodo: periodo);
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
    this.etiqueta2,
  });

  /// La etiqueta del periodo
  final String etiqueta;
  final String? etiqueta2;

  /// La fecha del periodo
  final DateTime fechaDesde;
  final DateTime fechaHasta;
}
