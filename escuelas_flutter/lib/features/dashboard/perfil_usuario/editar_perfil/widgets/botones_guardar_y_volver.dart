import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template BotonesGuardarYVolver}
/// Botones de 'Guardar cambios' y 'Volver'.
/// {@endtemplate}
class BotonesGuardarYVolver extends StatelessWidget {
  /// {@macro BotonesGuardarYVolver}
  const BotonesGuardarYVolver({
    required this.onTapConfirmar,
    super.key,
  });

  final VoidCallback onTapConfirmar;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.pw),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          EscuelasBoton(
            height: max(40.ph, 40.sh),
            width: 130.pw,
            estaHabilitado: true,
            onTap: onTapConfirmar,
            color: colores.verdeConfirmar,
            child: Text(
              l10n.commonSaveChange.toUpperCase(),
              style: TextStyle(
                color: colores.background,
                fontSize: 12.pf,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          EscuelasBoton.outlined(
            height: max(40.ph, 40.sh),
            width: 130.pw,
            texto: '',
            colorOutline: colores.verdeConfirmar,
            context: context,
            estaHabilitado: true,
            onTap: () => context.router.maybePop(),
            color: colores.verdeConfirmar,
            child: Text(
              l10n.commonBack.toUpperCase(),
              style: TextStyle(
                color: colores.verdeConfirmar,
                fontSize: 12.pf,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
