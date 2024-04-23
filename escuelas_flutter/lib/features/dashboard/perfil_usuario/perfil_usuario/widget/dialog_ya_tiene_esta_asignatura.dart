import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';

/// {@template DialogYaTieneEstaAsignatura}
/// Dialog para notificar que el usuario ya tiene esta asignatura
/// {@endtemplate}
class DialogYaTieneEstaAsignatura extends StatelessWidget {
  /// {@macro DialogYaTieneEstaAsignatura}
  const DialogYaTieneEstaAsignatura({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return EscuelasDialog.exitoso(
      context: context,
      onTap: () => Navigator.of(context).pop(),
      content: Text(l10n.pageEditProfileDialogAlreadyHasThisSubject),
    );
  }
}
