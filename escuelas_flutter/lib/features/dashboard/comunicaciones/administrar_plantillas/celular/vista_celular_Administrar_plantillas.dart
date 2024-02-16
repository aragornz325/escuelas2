import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/bloc/bloc_administrar_plantillas.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/widgets/row_agregar_eliminar_plantilla.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

class VistaCelularAdministrarPlantillas extends StatefulWidget {
  const VistaCelularAdministrarPlantillas({super.key});

  @override
  State<VistaCelularAdministrarPlantillas> createState() =>
      _VistaCelularAdministrarPlantillasState();
}

class _VistaCelularAdministrarPlantillasState
    extends State<VistaCelularAdministrarPlantillas> {
  bool modoEliminar = false;
  void onCambioDeModo() {
    setState(() {
      modoEliminar = !modoEliminar;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocAdministrarPlantillas,
        BlocAdministrarPlantillasEstado>(
      builder: (context, state) {
        return Column(
          children: [
            RowAgregarEliminarPlantilla(
              modoEliminar: modoEliminar,
              onCambioDeModo: onCambioDeModo,
            ),
            SizedBox(height: 15.ph),
            DesplegablePlantilla(
              necesitaSupervision: true,
              modoEliminar: modoEliminar,
            ),
          ],
        );
      },
    );
  }
}
