import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialogExitoAlEnviarCalificaciones}
/// Dialog de exito al enviar correos.
/// {@endtemplate}
class DialogExitoAlEnviarCalificaciones extends StatelessWidget {
  /// {@macro DialogExitoAlEnviarCalificaciones}
  const DialogExitoAlEnviarCalificaciones({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return EscuelasDialog.exitoso(
      context: context,
      onTap: () => Navigator.of(context).pop(),
      content: DefaultTextStyle(
        style: TextStyle(
          color: colores.onSecondary,
          fontSize: 18.pf,
          fontWeight: FontWeight.w500,
        ),
        child: const Column(
          children: [
            Text(
              '¡Calificaciones actualizadas enviadas con exito!',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
