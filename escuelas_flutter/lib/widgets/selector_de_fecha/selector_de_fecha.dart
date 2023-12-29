import 'package:escuelas_flutter/extensiones/date_time.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/selector_de_fecha/bloc/bloc_selector_de_fecha.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template SelectorDeFecha}
/// Selector de fecha para poder seleccionar el mes y el año de los datos
/// {@endtemplate}
class SelectorDeFecha extends StatelessWidget {
  /// {@macro SelectorDeFecha}
  const SelectorDeFecha({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Container(
      height: 60.ph,
      decoration: BoxDecoration(
        color: colores.tertiary,
        borderRadius: BorderRadius.circular(20.sw),
      ),
      child: Center(
        child: BlocBuilder<BlocSelectorDeFecha, BlocSelectorDeFechaEstado>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150.pw,
                  padding: EdgeInsets.only(left: 15.pw),
                  child: GestureDetector(
                    onTap: () => context
                        .read<BlocSelectorDeFecha>()
                        .add(BlocSelectorDeFechaEventoRetroceder()),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_left,
                          size: 25.pw,
                          color: colores.grisSC,
                        ),
                        Text(
                          // state.fechaEnElMesAnterior
                          //     .nombreMes(context)
                          //     .toUpperCase(),
                          'asdasd',
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
                      // state.fecha.nombreMes(context).toUpperCase(),
                      'asdasd',
                      style: TextStyle(
                        color: colores.onBackground,
                        fontSize: 18.pf,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${state.fecha.year}',
                      style: TextStyle(
                        color: colores.grisSC,
                        fontSize: 12.pf,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 150.pw,
                  padding: EdgeInsets.only(right: 15.pw),
                  child: GestureDetector(
                    onTap: () => context
                        .read<BlocSelectorDeFecha>()
                        .add(BlocSelectorDeFechaEventoAvanzar()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'asdasd',
                          // state.fechaEnElMesPosterior
                          //     .nombreMes(context)
                          //     .toUpperCase(),
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
            );
          },
        ),
      ),
    );
  }
}
