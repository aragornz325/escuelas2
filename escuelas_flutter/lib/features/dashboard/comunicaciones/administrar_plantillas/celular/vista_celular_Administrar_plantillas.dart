import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/bloc/bloc_administrar_plantillas.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/widgets/row_agregar_eliminar_plantilla.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

class VistaCelularAdministrarPlantillas extends StatelessWidget {
  const VistaCelularAdministrarPlantillas({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocAdministrarPlantillas,
        BlocAdministrarPlantillasEstado>(
      builder: (context, state) {
        return Column(
          children: [
            RowAgregarEliminarPlantilla(),
            SizedBox(height: 15.ph),
            DesplegablePlantilla()
          ],
        );
      },
    );
  }
}
