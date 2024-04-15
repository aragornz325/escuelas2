import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialogConfirmarEliminado}
/// Dialog para confirmar la eliminacion de un contacto
/// {@endtemplate}
class DialogConfirmarEliminado extends StatelessWidget {
  /// {@macro DialogConfirmarEliminado}
  const DialogConfirmarEliminado({
    required this.contacto,
    required this.onTapConfirmar,
    super.key,
  });

  /// Contacto a eliminar
  final DireccionDeEmail contacto;

  /// Funcion a realizarse en la confirmacion
  final VoidCallback onTapConfirmar;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return EscuelasDialog.solicitudDeAccion(
      ancho: 400.pw,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sw),
      ),
      onTapConfirmar: () {
        onTapConfirmar.call();
        Navigator.pop(context);
      },
      content: Text(
        '${l10n.pageEditProfileDialogAreYouSure} \n ${contacto.direccionDeEmail}',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14.pf,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
