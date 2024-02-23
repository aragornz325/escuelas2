import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/bloc/bloc_administrar_plantillas.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
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
  bool estaSeleccionado = false;

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
        child: DialogPlantillaCreadaConExito(
          tituloPlantilla: tituloPlantilla,
        ),
      ),
    );
  }

  Future<void> _onPlantillaEditadaConExito(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocAdministrarPlantillas>(),
        child: const DialogPlantillaEditadaConExito(),
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
                            estaSeleccionado: state.seleccionado,
                            onChangedEliminar: (p0) {},
                            onChanged: onCambiarNecesitaSupervision,
                            onCancelarEdicion: onCambioModoEditar,
                            onEditar: onCambioModoEditar,
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

/// {@template DialogAgregarPlantilla}
/// Dialogo para agregar una nueva plantilla
/// {@endtemplate}
class DialogAgregarPlantilla extends StatefulWidget {
  /// {@macro DialogAgregarPlantilla}
  const DialogAgregarPlantilla({super.key});

  @override
  State<DialogAgregarPlantilla> createState() => _DialogAgregarPlantillaState();
}

class _DialogAgregarPlantillaState extends State<DialogAgregarPlantilla> {
  final controllerNuevaPlantillaTitulo = TextEditingController();
  final controllerNuevaPlantillaDescripcion = TextEditingController();
  bool necesitaSupervicion = false;

  Future<void> _onConfirmarPlantilla(
    BuildContext context, {
    required String tituloPlantilla,
    required String descripcionPlantilla,
    required bool necesitaSupervicionn,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocAdministrarPlantillas>(),
        child: DialogConfirmarCreacionPlantilla(
          tituloPlantilla: tituloPlantilla,
          descripcionPlantilla: descripcionPlantilla,
          necesitaSupervicion: necesitaSupervicionn,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return EscuelasDialog.solicitudDeAccion(
      titulo: l10n.pageManageTemplatesNew,
      estaHabilitado: (controllerNuevaPlantillaTitulo.text.isNotEmpty &&
          controllerNuevaPlantillaDescripcion.text.isNotEmpty),
      context: context,
      onTapConfirmar: () {
        Navigator.of(context).pop();
        _onConfirmarPlantilla(
          context,
          tituloPlantilla: controllerNuevaPlantillaTitulo.text,
          descripcionPlantilla: controllerNuevaPlantillaDescripcion.text,
          necesitaSupervicionn: necesitaSupervicion,
        );
      },
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
              hintText: l10n.pageManageTemplatesTitle,
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
                hintText: l10n.pageManageTemplatesDialogWriteHere,
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
              Checkbox(
                value: necesitaSupervicion,
                onChanged: (value) {
                  setState(() {
                    necesitaSupervicion = value!;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// {@template DialogConfirmarCreacionPlantilla}
/// Dialogo para confirmar la creacion de una nueva plantilla
/// {@endtemplate}
class DialogConfirmarCreacionPlantilla extends StatelessWidget {
  /// {@macro DialogConfirmarCreacionPlantilla}
  const DialogConfirmarCreacionPlantilla({
    required this.tituloPlantilla,
    required this.descripcionPlantilla,
    required this.necesitaSupervicion,
    super.key,
  });

  /// titulo de la plantilla
  final String tituloPlantilla;
  final String descripcionPlantilla;
  final bool necesitaSupervicion;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return EscuelasDialog.solicitudDeAccion(
      estaHabilitado: true,
      titulo: l10n.commonAttention,
      context: context,
      onTapConfirmar: () {
        context.read<BlocAdministrarPlantillas>().add(
              BlocAdministrarPlantillasEventoAgregarPlantilla(
                nombrePlantilla: tituloPlantilla,
                descripcionPlantilla: descripcionPlantilla,
                necesitaSupervicion: necesitaSupervicion,
              ),
            );
        Navigator.of(context).pop();
      },
      content: Column(
        children: [
          Text(
            textAlign: TextAlign.center,
            l10n.pageManageTemplatesWillCreate,
          ),
          Text(
            '"$tituloPlantilla"',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(l10n.pageManageTemplatesWantContinue),
        ],
      ),
    );
  }
}

/// {@template DialogPlantillaCreadaConExito}
/// Dialog a mostrarse para notificar que la plantilla fue creada con exito
/// {@endtemplate}
class DialogPlantillaCreadaConExito extends StatelessWidget {
  /// {@macro DialogPlantillaCreadaConExito}
  const DialogPlantillaCreadaConExito({
    required this.tituloPlantilla,
    super.key,
  });

  /// titulo de la plantilla
  final String tituloPlantilla;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    final l10n = context.l10n;

    return EscuelasDialog.exitoso(
      altura: max(100.ph, 100.sh),
      context: context,
      onTap: () => Navigator.of(context).pop(),
      content: Column(
        children: [
          SizedBox(height: max(30.ph, 30.sh)),
          RichText(
            maxLines: 2,
            textAlign: TextAlign.end,
            text: TextSpan(
              children: [
                TextSpan(
                  text: l10n.pageManageTemplatesDialogSuccessPartOne,
                  style: TextStyle(
                    color: colores.grisSC,
                    fontSize: 16.pf,
                  ),
                ),
                TextSpan(
                  text: ' "$tituloPlantilla"',
                  style: TextStyle(
                    color: colores.onBackground,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.pf,
                  ),
                ),
                TextSpan(
                  text: l10n.pageManageTemplatesDialogSuccessPartTwo,
                  style: TextStyle(
                    color: colores.grisSC,
                    fontSize: 16.pf,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// {@template DialogPlantillaEditadaConExito}
/// Dialog a mostrarse para notificar que la plantilla fue editada con exito
/// {@endtemplate}
class DialogPlantillaEditadaConExito extends StatelessWidget {
  /// {@macro DialogPlantillaEditadaConExito}
  const DialogPlantillaEditadaConExito({super.key});

  @override
  Widget build(BuildContext context) {
    return EscuelasDialog.exitoso(
        context: context,
        onTap: () => Navigator.of(context).pop(),
        //! TODO(Manu): l10n
        content: Text('Plantilla editada con exito'));
  }
}
