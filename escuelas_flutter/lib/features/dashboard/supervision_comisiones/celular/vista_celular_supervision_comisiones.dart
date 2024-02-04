import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/supervision_comisiones/bloc/bloc_supervision_comisiones.dart';
import 'package:escuelas_flutter/features/dashboard/supervision_comisiones/widgets/lista_comisiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/delegates/periodo_mensual_delegate.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/selector_de_periodo.dart';
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
  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Column(
      children: [
        SelectorDePeriodo(
          delegate: PeriodoMensualDelegate(context),
          onSeleccionarPeriodo: (periodo) {
            context.read<BlocSupervisionComisiones>().add(
                  BlocSupervisionComisionesEventoInicializar(
                    fecha: periodo.fechaDesde,
                  ),
                );
          },
          decoration: BoxDecoration(
            color: colores.tertiary,
            borderRadius: BorderRadius.circular(40.sw),
          ),
          margin: EdgeInsets.symmetric(horizontal: 20.pw, vertical: 10.ph),
        ),
        const ListaComisiones(),
        BlocBuilder<BlocSupervisionComisiones, BlocSupervisionComisionesEstado>(
          builder: (context, state) {
            if (state.todasAsignaturasCargadasDeTodasLasComisiones &&
                state.fechaUltimaAsignaturaCargada != null) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20.ph),
                child: Center(
                  child: Text(
                    'Fecha final de envio: '
                    '${state.fechaUltimaAsignaturaCargada!.formatear}',
                    style: TextStyle(
                      color: colores.grisSC,
                      fontSize: 16.pf,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ],
    );
  }
}
