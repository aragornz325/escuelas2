import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';

/// {@template DialogEliminadoExitosamente}
/// Dialog a mostrarse para notificar que la plantilla fue eliminada con exito
/// {@endtemplate}
class DialogEliminadoExitosamente extends StatelessWidget {
  /// {@macro DialogEliminadoExitosamente}
  const DialogEliminadoExitosamente({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return EscuelasDialog.exitoso(
      context: context,
      onTap: () => Navigator.of(context).pop(),
      content: Text(l10n.pageManageTemplatesDialogDeletedSuccessfully),
    );
  }
}
