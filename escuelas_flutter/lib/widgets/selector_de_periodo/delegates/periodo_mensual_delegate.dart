import 'package:escuelas_flutter/extensiones/date_time.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/delegates/periodo_delegate.dart';
import 'package:flutter/material.dart';

/// {@template PeriodoMensualDelegate}
/// Representa un periodo de tiempo de forma mensual
/// {@endtemplate}
class PeriodoMensualDelegate extends PeriodoDelegate {
  /// {@macro PeriodoMensualDelegate}
  PeriodoMensualDelegate(this.context)
      : super(
          Periodo(
            etiqueta: DateTime.now().nombreMes(context).toUpperCase(),
            fechaDesde: DateTime.now().copyWith(day: 1),
            fechaHasta: DateTime(DateTime.now().year, DateTime.now().month + 1)
                .subtract(const Duration(days: 1)),
          ),
        );

  final BuildContext context;

  @override
  int get cantidadDePeriodosVisibles => 3;

  @override
  List<Periodo> get periodosAnterior {
    final cantPeriodosAnterioresVisibles = cantidadDePeriodosVisibles.isEven
        ? cantidadDePeriodosVisibles / 2
        : (cantidadDePeriodosVisibles - 1) / 2;

    return List<Periodo>.generate(cantPeriodosAnterioresVisibles.toInt(),
        (index) {
      final anteriorFechaDesde = periodoActual.fechaDesde.copyWith(
        month: periodoActual.fechaDesde.month - 1 * (index + 1),
      );

      return Periodo(
        etiqueta: anteriorFechaDesde.nombreMes(context).toUpperCase(),
        fechaDesde: anteriorFechaDesde,
        fechaHasta: anteriorFechaDesde.copyWith(
          month: anteriorFechaDesde.month + 1,
        ),
      );
    });
  }

  @override
  List<Periodo> get periodosPosteriores {
    final cantPeriodosPosterioresVisibles = cantidadDePeriodosVisibles.isEven
        ? cantidadDePeriodosVisibles / 2
        : (cantidadDePeriodosVisibles - 1) / 2;

    return List<Periodo>.generate(cantPeriodosPosterioresVisibles.toInt(),
        (index) {
      final posteriorFechaDesde = periodoActual.fechaDesde.copyWith(
        month: periodoActual.fechaDesde.month + 1 * (index + 1),
      );

      return Periodo(
        etiqueta: posteriorFechaDesde.nombreMes(context).toUpperCase(),
        fechaDesde: posteriorFechaDesde,
        fechaHasta: posteriorFechaDesde.copyWith(
          month: posteriorFechaDesde.month + 1,
        ),
      );
    });
  }
}
