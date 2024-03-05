import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template EncabezadoDelRegistro}
/// Encabezado de la página de registro donde hay un boton para volver al login
/// y un titulo.
/// {@endtemplate}
class EncabezadoDelRegistro extends StatelessWidget {
  /// {@macro EncabezadoDelRegistro}
  const EncabezadoDelRegistro({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => context.router.back(),
              child: Icon(
                Icons.chevron_left,
                color: colores.onBackground,
                size: 45.pw,
              ),
            ),
            GestureDetector(
              onTap: () => context.router.back(),
              child: Text(
                l10n.pageRegisterGoToLoginButton,
                style: TextStyle(
                  color: colores.onBackground,
                  fontSize: 18.pf,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.ph),
        Center(
          child: Text(
            l10n.pageRegisterTitle,
            style: TextStyle(
              color: colores.onBackground,
              fontSize: 30.pf,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        SizedBox(height: 40.ph),
      ],
    );
  }
}
