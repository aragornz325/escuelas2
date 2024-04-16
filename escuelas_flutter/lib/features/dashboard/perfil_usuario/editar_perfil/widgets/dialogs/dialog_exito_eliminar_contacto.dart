import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialogExitoEliminarContacto}
/// Dialog para notificar exito al eliminar un contacto.
/// {@endtemplate}
class DialogExitoEliminarContacto extends StatelessWidget {
  /// {@macro DialogExitoEliminarContacto}
  const DialogExitoEliminarContacto({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return EscuelasDialog.exitoso(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sw),
      ),
      altura: max(50.ph, 50.sh),
      context: context,
      onTap: () => Navigator.of(context).pop(),
      content: Text(
        l10n.pageEditProfileDialogContactDeletedSuccessfully,
        style: TextStyle(
          color: colores.secondary,
          fontSize: 14.pf,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
