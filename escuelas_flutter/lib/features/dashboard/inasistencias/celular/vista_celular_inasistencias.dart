import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/inasistencias/bloc_inasistencias/bloc_inasistencias.dart';
import 'package:escuelas_flutter/features/dashboard/inasistencias/widgets/lista_de_cursos.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/delegates/periodo_diario_delegate.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/selector_de_periodo.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
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
  Future<void> _inasistenciasEnviadasCorrectamente(
    BuildContext context,
  ) {
    final l10n = context.l10n;

    return showDialog<void>(
      context: context,
      builder: (context) => EscuelasDialog.exitoso(
        altura: max(80.ph, 80.sh),
        context: context,
        onTap: () => Navigator.of(context).pop(),
        content: Text(
          l10n.dialogAbsencesSentCorrectly,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final colores = context.colores;

    return Column(
      children: [
        BlocConsumer<BlocInasistencias, BlocInasistenciasEstado>(
          listener: (context, state) {
            if (state is BlocInasistenciasEstadoExitosoEnvioDeInasistencias) {
              _inasistenciasEnviadasCorrectamente(context);
            }
          },
          builder: (context, state) {
            return Center(
              child: Text(
                state.fechaActual?.nombreMes(context) ?? '',
                style: TextStyle(
                  color: colores.onBackground,
                  fontSize: 12.pf,
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          },
        ),
        SelectorDePeriodo(
          delegate: PeriodoDiarioDelegate(
            context,
          ),
          onSeleccionarPeriodo: (periodo) =>
              context.read<BlocInasistencias>().add(
                    BlocInasistenciasEventoInicializar(
                      fecha: periodo.fechaDesde,
                    ),
                  ),
        ),
        const Divider(thickness: .5),
        BlocBuilder<BlocInasistencias, BlocInasistenciasEstado>(
          builder: (context, state) {
            if (state is BlocInasistenciasEstadoCargando) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.comisionesConAsistencias.isEmpty) {
              return Center(
                child: Text(l10n.pageAttendanceWithoutCourses),
              );
            }

            return const Expanded(child: ListaDeComisionesDeCurso());
          },
        ),
        SizedBox(height: max(10.ph, 10.sh)),
      ],
    );
  }
}
