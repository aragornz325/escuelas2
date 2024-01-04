import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
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
    super.key,
  }) : _delegate = delegate;

  /// El delegado del selector de periodo
  final PeriodoDelegate _delegate;

  @override
  State<SelectorDePeriodo> createState() => _SelectorDePeriodoState();
}

class _SelectorDePeriodoState extends State<SelectorDePeriodo> {
  late Periodo periodo = widget._delegate.periodoActual;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Container(
      height: 60.ph,
      margin: EdgeInsets.symmetric(horizontal: 20.pw),
      decoration: BoxDecoration(
        color: colores.tertiary,
        borderRadius: BorderRadius.circular(40.sw),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 75.pw,
              padding: EdgeInsets.only(left: 15.pw),
              child: GestureDetector(
                onTap: () => setState(() {
                  periodo = widget._delegate.retrocederPeriodo();
                }),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_left,
                      size: 25.pw,
                      color: colores.grisSC,
                    ),
                    Text(
                      widget._delegate.periodoAnterior.etiqueta.substring(0, 3),
                      style: TextStyle(
                        color: colores.grisSC,
                        fontSize: 14.pf,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget._delegate.periodoActual.etiqueta,
                  style: TextStyle(
                    color: colores.onBackground,
                    fontSize: 18.pf,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '${widget._delegate.periodoActual.fechaDesde.year}',
                  style: TextStyle(
                    color: colores.grisSC,
                    fontSize: 12.pf,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Container(
              width: 75.pw,
              padding: EdgeInsets.only(right: 15.pw),
              child: GestureDetector(
                onTap: () => setState(() {
                  periodo = widget._delegate.avanzarPeriodo();
                }),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget._delegate.periodoPosterior.etiqueta
                          .substring(0, 3),
                      style: TextStyle(
                        color: colores.grisSC,
                        fontSize: 14.pf,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.arrow_right,
                      size: 25.pw,
                      color: colores.grisSC,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
