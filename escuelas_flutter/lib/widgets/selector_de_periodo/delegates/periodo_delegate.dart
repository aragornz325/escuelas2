import 'package:flutter/material.dart';

/// {@template PeriodoDelegate}
///
/// {@endtemplate}
abstract class PeriodoDelegate {
  PeriodoDelegate(Periodo periodoInicial) : periodoActual = periodoInicial;

  /// El periodo actualmente seleccionado
  late Periodo periodoActual;

  /// El periodo anterior al actualmente seleccionado
  Periodo get periodoAnterior => throw UnimplementedError();

  /// El periodo posterior al actualmente seleccionado
  Periodo get periodoPosterior => throw UnimplementedError();

  /// Ejecuta una acción al retroceder el periodo.
  void Function(Periodo periodo)? get onRetroceder =>
      throw UnimplementedError();

  /// Ejecuta una acción al avanzar el periodo.
  void Function(Periodo periodo)? get onAvanzar => throw UnimplementedError();

  /// Retrocede el periodo actual
  @mustCallSuper
  Periodo retrocederPeriodo() {
    onRetroceder?.call(periodoActual);
    return periodoActual = periodoAnterior;
  }

  /// Avanza el periodo actual
  @mustCallSuper
  Periodo avanzarPeriodo() {
    onAvanzar?.call(periodoActual);
    return periodoActual = periodoPosterior;
  }
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
