import 'dart:math';

import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/bloc/bloc_administrar_plantillas.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/dialog/dialog.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:escuelas_flutter/widgets/escuelas_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

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
  final _controllerNuevaPlantillaTitulo = TextEditingController();
  final _controllerNuevaPlantillaDescripcion = TextEditingController();
  bool _necesitaSupervision = false;

  @override
  void dispose() {
    _controllerNuevaPlantillaTitulo.dispose();
    _controllerNuevaPlantillaDescripcion.dispose();
    super.dispose();
  }

  Future<void> _onConfirmarPlantilla(
    BuildContext context, {
    required String tituloPlantilla,
    required String descripcionPlantilla,
    required bool necesitaSupervision,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocAdministrarPlantillas>(),
        child: DialogConfirmarCreacionPlantilla(
          tituloPlantilla: tituloPlantilla,
          descripcionPlantilla: descripcionPlantilla,
          necesitaSupervision: necesitaSupervision,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return EscuelasDialog.solicitudDeAccion(
      titulo: l10n.pageManageTemplatesNew,
      estaHabilitado: _controllerNuevaPlantillaTitulo.text.isNotEmpty &&
          _controllerNuevaPlantillaDescripcion.text.isNotEmpty,
      context: context,
      onTapConfirmar: () {
        Navigator.of(context).pop();
        _onConfirmarPlantilla(
          context,
          tituloPlantilla: _controllerNuevaPlantillaTitulo.text,
          descripcionPlantilla: _controllerNuevaPlantillaDescripcion.text,
          necesitaSupervision: _necesitaSupervision,
        );
      },
      content: Column(
        children: [
          EscuelasTextfield(
            onChanged: (value) {
              setState(() {});
            },
            width: 265.pw,
            controller: _controllerNuevaPlantillaTitulo,
            esPassword: false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10.pw,
                vertical: 8.ph,
              ),
              hintText: l10n.pageManageTemplatesTitle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.sw),
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
              controller: _controllerNuevaPlantillaDescripcion,
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
                value: _necesitaSupervision,
                onChanged: (value) {
                  setState(() {
                    _necesitaSupervision = value!;
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
