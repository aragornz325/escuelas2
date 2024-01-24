import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialogNotasEnviadasCorrectamente}
/// Dialog/Popup de éxito al enviar Calificaciones.
///
/// Muestra un mensaje de éxito al enviar las calificaciones.
/// {@endtemplate}
class DialogNotasEnviadasCorrectamente extends StatelessWidget {
  /// {@macro DialogNotasEnviadasCorrectamente}
  const DialogNotasEnviadasCorrectamente({super.key});

  // TODO(anyone): charlar con todos para ponerse de acuerdo en usar los .show()
  Future<void> show(BuildContext context) => showDialog(
        context: context,
        builder: (_) => this,
      );

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    final l10n = context.l10n;

    return EscuelasDialog.exitoso(
      altura: 80.ph,
      context: context,
      onTap: () => Navigator.pop(context),
      content: Text(
        l10n.dialogSuccessToSendGrades,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: colores.onBackground,
          fontSize: 14.pf,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
