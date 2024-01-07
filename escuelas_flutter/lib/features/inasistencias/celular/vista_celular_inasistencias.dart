import 'dart:math';
import 'package:escuelas_flutter/features/inasistencias/bloc_inasistencias/bloc_inasistencias.dart';
import 'package:escuelas_flutter/features/inasistencias/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/delegates/periodo_diario_delegate.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/selector_de_periodo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularAsistencias}
/// Vista para celular de la pagina 'Asistencias'
/// {@endtemplate}
class VistaCelularInasistencias extends StatefulWidget {
  /// {@macro VistaCelularAsistencias}
  const VistaCelularInasistencias({super.key});

  @override
  State<VistaCelularInasistencias> createState() =>
      _VistaCelularInasistenciasState();
}

class _VistaCelularInasistenciasState extends State<VistaCelularInasistencias> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<BlocInasistencias, BlocInasistenciasEstado>(
      builder: (context, state) {
        if (state is BlocInasistenciasEstadoCargando) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.cursos.isEmpty) {
          // TODO(anyone): hacer una vista cuando no hay cursos.
          return Center(
            child: Text(l10n.pageAttendanceNotAbsentStudents),
          );
        }

        return Column(
          children: [
            // TODO(anyone): no se actualiza la fecha
            // Center(
            //   child: Text(
            //     '${periodo.fechaDesde.nombreMes(context).toUpperCase()} -
            //      ${periodo.fechaDesde.year}',
            //     style: TextStyle(
            //       color: colores.onBackground,
            //       fontSize: 12.pf,
            //       fontWeight: FontWeight.w700,
            //     ),
            //   ),
            // ),
            SelectorDePeriodo(
              delegate: PeriodoDiarioDelegate(
                context,
              ),
              onSeleccionarPeriodo: (periodo) {},
            ),
            const Divider(thickness: .5),
            Expanded(
              child: ListaDeCursos(
                fecha: DateTime.now(),
              ),
            ),
            SizedBox(height: max(10.ph, 10.sh)),
          ],
        );
      },
    );
  }
}
