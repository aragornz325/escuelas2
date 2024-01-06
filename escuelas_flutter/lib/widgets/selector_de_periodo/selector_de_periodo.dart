import 'package:escuelas_flutter/widgets/selector_de_periodo/delegates/periodo_delegate.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template SelectorDePeriodo}
/// Representa un selector de periodo de tiempo
/// {@endtemplate}
class SelectorDePeriodo extends StatefulWidget {
  /// {@macro SelectorDePeriodo}
  const SelectorDePeriodo({
    required PeriodoDelegate delegate,
    required this.onSeleccionarPeriodo,
    this.decoration,
    this.margin,
    super.key,
  }) : _delegate = delegate;

  /// El delegado del selector de periodo
  final PeriodoDelegate _delegate;

  /// Ejecuta una acción al retroceder el periodo.
  final void Function(PeriodoDelSelector periodo) onSeleccionarPeriodo;

  /// La decoracion del selector de periodo
  final BoxDecoration? decoration;

  /// El margen del selector de periodo
  final EdgeInsets? margin;

  @override
  State<SelectorDePeriodo> createState() => _SelectorDePeriodoState();
}

class _SelectorDePeriodoState extends State<SelectorDePeriodo> {
  @override
  void didUpdateWidget(SelectorDePeriodo oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Cuando se actualice el widget por un setState o lo que
    // fuera por fuera del componente, se reescribe el periodo actual.
    widget._delegate.periodoActual = oldWidget._delegate.periodoActual;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      padding: EdgeInsets.symmetric(
        vertical: 5.ph,
      ),
      decoration: widget.decoration,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: widget._delegate.periodosAnterior.length == 1
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.spaceEvenly,
                children: [
                  ...widget._delegate.periodosAnterior.map(
                    (periodo) => widget._delegate.buildPeriodosAnteriores(
                      onSeleccionarPeriodo: () {
                        setState(
                          () => widget._delegate.periodoActual = periodo,
                        );
                        widget.onSeleccionarPeriodo(periodo);
                      },
                      periodo: periodo,
                    ),
                  ),
                ],
              ),
            ),
            widget._delegate.buildPeriodoActual(
              periodo: widget._delegate.periodoActual,
            ),
            Flexible(
              child: Row(
                mainAxisAlignment:
                    widget._delegate.periodosPosteriores.length == 1
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.spaceEvenly,
                children: [
                  ...widget._delegate.periodosPosteriores.map(
                    (periodo) => widget._delegate.buildPeriodosPosteriores(
                      onSeleccionarPeriodo: () {
                        setState(
                          () => widget._delegate.periodoActual = periodo,
                        );
                        widget.onSeleccionarPeriodo(periodo);
                      },
                      periodo: periodo,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
