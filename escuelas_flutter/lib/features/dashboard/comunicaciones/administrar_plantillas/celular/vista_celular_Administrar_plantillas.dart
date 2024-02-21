import 'dart:math';

import 'package:escuelas_flutter/extensiones/date_time.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/bloc/bloc_administrar_plantillas.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:escuelas_flutter/widgets/escuelas_textfield.dart';
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

  Future<void> _onAgregarPlantilla(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocAdministrarPlantillas>(),
        child: DialogAgregarPlantilla(),
      ),
    );
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
        return Column(
          children: [
            RowAgregarEliminarPlantilla(
              modoEliminar: state.modoEliminar,
              onCambioDeModo: onCambioModoEliminar,
              onAgregarPlantilla: () => _onAgregarPlantilla(context),
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

/// {@template DialogAgregarPlantilla}
/// Dialogo para agregar una nueva plantilla
/// {@endtemplate}
class DialogAgregarPlantilla extends StatefulWidget {
  /// {@macro DialogAgregarPlantilla}
  const DialogAgregarPlantilla({
    super.key,
  });

  @override
  State<DialogAgregarPlantilla> createState() => _DialogAgregarPlantillaState();
}

final controllerNuevaPlantillaTitulo = TextEditingController();
final controllerNuevaPlantillaDescripcion = TextEditingController();

class _DialogAgregarPlantillaState extends State<DialogAgregarPlantilla> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return EscuelasDialog.solicitudDeAccion(
      titulo: 'Nueva plantilla',
      estaHabilitado: (controllerNuevaPlantillaTitulo.text.isNotEmpty &&
          controllerNuevaPlantillaDescripcion.text.isNotEmpty),
      context: context,
      onTapConfirmar: () {},
      content: Column(
        children: [
          EscuelasTextfield(
            onChanged: (value) {
              setState(() {});
            },
            width: 265.pw,
            controller: controllerNuevaPlantillaTitulo,
            esPassword: false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.pw,
                vertical: 8.ph,
              ),
              hintText: 'Título',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: max(8.ph, 8.sh)),
          SizedBox(
            width: 265.pw,
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              maxLines: 5,
              controller: controllerNuevaPlantillaDescripcion,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.pw,
                  vertical: 8.ph,
                ),
                hintText: 'Escribe aquí...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(height: max(8.ph, 8.sh)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.supervised_user_circle_outlined),
                  SizedBox(width: 8.pw),
                  Text(l10n.pageManageTemplatesNeedSupervision),
                ],
              ),
              //! TODO: terminar
              Checkbox(
                value: true,
                onChanged: (value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
