import 'package:escuelas_flutter/extensiones/date_time.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/delegates/periodo_delegate.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template PeriodoDiarioDelegate}
///  Representa un periodo de tiempo de forma Diario
/// {@endtemplate}
class PeriodoDiarioDelegate extends PeriodoDelegate {
  /// {@macro PeriodoDiarioDelegate}
  PeriodoDiarioDelegate(this.context)
      : super(
          Periodo(
            etiqueta: DateTime.now().numeroDia(context),
            fechaDesde: DateTime.now(),
            fechaHasta: DateTime.now(),
          ),
        );

  final BuildContext context;

  @override
  int get cantidadDePeriodosVisibles => 7;

  @override
  List<Periodo> get periodosAnterior {
    final cantPeriodosAnterioresVisibles = cantidadDePeriodosVisibles.isEven
        ? cantidadDePeriodosVisibles / 2
        : (cantidadDePeriodosVisibles - 1) / 2;

    return List<Periodo>.generate(cantPeriodosAnterioresVisibles.toInt(),
        (index) {
      final anteriorFechaDesde = periodoActual.fechaDesde.copyWith(
        day: periodoActual.fechaDesde.day - 1 * (index + 1),
      );

      return Periodo(
        etiqueta: anteriorFechaDesde.numeroDia(context),
        fechaDesde: anteriorFechaDesde,
        fechaHasta: anteriorFechaDesde.copyWith(
          day: anteriorFechaDesde.day + 1,
        ),
      );
    })
      ..sort(
        (a, b) => a.fechaDesde.compareTo(b.fechaDesde),
      );
  }

  @override
  List<Periodo> get periodosPosteriores {
    final cantPeriodosPosterioresVisibles = cantidadDePeriodosVisibles.isEven
        ? cantidadDePeriodosVisibles / 2
        : (cantidadDePeriodosVisibles - 1) / 2;

    return List<Periodo>.generate(cantPeriodosPosterioresVisibles.toInt(),
        (index) {
      final posteriorFechaDesde = periodoActual.fechaDesde.copyWith(
        day: periodoActual.fechaDesde.day + 1 * (index + 1),
      );

      return Periodo(
        etiqueta: posteriorFechaDesde.numeroDia(context),
        fechaDesde: posteriorFechaDesde,
        fechaHasta: posteriorFechaDesde.copyWith(
          day: posteriorFechaDesde.day + 1,
        ),
      );
    });
  }

  @override
  Widget buildPeriodoActual({
    required Periodo periodo,
  }) =>
      PeriodoSeleccionado(periodo: periodoActual);

  @override
  Widget buildPeriodosAnteriores({
    required void Function() onSeleccionarPeriodo,
    required Periodo periodo,
  }) =>
      PeriodoNoSeleccionado(
        periodo: periodo,
        onSeleccionarPeriodo: onSeleccionarPeriodo,
      );

  @override
  Widget buildPeriodosPosteriores({
    required void Function() onSeleccionarPeriodo,
    required Periodo periodo,
  }) =>
      PeriodoNoSeleccionado(
        periodo: periodo,
        onSeleccionarPeriodo: onSeleccionarPeriodo,
      );
}

/// {@template PeriodoDiarioDelegate}
/// Representa un periodo de tiempo diario no seleccionado
/// {@endtemplate}
class PeriodoNoSeleccionado extends StatelessWidget {
  /// {@macro PeriodoDiarioDelegate}
  const PeriodoNoSeleccionado({
    required this.onSeleccionarPeriodo,
    required this.periodo,
    super.key,
  });

  /// Ejecuta una acción al retroceder el periodo.
  final void Function() onSeleccionarPeriodo;

  /// Periodo a mostrar
  final Periodo periodo;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.sh),
      child: GestureDetector(
        onTap: onSeleccionarPeriodo,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              periodo.fechaDesde.nombreDia(context).substring(0, 1),
              style: TextStyle(
                color: colores.onBackground,
                fontSize: 12.pf,
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.sw),
              child: Text(
                periodo.fechaDesde.numeroDia(context),
                style: TextStyle(
                  color: colores.onSecondary,
                  fontSize: 12.pf,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// {@template PeriodoDiarioDelegate}
/// Representa un periodo de tiempo de forma Diario seleccionado
/// {@endtemplate}
class PeriodoSeleccionado extends StatelessWidget {
  /// {@macro PeriodoDiarioDelegate}
  const PeriodoSeleccionado({required this.periodo, super.key});

  /// Periodo a mostrar
  final Periodo periodo;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.sh),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            periodo.fechaDesde.nombreDia(context).substring(0, 1),
            style: TextStyle(
              color: colores.onBackground,
              fontSize: 12.pf,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colores.primaryContainer,
            ),
            padding: EdgeInsets.all(8.sw),
            child: Text(
              periodo.fechaDesde.numeroDia(context),
              style: TextStyle(
                color: colores.grisClaroSombreado,
                fontSize: 12.pf,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
