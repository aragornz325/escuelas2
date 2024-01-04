import 'package:escuelas_flutter/extensiones/extensiones.dart';
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
    super.key,
  }) : _delegate = delegate;

  /// El delegado del selector de periodo
  final PeriodoDelegate _delegate;

  /// Ejecuta una acción al retroceder el periodo.
  final void Function(Periodo periodo) onSeleccionarPeriodo;

  @override
  State<SelectorDePeriodo> createState() => _SelectorDePeriodoState();
}

class _SelectorDePeriodoState extends State<SelectorDePeriodo> {
  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.pw),
      decoration: BoxDecoration(
        color: colores.tertiary,
        borderRadius: BorderRadius.circular(40.sw),
      ),
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
                      onSeleccionarPeriodo: () => setState(
                        () => widget._delegate.periodoActual = periodo,
                      ),
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
                      onSeleccionarPeriodo: () => setState(
                        () => widget._delegate.periodoActual = periodo,
                      ),
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
