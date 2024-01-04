import 'package:escuelas_flutter/extensiones/date_time.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/delegates/periodo_delegate.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template SelectorDePeriodo}
/// Representa un selector de periodo de tiempo
/// {@endtemplate}
class SelectorDePeriodoDiario extends StatefulWidget {
  /// {@macro SelectorDePeriodo}
  const SelectorDePeriodoDiario({
    required PeriodoDelegate delegate,
    super.key,
  }) : _delegate = delegate;

  /// El delegado del selector de periodo
  final PeriodoDelegate _delegate;

  @override
  State<SelectorDePeriodoDiario> createState() =>
      _SelectorDePeriodoDiarioState();
}

class _SelectorDePeriodoDiarioState extends State<SelectorDePeriodoDiario> {
  late Periodo periodo = widget._delegate.periodoActual;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Container(
      height: 90.ph,
      margin: EdgeInsets.symmetric(horizontal: 20.pw),
      child: Center(
        child: Column(
          children: [
            Center(
              child: Text(
                '${periodo.fechaDesde.nombreMes(context).toUpperCase()} - ${periodo.fechaDesde.year}',
                style: TextStyle(
                  color: colores.onSecondary,
                  fontSize: 12.pf,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 10.ph),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => setState(() {
                    periodo = widget._delegate.retrocederPeriodo();
                  }),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget._delegate.periodoAnterior.etiqueta2
                                ?.substring(0, 1) ??
                            '',
                        style: TextStyle(
                          color: colores.onBackground,
                          fontSize: 12.pf,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        widget._delegate.periodoAnterior.etiqueta,
                        style: TextStyle(
                          color: colores.onSecondary,
                          fontSize: 12.pf,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget._delegate.periodoActual.etiqueta2
                              ?.substring(0, 1) ??
                          '',
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
                        widget._delegate.periodoActual.etiqueta,
                        style: TextStyle(
                          color: colores.grisClaroSombreado,
                          fontSize: 12.pf,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    periodo = widget._delegate.avanzarPeriodo();
                  }),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget._delegate.periodoPosterior.etiqueta2
                                ?.substring(0, 1) ??
                            '',
                        style: TextStyle(
                          color: colores.onBackground,
                          fontSize: 12.pf,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        widget._delegate.periodoPosterior.etiqueta,
                        style: TextStyle(
                          color: colores.onSecondary,
                          fontSize: 12.pf,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
