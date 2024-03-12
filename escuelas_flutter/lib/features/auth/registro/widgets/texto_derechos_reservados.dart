import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template TextoDerechosReservados}
/// Texto que muestra los derechos reservados de la aplicación.
/// {@endtemplate}
class TextoDerechosReservados extends StatelessWidget {
  /// {@macro TextoDerechosReservados}
  const TextoDerechosReservados({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l10n.pageRegisterDevelopedByNidus,
        ),
        Text(
          l10n.pageRegisterCopyrightText,
        ),
        SizedBox(height: 15.ph),
      ],
    );
  }
}
