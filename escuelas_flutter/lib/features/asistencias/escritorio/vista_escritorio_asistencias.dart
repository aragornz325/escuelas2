import 'dart:math';

import 'package:escuelas_flutter/features/asistencias/bloc_asistencias/bloc_asistencias.dart';
import 'package:escuelas_flutter/features/asistencias/widgets/boton_finalizar_asistencias.dart';
import 'package:escuelas_flutter/features/asistencias/widgets/lista_de_cursos.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaEscritorioInasistencias}
/// Vista para escritorio de la pagina 'Inasistencias'
/// {@endtemplate}
class VistaEscritorioInasistencias extends StatelessWidget {
  /// {@macro VistaEscritorioInasistencias}
  const VistaEscritorioInasistencias({super.key});

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
