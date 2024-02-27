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
  bool necesitaSupervicion = false;
  bool estaSeleccionadoz = false;

  void onCambioModoEliminar() {
    final state = context.read<BlocAdministrarPlantillas>().state;
    if (state.modoEliminar == false) {
      context.read<BlocAdministrarPlantillas>().add(
            BlocAdministrarPlantillasEventoCambiarModoEliminar(
              modoEliminar: true,
            ),
          );
    } else {
      context.read<BlocAdministrarPlantillas>().add(
            BlocAdministrarPlantillasEventoCambiarModoEliminar(
              modoEliminar: false,
            ),
          );
    }
  }

  // void onCambioModoEditar() {
  //   final state = context.read<BlocAdministrarPlantillas>().state;
  //   if (state.modoEditar == false) {
  //     context.read<BlocAdministrarPlantillas>().add(
  //           BlocAdministrarPlantillasEventoCambiarModoEditar(
  //             modoEditar: true,
  //           ),
  //         );
  //   } else {
  //     context.read<BlocAdministrarPlantillas>().add(
  //           BlocAdministrarPlantillasEventoCambiarModoEditar(
  //             modoEditar: false,
  //           ),
  //         );
  //   }
  // }

  // void onEditarPlantilla() {
  //   final state = context.read<BlocAdministrarPlantillas>().state;
  //   context.read<BlocAdministrarPlantillas>().add(
  //         BlocAdministrarPlantillasEventoEditarPlantilla(
  //           plantilla: state.plantilla!,
  //         ),
  //       );
  // }
  // void onCambioSeleccionEliminar(PlantillaComunicacion plantilla) {
  //   final state = context.read<BlocAdministrarPlantillas>().state;
  //   if (state.seleccionado == false) {
  //     context.read<BlocAdministrarPlantillas>().add(
  //           BlocAdministrarPlantillasEventoCambioSeleccionado(
  //             plantillaSeleccionada: true,
  //             plantilla: plantilla,
  //           ),
  //         );
  //   } else {
  //     context.read<BlocAdministrarPlantillas>().add(
  //           BlocAdministrarPlantillasEventoCambioSeleccionado(
  //             plantillaSeleccionada: true,
  //             plantilla: plantilla,
  //           ),
  //         );
  //   }
  // }

  void onCambiarNecesitaSupervision(bool? value) {
    setState(() {
      necesitaSupervicion = !necesitaSupervicion;
    });
  }

  // void onCambioSeleccionEliminar(bool? value) {
  //   final state = context.read<BlocAdministrarPlantillas>().state;

  //   if (state.seleccionado == false) {
  //     context.read<BlocAdministrarPlantillas>().add(
  //           const BlocAdministrarPlantillasEventoCambioSeleccionado(
  //             plantillaSeleccionada: true,
  //           ),
  //         );
  //   } else {
  //     context.read<BlocAdministrarPlantillas>().add(
  //           const BlocAdministrarPlantillasEventoCambioSeleccionado(
  //             plantillaSeleccionada: false,
  //           ),
  //         );
  //   }
  // }

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
      },
      builder: (context, state) {
        return Column(
          children: [
            RowAgregarEliminarPlantilla(
              // onEliminarPlantillas: () {},
              modoEliminar: state.modoEliminar,
              onCambioDeModo: onCambioModoEliminar,
              onAgregarPlantilla: () => _onAgregarPlantilla(context),
            ),
            SizedBox(height: max(15.ph, 15.sh)),
            SizedBox(
              height: max(610.ph, 610.sh),
              child: SingleChildScrollView(
                child: Column(
                  children: state.listaDePlantillas
                      .map(
                        (e) => Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: max(10.ph, 10.sh),
                          ),
                          child: DesplegablePlantilla(
                            checkBoxValue: estaSeleccionadoz,

                            // context.read<BlocAdministrarPlantillas>().add(
                            //       BlocAdministrarPlantillasEventoCambioSeleccionado(
                            //         plantillaSeleccionada: e,
                            //         select: true,
                            //       ),
                            //     );
                            // estaSeleccionado: estaSeleccionado
                            // // state.listaDePlantillasAEliminar.contains(e),
                            // ,
                            // onChangedEliminar: (value) {
                            //   setState(() {
                            //     estaSeleccionado = value;
                            //   });

                            //   // context.read<BlocAdministrarPlantillas>().add(
                            //   //       BlocAdministrarPlantillasEventoCambioSeleccionado(
                            //   //         plantillaSeleccionada: e,
                            //   //         select: true,
                            //   //       ),
                            //   //     );
                            // },
                            onChanged: onCambiarNecesitaSupervision,
                            //! TODO(Manu): Verificar si me lo admiten, ya que no pude mantener orden de lista ni hacer que un solo expansiontile entre en modoedicion
                            onCancelarEdicion: () {},

                            onEditar: () => onEditar(context, plantilla: e),
                            onModoEditar: state.modoEditar,
                            necesitaSupervision: e.necesitaSupervision,
                            onModoEliminar: state.modoEliminar,
                            plantilla: e,
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
