import 'dart:math';

import 'package:escuelas_flutter/features/asistencias/bloc_asistencias/bloc_asistencias.dart';
import 'package:escuelas_flutter/features/asistencias/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/delegates/periodo_diario_delegate.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/selector_de_periodo_diario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularAsistencias}
/// Vista para celular de la pagina 'Asistencias'
/// {@endtemplate}
class VistaCelularInasistencias extends StatelessWidget {
  /// {@macro VistaCelularAsistencias}
  const VistaCelularInasistencias({super.key});

  @override
  Widget build(BuildContext context) {
    
    final l10n = context.l10n;

    return BlocBuilder<BlocAsistencias, BlocAsistenciasEstado>(
      builder: (context, state) {
        if (state is BlocAsistenciasEstadoCargando) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.cursos.isEmpty) {
          //TODO(anyone): hacer una vista cuando no hay cursos.
          return Center(
            child: Text(l10n.pageAttendanceNotAbsentStudents),
          );
        }
        return Column(
          children: [
            SelectorDePeriodoDiario(
              delegate: PeriodoDiarioDelegate(
                context,
              ),
            ),
            const Expanded(child: ListaDeCursos()),
            if (state.cursoDesplegado)
              BotonFinalizarAsistencias(
                //TODO(anyone): fecha hardcodeada reemplazar por la del
                // calendario
                fecha: DateTime.now(),
                curso: state.cursos[state.index],
              ),
            SizedBox(height: max(10.ph, 10.sh)),
          ],
        );
      },
    );
  }
}
