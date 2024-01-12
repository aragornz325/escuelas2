import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';

/// Extension para el ordenamiento de la lista de usuarios
extension OrdenarPorX on OrdenarPor {
  /// Devuelve el nombre del item correspondiente a la ordenacion
  String nombreItem(BuildContext context) {
    final l10n = context.l10n;

    return switch (this) {
      OrdenarPor.apellido => l10n.commonName,
      OrdenarPor.curso => l10n.commonCourse,
      OrdenarPor.asignatura => l10n.commonSubject,
      _ => l10n.commonName,
    };
  }
}
