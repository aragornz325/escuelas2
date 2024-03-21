import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialogExitoAlGuardarCambios}
/// Dialogo de exito al guardar cambios.
/// {@endtemplate}

class DialogExitoAlGuardarCambios extends StatelessWidget {
  /// {@macro DialogExitoAlGuardarCambios}
  const DialogExitoAlGuardarCambios({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return EscuelasDialog.exitoso(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sw),
      ),
      altura: max(50.ph, 50.sh),
      context: context,
      onTap: () => Navigator.of(context).pop(),
      content: Text(
        // TODO(mati): l10n
        '¡El perfil fue editado correctamente!',
        style: TextStyle(
          color: colores.secondary,
          fontSize: 14.pf,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
