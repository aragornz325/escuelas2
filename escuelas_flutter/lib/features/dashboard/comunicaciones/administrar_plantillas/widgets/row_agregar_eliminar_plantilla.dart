import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template RowAgregarEliminarPlantilla}
/// Row que contiene el boton para agregar una nueva plantilla y el boton
/// para entrar en modo eliminacion
/// {@endtemplate}
class RowAgregarEliminarPlantilla extends StatelessWidget {
  /// {@macro RowAgregarEliminarPlantilla}
  const RowAgregarEliminarPlantilla({
    required this.onCambioDeModo,
    this.modoEliminar = false,
    super.key,
  });

  /// Determina la composicion dependiendo del modo en que se encuentre
  final bool modoEliminar;

  /// Funcion para cambiar a modo eliminar o cancelar
  final VoidCallback onCambioDeModo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.pw),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const BotonAgregarPlantilla(),
          RowModoEliminar(
            onEliminar: () {},
            modoEliminar: modoEliminar,
            onCambioDeModo: onCambioDeModo,
          ),
        ],
      ),
    );
  }
}
