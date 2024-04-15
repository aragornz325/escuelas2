import 'dart:math';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/etiqueta_email.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/editar_perfil/bloc/bloc_editar_perfil.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:escuelas_flutter/widgets/escuelas_dropdown_popup.dart';
import 'package:escuelas_flutter/widgets/escuelas_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialogEditarContacto}
/// Dialog para editar un contacto.
/// {@endtemplate
class DialogEditarContacto extends StatefulWidget {
  /// {@macro DialogEditarContacto}
  const DialogEditarContacto({
    required this.contacto,
    super.key,
  });

  /// Contacto a editar
  final DireccionDeEmail contacto;

  @override
  State<DialogEditarContacto> createState() => _DialogEditarContactoState();
}

class _DialogEditarContactoState extends State<DialogEditarContacto> {
  late TextEditingController _controllerEmail;
  EtiquetaDireccionEmail? etiqueta;

  @override
  void initState() {
    _controllerEmail =
        TextEditingController(text: widget.contacto.direccionDeEmail);
    super.initState();
  }

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
      titulo: 'Editar contacto',
      context: context,
      onTapConfirmar: () {
        if (etiqueta != null && _controllerEmail.text.isNotEmpty) {
          context.read<BlocEditarPerfil>().add(
                BlocEditarPerfilEventoEditarContacto(
                  idDireccionDeEmail: widget.contacto.id ?? 0,
                  nuevoEmail: _controllerEmail.text,
                  nuevaEtiqueta: etiqueta!,
                ),
              );
          Navigator.pop(context);
        }
      },
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
              initiallySelected: [
                PopupOption(
                  id: widget.contacto.etiqueta?.index ?? 0,
                  name:
                      widget.contacto.etiqueta?.nombreParentezco(context) ?? '',
                ),
              ],
              list: lista,
              onChanged: (value) {
                etiqueta = EtiquetaDireccionEmail.values
                    .firstWhere((element) => element.index == value.first.id);
                setState(() {});
              },
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
