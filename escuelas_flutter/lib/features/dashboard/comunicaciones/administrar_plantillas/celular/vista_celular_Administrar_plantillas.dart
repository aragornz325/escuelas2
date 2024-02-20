import 'dart:math';

import 'package:escuelas_flutter/extensiones/date_time.dart';
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
  bool necesitaSupervicion = false;

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

  void onCambioModoEditar() {
    final state = context.read<BlocAdministrarPlantillas>().state;
    if (state.modoEditar == false) {
      context.read<BlocAdministrarPlantillas>().add(
            BlocAdministrarPlantillasEventoCambiarModoEditar(
              modoEditar: true,
            ),
          );
    } else {
      context.read<BlocAdministrarPlantillas>().add(
            BlocAdministrarPlantillasEventoCambiarModoEditar(
              modoEditar: false,
            ),
          );
    }
  }

  void onCambiarNecesitaSupervision(bool? value) {
    setState(() {
      necesitaSupervicion = !necesitaSupervicion;
    });
  }

  final plantillas = [
    PlantillaDeComunicaciones(
      necesitaSupervision: true,
      titulo: 'Hola',
      descripcion: ' descripcion 1',
      fechaCreacion: DateTime.now(),
      ultimaEdicion: DateTime.now(),
    ),
    PlantillaDeComunicaciones(
      necesitaSupervision: true,
      titulo: 'Hola',
      descripcion: ' descripcion 1',
      fechaCreacion: DateTime.now(),
      ultimaEdicion: DateTime.now(),
    ),
    PlantillaDeComunicaciones(
      necesitaSupervision: false,
      titulo: ' titulo',
      descripcion: '2',
      fechaCreacion: DateTime.now(),
      ultimaEdicion: DateTime.now(),
    ),
    PlantillaDeComunicaciones(
      necesitaSupervision: true,
      titulo: 'kakak',
      descripcion: ' descripcion 3',
      fechaCreacion: DateTime.now(),
      ultimaEdicion: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocAdministrarPlantillas,
        BlocAdministrarPlantillasEstado>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              RowAgregarEliminarPlantilla(
                modoEliminar: state.modoEliminar,
                onCambioDeModo: onCambioModoEliminar,
              ),
              SizedBox(height: max(15.ph, 15.sh)),
              SizedBox(
                height: max(610.ph, 610.sh),
                child: SingleChildScrollView(
                  child: Column(
                    children: plantillas
                        .map(
                          (e) => Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: max(10.ph, 10.sh),
                            ),
                            child: DesplegablePlantilla(
                              onChanged: onCambiarNecesitaSupervision,
                              onCancelarEdicion: onCambioModoEditar,
                              onConfirmarEdicion: () {},
                              onEditar: onCambioModoEditar,
                              onModoEditar: state.modoEditar,
                              necesitaSupervision: e.necesitaSupervision,
                              onModoEliminar: state.modoEliminar,
                              fechaCreacion: e.fechaCreacion.formatear,
                              ultimaEdicion: e.ultimaEdicion.formatear,
                              descripcionDePlantilla: e.descripcion,
                              tituloPlantilla: e.titulo,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class PlantillaDeComunicaciones {
  PlantillaDeComunicaciones({
    required this.necesitaSupervision,
    required this.titulo,
    required this.descripcion,
    required this.ultimaEdicion,
    required this.fechaCreacion,
  });

  final bool necesitaSupervision;
  final String titulo;
  final String descripcion;
  final DateTime fechaCreacion;
  final DateTime ultimaEdicion;
}
