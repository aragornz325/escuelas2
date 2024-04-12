import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';

/// Extension para obtener el nombre de las etiquetas de email
extension EtiquetaDireccionEmailX on EtiquetaDireccionEmail {
  /// Devuelve el nombre de la etiqueta
  String nombreParentezco(BuildContext context) {
    final l10n = context.l10n;

    return switch (this) {
      EtiquetaDireccionEmail.personalPrimario => l10n.tagEmailPersonalPrimary,
      EtiquetaDireccionEmail.personalSecundario =>
        l10n.tagEmailPersonalSecondary,
      EtiquetaDireccionEmail.padre_madre_tutor => l10n.tagEmailParents,
      EtiquetaDireccionEmail.abuelo_abuela => l10n.tagEmailGrandparents,
      EtiquetaDireccionEmail.tio_tia => l10n.tagEmailUncles,
      EtiquetaDireccionEmail.primo_prima => l10n.tagEmailCousins,
      EtiquetaDireccionEmail.otro => l10n.tagEmailOther,
    };
  }
}
