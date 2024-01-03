import 'package:escuelas_flutter/extensiones/date_time.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/delegates/periodo_delegate.dart';
import 'package:flutter/material.dart';

/// {@template PeriodoCuatrimestralDelegate}
///  Representa un periodo de tiempo de forma cuatrimestral
/// {@endtemplate}
class PeriodoCuatrimestralDelegate extends PeriodoDelegate {
  /// {@macro PeriodoCuatrimestralDelegate}
  PeriodoCuatrimestralDelegate(
    this.context, {
    this.onRetroceder,
    this.onAvanzar,
  }) : super(
          Periodo(
            etiqueta: DateTime.now().devolverEtiqueta(),
            fechaDesde: DateTime.now().copyWith(day: 1),
            fechaHasta: DateTime(DateTime.now().year, DateTime.now().month + 3)
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
      month: periodoActual.fechaDesde.month - 3,
    );

    return Periodo(
      etiqueta: anteriorFechaDesde.devolverEtiqueta(),
      fechaDesde: anteriorFechaDesde,
      fechaHasta: anteriorFechaDesde.copyWith(
        month: anteriorFechaDesde.month + 3,
      ),
    );
  }

  @override
  Periodo get periodoPosterior {
    final posteriorFechaDesde = periodoActual.fechaDesde.copyWith(
      month: periodoActual.fechaDesde.month + 3,
    );

    return Periodo(
      etiqueta: posteriorFechaDesde.devolverEtiqueta(),
      fechaDesde: posteriorFechaDesde,
      fechaHasta: posteriorFechaDesde.copyWith(
        month: posteriorFechaDesde.month + 3,
      ),
    );
  }
}
