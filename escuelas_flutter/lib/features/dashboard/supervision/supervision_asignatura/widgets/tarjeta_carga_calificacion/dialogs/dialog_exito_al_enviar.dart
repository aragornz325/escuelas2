import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialogExitoAlEnviarEmail}
/// Dialogo de exito al enviar email a un estudiante.
/// {@endtemplate}
class DialogExitoAlEnviarEmail extends StatelessWidget {
  /// {@macro DialogExitoAlEnviarEmail}
  const DialogExitoAlEnviarEmail({
    required this.nombreEstudiante,
    super.key,
  });

  /// nombre del estudiante al que se le envio el email
  final String nombreEstudiante;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    final l10n = context.l10n;

    return EscuelasDialog.exitoso(
      context: context,
      onTap: () => Navigator.of(context).pop(),
      content: DefaultTextStyle(
        style: TextStyle(
          color: colores.onSecondary,
          fontSize: 18.pf,
          fontWeight: FontWeight.w500,
        ),
        child: Column(
          children: [
            Text(
              l10n.pageComissionSupervisionDialogSuccessSendEmailStudent,
              textAlign: TextAlign.center,
            ),
            Text(
              nombreEstudiante.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(color: colores.onBackground),
            ),
          ],
        ),
      ),
    );
  }
}
