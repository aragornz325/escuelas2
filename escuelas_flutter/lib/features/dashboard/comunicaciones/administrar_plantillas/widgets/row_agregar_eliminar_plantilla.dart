import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template RowAgregarEliminarPlantilla}
/// Row que contiene el boton para agregar una nueva plantilla y el boton
/// para entrar en modo eliminacion
/// {@endtemplate}
class RowAgregarEliminarPlantilla extends StatelessWidget {
  /// {@macro RowAgregarEliminarPlantilla}
  const RowAgregarEliminarPlantilla({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.pw),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BotonAgregarPlantilla(),
          // if(modoEliminar)
          RowModoEliminar(),
        ],
      ),
    );
  }
}

/// {@template BotonAgregarPlantilla}
/// Boton para agregar una nueva plantilla
/// {@endtemplate}
class BotonAgregarPlantilla extends StatelessWidget {
  /// {@macro BotonAgregarPlantilla}
  const BotonAgregarPlantilla({super.key});
  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Agregar nueva',
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
    );
  }
}

/// {@template RowModoEliminar}
/// Row que contiene el boton para cancelar el modo eliminar y el boton
/// para eliminar las plantillas seleccionadas
/// {@endtemplate}
class RowModoEliminar extends StatelessWidget {
  /// {@macro RowModoEliminar}
  const RowModoEliminar({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colores = context.colores;

    return Row(
      children: [
        Text(
          l10n.commonCancel,
          style: TextStyle(
            color: colores.error,
            fontSize: 14.pf,
          ),
        ),
        SizedBox(width: 8.sw),
        GestureDetector(
          onTap: () {},
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
              padding: EdgeInsets.symmetric(horizontal: 5.pw, vertical: 2.ph),
              child: Text(
                //! TODO(Manu): l10n
                'Eliminar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.pf,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
