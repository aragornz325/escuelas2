import 'package:escuelas_flutter/extensiones/extensiones.dart';
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

  //TODO(anyone): charlar con todos para ponerse de acuerdo en usar los .show()
  Future<void> show(BuildContext context) => showDialog(
        context: context,
        builder: (_) => this,
      );

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return EscuelasDialog.fallido(
      altura: 80.ph,
      onTap: () => Navigator.pop(context),
      content: Text(
        //TODO(mati): hacer l10n
        'Ha habido un error en el envío de\n notas. Intente nuevamente,',
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
