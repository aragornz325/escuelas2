import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template BotonAgregarPlantilla}
/// Boton para agregar una nueva plantilla
/// {@endtemplate}
class BotonAgregarPlantilla extends StatelessWidget {
  /// {@macro BotonAgregarPlantilla}
  const BotonAgregarPlantilla({
    required this.onAgregarPlantilla,
    super.key,
  });

  /// funcion a ejecutar cuando se presione el boton
  final VoidCallback onAgregarPlantilla;
  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    final l10n = context.l10n;

    return InkWell(
      onTap: onAgregarPlantilla,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l10n.pageManageTemplatesAddNew,
            style: TextStyle(
              color: colores.primary,
              fontSize: 16.pf,
            ),
          ),
          Icon(
            Icons.add,
            color: colores.primary,
            size: 25.sw,
          ),
        ],
      ),
    );
  }
}
