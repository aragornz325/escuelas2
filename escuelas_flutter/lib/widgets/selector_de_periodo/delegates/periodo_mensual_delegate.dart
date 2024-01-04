import 'package:escuelas_flutter/extensiones/date_time.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/delegates/periodo_delegate.dart';
import 'package:flutter/material.dart';

/// {@template PeriodoMensualDelegate}
/// Representa un periodo de tiempo de forma mensual
/// {@endtemplate}
class PeriodoMensualDelegate extends PeriodoDelegate {
  /// {@macro PeriodoMensualDelegate}
  PeriodoMensualDelegate(
    this.context, {
    this.onRetroceder,
    this.onAvanzar,
  }) : super(
          Periodo(
            etiqueta: DateTime.now().nombreMes(context).toUpperCase(),
            fechaDesde: DateTime.now().copyWith(day: 1),
            fechaHasta: DateTime(DateTime.now().year, DateTime.now().month + 1)
                .subtract(const Duration(days: 1)),
          ),
        );

  final BuildContext context;

  @override
  void Function(Periodo periodo)? onRetroceder;

  @override
  void Function(Periodo periodo)? onAvanzar;

  @override
  Periodo get periodoAnterior {
    final anteriorFechaDesde = periodoActual.fechaDesde.copyWith(
      month: periodoActual.fechaDesde.month - 1,
    );

    return Periodo(
      etiqueta: anteriorFechaDesde.nombreMes(context).toUpperCase(),
      fechaDesde: anteriorFechaDesde,
      fechaHasta: anteriorFechaDesde.copyWith(
        month: anteriorFechaDesde.month + 1,
      ),
    );
  }

  @override
  Periodo get periodoPosterior {
    final posteriorFechaDesde = periodoActual.fechaDesde.copyWith(
      month: periodoActual.fechaDesde.month + 1,
    );

    return Periodo(
      etiqueta: posteriorFechaDesde.nombreMes(context).toUpperCase(),
      fechaDesde: posteriorFechaDesde,
      fechaHasta: posteriorFechaDesde.copyWith(
        month: posteriorFechaDesde.month + 1,
      ),
    );
  }
}
