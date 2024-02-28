import 'dart:math';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/bloc/bloc_administrar_plantillas.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/dialog/dialog.dart';
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
  Future<void> _onAgregarPlantilla(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocAdministrarPlantillas>(),
        child: const DialogAgregarPlantilla(),
      ),
    );
  }

  Future<void> _onPlantillaCreadaConExito(
    BuildContext context, {
    required String tituloPlantilla,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocAdministrarPlantillas>(),
        child: DialogCreadaExitosamente(
          tituloPlantilla: tituloPlantilla,
        ),
      ),
    );
  }

  Future<void> onEditar(
    BuildContext context, {
    required PlantillaComunicacion plantilla,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocAdministrarPlantillas>(),
        child: DialogEditarPlantilla(
          plantilla: plantilla,
        ),
      ),
    );
  }

  Future<void> _onPlantillaEditadaConExito(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocAdministrarPlantillas>(),
        child: const DialogEditadaExitosamente(),
      ),
    );
  }

  Future<void> _onPlantillaEliminadaConExito(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocAdministrarPlantillas>(),
        child: const DialogEliminadoExitosamente(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlocAdministrarPlantillas,
        BlocAdministrarPlantillasEstado>(
      listener: (context, state) {
        if (state is BlocAdministrarPlantillasEstadoExitosoAlCrearPlantilla) {
          _onPlantillaCreadaConExito(
            context,
            tituloPlantilla: state.plantilla?.titulo ?? '',
          );
        }
        if (state is BlocAdministrarPlantillasEstadoExitosoAlEditarPlantilla) {
          _onPlantillaEditadaConExito(context);
        }
        if (state
            is BlocAdministrarPlantillasEstadoExitosoAlEliminarPlantilla) {
          _onPlantillaEliminadaConExito(context);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            RowAgregarEliminarPlantilla(
              onAgregarPlantilla: () => _onAgregarPlantilla(context),
            ),
            SizedBox(height: max(15.ph, 15.sh)),
            SizedBox(
              height: max(610.ph, 610.sh),
              child: SingleChildScrollView(
                child: Column(
                  children: state.listaDePlantillasConCheckbox
                      .map(
                        (e) => Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: max(10.ph, 10.sh),
                          ),
                          child: DesplegablePlantilla(
                            onEditar: () =>
                                onEditar(context, plantilla: e.plantilla),
                            necesitaSupervision:
                                e.plantilla.necesitaSupervision,
                            plantillaConCheckbox: e,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
