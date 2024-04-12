import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:escuelas_flutter/widgets/escuelas_textfield.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    _controllerEmail =
        TextEditingController(text: widget.contacto.direccionDeEmail);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EscuelasDialog.solicitudDeAccion(
      titulo: 'Editar contacto',
      context: context,
      onTapConfirmar: () {},
      content: Column(
        children: [
          EscuelasTextfield.email(
            controller: _controllerEmail,
            context: context,
          ),
        ],
      ),
    );
  }
}
