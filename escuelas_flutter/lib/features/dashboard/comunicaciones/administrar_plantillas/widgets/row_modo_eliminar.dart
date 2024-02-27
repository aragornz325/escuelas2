import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template RowModoEliminar}
/// Row que contiene el boton para cancelar el modo eliminar y el boton
/// para eliminar las plantillas seleccionadas
/// {@endtemplate}
class RowModoEliminar extends StatelessWidget {
  /// {@macro RowModoEliminar}
  const RowModoEliminar({
    required this.modoEliminar,
    required this.onEliminar,
    required this.onCambioDeModo,
    required this.onCancelModoEliminar,
    super.key,
  });

  /// Determina la composicion del componente
  final bool modoEliminar;

  /// Accion para cambiar a modo eliminar o cancelar
  final VoidCallback onCambioDeModo;

  /// Accion para eliminar las plantillas
  final VoidCallback onEliminar;

  /// Accion que cancela el modo eliminar
  final VoidCallback onCancelModoEliminar;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colores = context.colores;

    return modoEliminar
        ? Row(
            children: [
              InkWell(
                onTap: onCancelModoEliminar,
                child: Text(
                  l10n.commonCancel,
                  style: TextStyle(
                    color: colores.error,
                    fontSize: 14.pf,
                  ),
                ),
              ),
              SizedBox(width: 8.sw),
              GestureDetector(
                onTap: onEliminar,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.sw),
                    ),
                    color: colores.error,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: .1,
                        blurRadius: 2,
                        offset: const Offset(-2, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.pw, vertical: 2.ph),
                    child: Text(
                      l10n.commonDelete,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.pf,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : InkWell(
            onTap: onCambioDeModo,
            child: Icon(
              Icons.delete_outline,
              color: colores.error,
              size: 24.sw,
            ),
          );
  }
}
