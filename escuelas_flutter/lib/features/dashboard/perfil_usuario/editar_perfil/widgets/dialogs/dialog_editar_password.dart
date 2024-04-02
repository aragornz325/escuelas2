import 'dart:math';

import 'package:escuelas_flutter/features/dashboard/perfil_usuario/editar_perfil/bloc/bloc_editar_perfil.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:escuelas_flutter/widgets/escuelas_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

class DialogEditarPassword extends StatefulWidget {
  const DialogEditarPassword({
    required this.dniUsuario,
    required this.idUsuario,
    super.key,
  });

  final String dniUsuario;
  final int idUsuario;
  @override
  State<DialogEditarPassword> createState() => _DialogEditarPasswordState();
}

class _DialogEditarPasswordState extends State<DialogEditarPassword> {
  late TextEditingController _controllerNuevaPassword = TextEditingController();
  bool requerirCambioPassword = true;

  @override
  void initState() {
    _controllerNuevaPassword = TextEditingController(text: widget.dniUsuario);
    super.initState();
  }

  @override
  void dispose() {
    _controllerNuevaPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return EscuelasDialog.solicitudDeAccion(
      titulo: l10n.pageEditProfileDialogChangePassword,
      context: context,
      estaHabilitado: _controllerNuevaPassword.text.length >= 8,
      onTapConfirmar: () {
        Navigator.of(context).pop();
        context.read<BlocEditarPerfil>().add(
              BlocEditarPerfilEventoEditarPassword(
                conRequerimientoDeCambioDePassword: requerirCambioPassword,
                nuevaPassword: _controllerNuevaPassword.text,
                idUsuario: widget.idUsuario,
              ),
            );
      },
      content: Column(
        children: [
          EscuelasTextFieldPassword(
            obscureText: false,
            controller: _controllerNuevaPassword,
            onValidate: (v) {},
            onChanged: (v) => setState(() {}),
          ),
          SizedBox(height: max(5.ph, 5.sh)),
          Row(
            children: [
              Text(l10n.pageEditProfileDialogRequiresChangePassword),
              Checkbox(
                value: requerirCambioPassword,
                onChanged: (v) {
                  setState(() {
                    requerirCambioPassword = v!;
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
