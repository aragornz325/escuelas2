import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/supervision_comisiones/bloc/bloc_supervision_comisiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/delegates/periodo_mensual_delegate.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/selector_de_periodo.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularSupervisionComision}
/// Vista para celular de la pagina 'Supervision de Comisiones' donde se
/// supervisa la carga de calificaciones de las materias de los comisiones
/// {@endtemplate}
class VistaCelularSupervisionComision extends StatefulWidget {
  /// {@macro VistaCelularSupervisionComision}
  const VistaCelularSupervisionComision({super.key});

  @override
  State<VistaCelularSupervisionComision> createState() =>
      _VistaCelularSupervisionComisionState();
}

class _VistaCelularSupervisionComisionState
    extends State<VistaCelularSupervisionComision> {
  DateTime fecha = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return BlocBuilder<BlocSupervisionComisiones,
        BlocSupervisionComisionesEstado>(
      builder: (context, state) {
        return Column(
          children: [
            SelectorDePeriodo(
              delegate: PeriodoMensualDelegate(context),
              onSeleccionarPeriodo: (periodo) => fecha = periodo.fechaDesde,
              decoration: BoxDecoration(
                color: colores.tertiary,
                borderRadius: BorderRadius.circular(40.sw),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20.pw),
            ),
            Expanded(
              child: ListView(
                children: state.listaComisiones
                    .map(
                      (supervisionComision) => Padding(
                        padding: EdgeInsets.only(bottom: 15.ph),
                        child: ElementoLista.supervisionComision(
                          context: context,
                          onTap: () => context.router.push(
                            RutaSupervisionEnvioCalificaciones(
                              idCurso: supervisionComision.comision.id ?? 0,
                              fecha: fecha.toString(),
                            ),
                          ),
                          nombreComision: supervisionComision.comision.nombre,
                          colorFondo: state.todasMateriasCargadas
                              ? colores.primaryContainer
                              : colores.onSecondary,
                          widgetLateralDerecho:
                              state.habilitacionCargaDeCalificaciones
                                  ? Container(
                                      width: 80.pw,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30.sw),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          state.todasMateriasCargadas
                                              ? state.fechaUltimaMateriaCargada
                                                  .formatear
                                                  .toString()
                                              : '8 de 12',
                                          // ${state.materiasCargadasComision}
                                          // de
                                          // ${state.totalDeMateriasComision}'
                                          // ,
                                          style: TextStyle(
                                            color: colores.background,
                                            fontSize: 15.pf,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(right: 10.pw),
                                      child: Text(
                                        'SIN HABILITAR. 4/01',
                                        // ${state.materiasCargadasComisio} / ${state.totalDeMateriasComisio}',
                                        style: TextStyle(
                                          fontSize: 15.pf,
                                          fontWeight: FontWeight.w600,
                                          color: colores.onPrimary,
                                        ),
                                      ),
                                    ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.ph),
              child: Center(
                child: Text(
                  'Fecha final de envio: '
                  '${state.fechaUltimaMateriaCargada.formatear}',
                  style: TextStyle(
                    color: colores.grisSC,
                    fontSize: 16.pf,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
