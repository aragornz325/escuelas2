import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialogExitoso}
/// Dialog de exito al emitir un estado dando un mensaje que salio
/// correctamente.
/// {@endtemplate}
class DialogExitoso extends StatelessWidget {
  /// {@macro DialogExitoso}
  const DialogExitoso({
    required this.titulo,
    super.key,
  });

  /// Texto que se va a mostrar en caso de exito.
  final String titulo;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return EscuelasDialog.exitoso(
      altura: max(65.ph, 65.sh),
      tituloBotonPrincipal: l10n.commonAccept,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sw),
      ),
      context: context,
      onTap: () => Navigator.of(context).pop(),
      content: Text(
        titulo,
        style: TextStyle(
          fontSize: 14.pf,
          fontWeight: FontWeight.w600,
          color: colores.onSecondary,
        ),
      ),
    );
  }
}
