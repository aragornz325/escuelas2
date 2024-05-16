import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/supervision/supervision_comisiones/bloc/bloc_supervision_comisiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/utilidades/utilidades.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template BotonEnviarEmails}
/// Boton para mandar email a las comisiones.
/// {@endtemplate}
class BotonEnviarEmails extends StatelessWidget {
  /// {@macro BotonEnviarEmails}
  const BotonEnviarEmails({super.key});

  /// Dialog de enviar email a las comisiones de la escuela
  void _dialogEnviarEmail(
      BuildContext context, BlocSupervisionComisiones bloc) {
    final colores = context.colores;
    final l10n = context.l10n;

    showDialog<void>(
      context: context,
      builder: (context) => EscuelasDialog.confirmar(
        onTapConfirmar: () =>
            bloc.add(const BlocSupervisionComisionesEventoEnviarEmails()),
        content: Text(
          l10n.pageComissionSupervisionDialogConfimationSendEmails,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colores.onSecondary,
            fontSize: 16.pf,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// Dialog para avisarle o adverirle que no estan todas las calificaciones
  /// cargadas
  void _dialogNoEstanTodasCargadas(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    showDialog<void>(
      context: context,
      builder: (context) => EscuelasDialog.fallido(
        onTap: () => Navigator.of(context).pop(),
        content: Column(
          children: [
            Tooltip(
              margin: EdgeInsets.symmetric(horizontal: 40.pw),
              decoration: BoxDecoration(
                color: colores.onBackground,
                borderRadius: BorderRadius.circular(10.sw),
              ),
              textAlign: TextAlign.center,
              textStyle: TextStyle(
                color: colores.background,
                fontSize: 15.pf,
                fontWeight: FontWeight.w600,
              ),
              message: l10n.pageComissionSupervisionDialogMessageTooltip,
              child: Icon(
                Icons.error,
                size: 50.pw,
                color: colores.error,
              ),
            ),
            SizedBox(height: max(20.ph, 20.sh)),
            Text(
              l10n.pageComissionSupervisionDialogNotGradesUploaded,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colores.onSecondary,
                fontSize: 16.pf,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return BlocConsumer<BlocSupervisionComisiones,
        BlocSupervisionComisionesEstado>(
      listener: (context, state) {
        if (state is BlocSupervisionComisionEstadoCargandoAlMandarEmails) {
          showEcuelasToast(
            mensaje: l10n.pageComissionSupervisionSendingEmails,
            context: context,
          );
        }
        if (state is BlocSupervisionComisionEstadoExitosoAlMandarEmails) {
          showEcuelasToast(
            mensaje: l10n.pageComissionSupervisionSendEmailsSuccess,
            context: context,
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 15.ph),
          child: EscuelasBoton.texto(
            width: 340.pw,
            height: max(40.ph, 40.sh),
            estaHabilitado: true,
            onTap: () => _dialogEnviarEmail(
                context, context.read<BlocSupervisionComisiones>()),
            // onTap: state.listaSupervisionComisiones
            //         .every((comision) => comision.fechaDeNotificacion != null)
            //     ? () => _dialogEnviarEmail(context)
            //     : () => _dialogNoEstanTodasCargadas(context),
            color: colores.azul,
            texto: l10n.pageComissionSupervisionButtonSendEmails,
            context: context,
          ),
        );
      },
    );
  }
}
