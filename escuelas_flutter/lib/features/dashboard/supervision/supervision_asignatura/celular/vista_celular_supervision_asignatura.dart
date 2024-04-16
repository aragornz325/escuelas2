import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/bloc_dashboard/bloc_dashboard.dart';
import 'package:escuelas_flutter/features/dashboard/supervision/supervision_asignatura/bloc/bloc_supervision_asignatura.dart';
import 'package:escuelas_flutter/features/dashboard/supervision/supervision_asignatura/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/utilidades/funciones/escuelas_toast.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/delegates/periodo_delegate.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/delegates/periodo_mensual_delegate.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/selector_de_periodo.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularSupervisionAsignatura}
/// Vista para `celular` de la pagina 'Supervision de asignatura'
/// {@endtemplate}
class VistaCelularSupervisionAsignatura extends StatelessWidget {
  /// {@macro VistaCelularSupervisionAsignatura}
  const VistaCelularSupervisionAsignatura({
    super.key,
  });
  void _dialogEnvioEmailCorrectamente(
    BuildContext context,
    String nombreEstudiante,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) => DialogExitoAlEnviarEmail(
        nombreEstudiante: nombreEstudiante,
      ),
    );
  }

  /// Dialog para confirmar el envio de correos a la asignatura.
  void _dialogConfirmarEnvioEmails(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocSupervisionAsignatura>(),
        child: const DialogEnviarEmailAsignatura(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return BlocConsumer<BlocSupervisionAsignatura,
        BlocSupervisionAsignaturaEstado>(
      listener: (context, state) {
        if (state is BlocSupervisionAsignaturaEstadoEnviandoEmail) {
          showEcuelasToast(
            mensaje: l10n.pageComissionSupervisionMessageSendingEmail,
            context: context,
          );
        }
        if (state is BlocSupervisionAsignaturaEstadoExitosoAlEnviarEmail) {
          _dialogEnvioEmailCorrectamente(context, state.nombreEstudiante);
        }
      },
      builder: (context, state) {
        final idAutor = context.read<BlocDashboard>().state.usuario.id ?? 0;

        final etiqueta = state.fecha != null
            ? state.fecha!.nombreMes(context).toUpperCase()
            : '';

        final fechaDesde =
            state.fecha?.copyWith(day: 1) ?? DateTime.now().copyWith(day: 1);

        final fechaHasta = DateTime(
          DateTime.now().year,
          DateTime.now().month + 1,
        ).subtract(const Duration(days: 1));

        return Column(
          children: [
            SelectorDePeriodo(
              delegate: PeriodoMensualDelegate(
                context,
                periodo: PeriodoDelSelector(
                  etiqueta: etiqueta,
                  fechaDesde: fechaDesde,
                  fechaHasta: fechaHasta,
                ),
              ),
              onSeleccionarPeriodo: (periodo) =>
                  context.read<BlocSupervisionAsignatura>().add(
                        BlocSupervisionAsignaturaEventoInicializar(
                          fecha: periodo.fechaDesde,
                          idAsignatura: state.asignatura?.id ?? 0,
                          idComision: state.comision?.id ?? 0,
                          idAutor: idAutor,
                        ),
                      ),
              decoration: BoxDecoration(
                color: colores.tertiary,
                borderRadius: BorderRadius.circular(40.sw),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20.pw),
            ),
            NombreAsignaturaYComision(
              nombreAsignatura: state.asignatura?.nombre ?? '',
              nombreComision: state.comision?.nombre ?? '',
            ),
            ListaTarjetaCargaCalificacion(
              listaCalificacionesMesActual: state.listaCalificacionesMesActual,
              listaCalificacionesMesesRestantes:
                  state.listaCalificacionesMesesRestantes,
              listaEstudiantes: state.estudiantes,
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.ph),
              child: EscuelasBoton.texto(
                width: 340.pw,
                height: max(40.ph, 40.sh),
                estaHabilitado: true,
                onTap: () => _dialogConfirmarEnvioEmails(context),
                color: colores.azul,
                texto: '${l10n.pageComissionSupervisionSendEmail}'
                    ' ${state.asignatura?.nombre}',
                context: context,
              ),
            ),
          ],
        );
      },
    );
  }
}
