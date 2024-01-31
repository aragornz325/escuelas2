import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialogErrorAlEnviarNotas}
/// Dialog/Popup de error al enviar Calificaciones.
///
/// Muestra un mensaje de error al enviar las calificaciones.
/// {@endtemplate}
class DialogErrorAlEnviarCalificaciones extends StatelessWidget {
  /// {@macro DialogErrorAlEnviarNotas}
  const DialogErrorAlEnviarCalificaciones({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return EscuelasDialog.fallido(
      onTap: () => Navigator.pop(context),
      content: Text(
        l10n.dialogErrorToSendGrades,
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
