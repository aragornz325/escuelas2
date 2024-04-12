import 'dart:math';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:escuelas_flutter/widgets/escuelas_dropdown_popup.dart';
import 'package:escuelas_flutter/widgets/escuelas_textfield.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialogAgregarContacto}
/// Dialog para agregar un nuevo contacto.
/// {@endtemplate}
class DialogAgregarContacto extends StatefulWidget {
  /// {@macro DialogAgregarContacto}
  const DialogAgregarContacto({
    required this.onTapConfirmar,
    super.key,
  });

  /// Funcion que se ejecuta al confirmar el dialog.
  final VoidCallback onTapConfirmar;

  @override
  State<DialogAgregarContacto> createState() => _DialogAgregarContactoState();
}

class _DialogAgregarContactoState extends State<DialogAgregarContacto> {
  final _controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final listaDeValores = EtiquetaDireccionEmail.values.skip(1).toList();
    final lista = <PopupOption>[
      ...listaDeValores.map(
        (e) => PopupOption(id: e.index, name: e.nombreParentezco(context)),
      ),
    ];

    return EscuelasDialog.solicitudDeAccion(
      titulo: l10n.pageEditProfileDialogAddContact.toUpperCase(),
      context: context,
      onTapConfirmar: widget.onTapConfirmar,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sw, vertical: 10.sh),
            child: Text(
              l10n.tagEmailKinship,
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            height: max(50.ph, 50.sh),
            width: 300.pw,
            child: EscuelasDropdownPopup(
              list: lista,
              onChanged: (value) {},
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sw, vertical: 10.sh),
            child: Text(
              l10n.commonEmail,
              textAlign: TextAlign.start,
            ),
          ),
          EscuelasTextfield.email(
            controller: _controllerEmail,
            context: context,
          ),
        ],
      ),
    );
  }
}
