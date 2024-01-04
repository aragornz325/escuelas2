import 'package:escuelas_flutter/extensiones/date_time.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/delegates/periodo_delegate.dart';
import 'package:flutter/material.dart';

/// {@template PeriodoDiarioDelegate}
///  Representa un periodo de tiempo de forma Diario
/// {@endtemplate}
class PeriodoDiarioDelegate extends PeriodoDelegate {
  /// {@macro PeriodoDiarioDelegate}
  PeriodoDiarioDelegate(
    this.context, {
    this.onRetroceder,
    this.onAvanzar,
  }) : super(
          Periodo(
            etiqueta: DateTime.now().numeroDia(context),
            etiqueta2: DateTime.now().nombreDia(context),
            fechaDesde: DateTime.now(),
            fechaHasta: DateTime.now(),
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
      day: periodoActual.fechaDesde.day - 1,
    );

    return Periodo(
      etiqueta: anteriorFechaDesde.numeroDia(context),
      etiqueta2: anteriorFechaDesde.nombreDia(context),
      fechaDesde: anteriorFechaDesde,
      fechaHasta: anteriorFechaDesde.copyWith(
        day: anteriorFechaDesde.day + 1,
      ),
    );
  }

  @override
  Periodo get periodoPosterior {
    final posteriorFechaDesde = periodoActual.fechaDesde.copyWith(
      day: periodoActual.fechaDesde.day + 1,
    );

    return Periodo(
      etiqueta: posteriorFechaDesde.numeroDia(context),
      etiqueta2: posteriorFechaDesde.nombreDia(context),
      fechaDesde: posteriorFechaDesde,
      fechaHasta: posteriorFechaDesde.copyWith(
        day: posteriorFechaDesde.day + 1,
      ),
    );
  }
}
