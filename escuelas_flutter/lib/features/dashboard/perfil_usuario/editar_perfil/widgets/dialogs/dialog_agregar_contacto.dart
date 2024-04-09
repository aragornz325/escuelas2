import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
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
  final _controllerNombre = TextEditingController();
  final _controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colores = context.colores;

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
              l10n.commonName,
              textAlign: TextAlign.start,
            ),
          ),
          EscuelasTextfield(
            esPassword: false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15.sw),
              filled: true,
              fillColor: colores.tertiary,
              hintText: l10n.commonName,
              hintStyle: TextStyle(
                fontSize: 16.pf,
                color: colores.onSecondary,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.sw),
                borderSide: BorderSide.none,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.sw),
                borderSide: BorderSide.none,
              ),
              errorStyle: TextStyle(color: colores.error),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colores.error),
                borderRadius: BorderRadius.circular(40.sw),
              ),
            ),
            controller: _controllerNombre,
            onChanged: (p0) {},
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
