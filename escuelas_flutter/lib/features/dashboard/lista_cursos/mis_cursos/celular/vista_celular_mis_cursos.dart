import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/bloc_dashboard/bloc_dashboard.dart';
import 'package:escuelas_flutter/features/dashboard/lista_cursos/mis_cursos/bloc/bloc_mis_cursos.dart';
import 'package:escuelas_flutter/features/dashboard/lista_de_comisiones/comisiones/widgets/lista_asignatura_por_comision.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/delegates/periodo_mensual_delegate.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/selector_de_periodo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularMisCursos}
/// Vista para celular de la pagina 'Mis Cursos' donde se muestra una lista de
/// las materias ordenas por curso
/// {@endtemplate}
class VistaCelularMisCursos extends StatefulWidget {
  /// {@macro VistaCelularMisCursos}
  const VistaCelularMisCursos({super.key});

  @override
  State<VistaCelularMisCursos> createState() => _VistaCelularMisCursosState();
}

class _VistaCelularMisCursosState extends State<VistaCelularMisCursos> {
  DateTime periodo = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final usuarioId = context.read<BlocDashboard>().state.usuario.id ?? 0;

    return Column(
      children: [
        SelectorDePeriodo(
          delegate: PeriodoMensualDelegate(context),
          onSeleccionarPeriodo: (periodoSeleccionado) => setState(
            () {
              periodo = periodoSeleccionado.fechaDesde;
              context.read<BlocMisCursos>().add(
                    BlocMisCursosEventoCambiarMes(
                      periodoSeleccionada: periodo,
                      usuarioId: usuarioId,
                    ),
                  );
            },
          ),
          decoration: BoxDecoration(
            color: colores.tertiary,
            borderRadius: BorderRadius.circular(40.sw),
          ),
          margin: EdgeInsets.symmetric(horizontal: 20.pw),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.pw,
                vertical: 20.ph,
              ),
              child: ListaDeAsignaturasPorComision(periodo: periodo),
            ),
          ),
        ),
      ],
    );
  }
}
