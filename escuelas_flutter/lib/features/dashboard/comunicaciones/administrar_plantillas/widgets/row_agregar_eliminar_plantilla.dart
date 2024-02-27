import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/bloc/bloc_administrar_plantillas.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template RowAgregarEliminarPlantilla}
/// Row que contiene el boton para agregar una nueva plantilla y el boton
/// para entrar en modo eliminacion
/// {@endtemplate}
class RowAgregarEliminarPlantilla extends StatelessWidget {
  /// {@macro RowAgregarEliminarPlantilla}
  const RowAgregarEliminarPlantilla({
    required this.onCambioDeModo,
    required this.onAgregarPlantilla,
    required this.onCancelarModoEliminar,
    this.modoEliminar = false,
    super.key,
  });

  /// Determina la composicion dependiendo del modo en que se encuentre
  final bool modoEliminar;

  /// Funcion para cambiar a modo eliminar o cancelar
  final VoidCallback onCambioDeModo;

  /// Funcion para agregar una nueva plantilla
  final VoidCallback onAgregarPlantilla;

  /// Funcion para el boton de cancelar modo eliminar
  final VoidCallback onCancelarModoEliminar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.pw),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BotonAgregarPlantilla(onAgregarPlantilla: onAgregarPlantilla),
          RowModoEliminar(
            onEliminar: () {
              final state = context.read<BlocAdministrarPlantillas>().state;
              for (final plantilla in state.listaDePlantillasAEliminar) {
                context.read<BlocAdministrarPlantillas>().add(
                      BlocAdministrarPlantillasEventoEliminarPlantillas(
                        idPlantilla: plantilla.id ?? 0,
                      ),
                    );
              }
            },
            onCancelModoEliminar: onCancelarModoEliminar,
            modoEliminar: modoEliminar,
            onCambioDeModo: onCambioDeModo,
          ),
        ],
      ),
    );
  }
}
