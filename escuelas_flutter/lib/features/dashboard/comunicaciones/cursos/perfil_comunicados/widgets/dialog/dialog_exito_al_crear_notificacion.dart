import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialogExitoAlCrearNotificacion}
/// Dialog de exito al crear una nueva notificacion con o sin una plantilla.
/// {@endtemplate}
class DialogExitoAlCrearNotificacion extends StatelessWidget {
  /// {@macro DialogExitoAlCrearNotificacion}
  const DialogExitoAlCrearNotificacion({
    required this.tituloPlantilla,
    super.key,
  });

  /// Titulo de la plantilla al crear una nueva notificacion.
  final String? tituloPlantilla;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    final l10n = context.l10n;

    return EscuelasDialog.exitoso(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sw),
      ),
      ancho: 300.pw,
      context: context,
      onTap: () => Navigator.of(context).pop(),
      content: IntrinsicHeight(
        child: Column(
          children: [
            if (tituloPlantilla != null)
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: l10n.commonTemplate,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.pf,
                        color: colores.grisSC,
                      ),
                    ),
                    TextSpan(
                      text: ' “$tituloPlantilla“',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.pf,
                        color: colores.grisSC,
                      ),
                    ),
                  ],
                ),
              ),
            Text(
              l10n.dialogCreationNotificationCreatedSuccess,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.pf,
                color: colores.grisSC,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
