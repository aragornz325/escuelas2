import 'dart:math';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/bloc/bloc_administrar_plantillas.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:escuelas_flutter/widgets/escuelas_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialogEditarPlantilla}
/// Dialogo para editar una plantilla
/// {@endtemplate}
class DialogEditarPlantilla extends StatefulWidget {
  /// {@macro DialogEditarPlantilla}
  const DialogEditarPlantilla({
    required this.plantilla,
    super.key,
  });

  /// Plantilla a editar
  final PlantillaComunicacion plantilla;
  @override
  State<DialogEditarPlantilla> createState() => _DialogEditarPlantillaState();
}

class _DialogEditarPlantillaState extends State<DialogEditarPlantilla> {
  late TextEditingController controllerNuevoTitulo;
  late TextEditingController controllerNuevaDescripcion;

  @override
  void initState() {
    controllerNuevoTitulo =
        TextEditingController(text: widget.plantilla.titulo);
    controllerNuevaDescripcion =
        TextEditingController(text: widget.plantilla.nota);

    super.initState();
  }

  @override
  void dispose() {
    controllerNuevoTitulo.dispose();
    controllerNuevaDescripcion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return EscuelasDialog.solicitudDeAccion(
      titulo: l10n.pageManageTemplatesDialogEditTemplate,
      estaHabilitado: (controllerNuevoTitulo.text.isNotEmpty &&
          controllerNuevaDescripcion.text.isNotEmpty),
      context: context,
      onTapConfirmar: () {
        Navigator.of(context).pop();
        context.read<BlocAdministrarPlantillas>().add(
              BlocAdministrarPlantillasEventoEditarPlantilla(
                idPlantilla: widget.plantilla.id ?? 0,
                plantilla: widget.plantilla,
                nuevoNombre: controllerNuevoTitulo.text,
                nuevaDescripcion: controllerNuevaDescripcion.text,
                nuevaNecesitaSupervision: widget.plantilla.necesitaSupervision,
              ),
            );
      },
      content: Column(
        children: [
          EscuelasTextfield(
            onChanged: (value) {
              setState(() {});
            },
            width: 265.pw,
            controller: controllerNuevoTitulo,
            esPassword: false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.pw,
                vertical: 8.ph,
              ),
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
              controller: controllerNuevaDescripcion,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.pw,
                  vertical: 8.ph,
                ),
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
                value: widget.plantilla.necesitaSupervision,
                onChanged: (value) {
                  setState(() {
                    widget.plantilla.necesitaSupervision = value!;
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
