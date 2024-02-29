import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialogCreadaExitosamente}
/// Dialog a mostrarse para notificar que la plantilla fue creada con exito
/// {@endtemplate}
class DialogCreadaExitosamente extends StatelessWidget {
  /// {@macro DialogCreadaExitosamente}
  const DialogCreadaExitosamente({
    required this.tituloPlantilla,
    super.key,
  });

  /// titulo de la plantilla
  final String tituloPlantilla;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    final l10n = context.l10n;

    return EscuelasDialog.exitoso(
      altura: max(100.ph, 100.sh),
      context: context,
      onTap: () => Navigator.of(context).pop(),
      content: Column(
        children: [
          SizedBox(height: max(30.ph, 30.sh)),
          RichText(
            maxLines: 2,
            textAlign: TextAlign.end,
            text: TextSpan(
              children: [
                TextSpan(
                  text: l10n.pageManageTemplatesDialogSuccessPartOne,
                  style: TextStyle(
                    color: colores.grisSC,
                    fontSize: 16.pf,
                  ),
                ),
                TextSpan(
                  text: ' "$tituloPlantilla"',
                  style: TextStyle(
                    color: colores.onBackground,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.pf,
                  ),
                ),
                TextSpan(
                  text: l10n.pageManageTemplatesDialogSuccessPartTwo,
                  style: TextStyle(
                    color: colores.grisSC,
                    fontSize: 16.pf,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
