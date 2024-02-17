import 'dart:math';

import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/bloc/bloc_administrar_plantillas.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularAdministrarPlantillas}
/// Vista para administrar las plantillas de comunicaciones
/// {@endtemplate}
class VistaCelularAdministrarPlantillas extends StatefulWidget {
  /// {@macro VistaCelularAdministrarPlantillas}
  const VistaCelularAdministrarPlantillas({super.key});

  @override
  State<VistaCelularAdministrarPlantillas> createState() =>
      _VistaCelularAdministrarPlantillasState();
}

class _VistaCelularAdministrarPlantillasState
    extends State<VistaCelularAdministrarPlantillas> {
  bool modoEliminar = false;
  bool modoEditar = false;

  void onCambioDeModoEliminar() {
    setState(() {
      modoEliminar = !modoEliminar;
    });
  }

  void onCambioDeModoEditar() {
    setState(() {
      modoEditar = !modoEditar;
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
              onCambioDeModo: onCambioDeModoEliminar,
            ),
            SizedBox(height: max(15.ph, 15.sh)),
            DesplegablePlantilla(
              onCancelarEdicion: onCambioDeModoEditar,
              onConfirmarEdicion: () {},
              onEditar: onCambioDeModoEditar,
              onModoEditar: modoEditar,
              necesitaSupervision: true,
              modoEliminar: modoEliminar,
              fechaCreacion: '27/12',
              ultimaEdicion: '10/12',
              descripcionDePlantilla:
                  'ultima edicion: 27/12}ultima edicion: 27/12}ultima edicion: 27/12}ultima edicion: 27/12}ultima edicion: 27/12}ultima edicion: 27/12}ultima edicion: 27/12}ultima edicion: 27/12}ultima edicion: 27/12}ultima edicion: 27/12}ultima edicion: 27/12}',
              tituloPlantilla: 'Este es el titulo',
            ),
          ],
        );
      },
    );
  }
}
