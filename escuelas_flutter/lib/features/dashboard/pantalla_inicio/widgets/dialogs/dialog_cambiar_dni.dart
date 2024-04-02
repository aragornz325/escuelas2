import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/bloc_dashboard/bloc_dashboard.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:escuelas_flutter/widgets/escuelas_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialogCambiarDNI}
/// Dialog para cambiar la contraseña.
/// {@endtemplate}
class DialogCambiarDNI extends StatefulWidget {
  /// {@macro DialogCambiarDNI}
  const DialogCambiarDNI({super.key});

  @override
  State<DialogCambiarDNI> createState() => _DialogCambiarDNIState();
}

class _DialogCambiarDNIState extends State<DialogCambiarDNI> {
  /// Key para el formulario.
  final _formKey = GlobalKey<FormState>();

  /// Controlador para la contraseña.
  final _controllerDNI = TextEditingController();

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _controllerDNI.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return Form(
      key: _formKey,
      child: EscuelasDialog.confirmar(
        conIconoCerrar: false,
        onTapConfirmar: () {
          if (_formKey.currentState!.validate()) {
            context.read<BlocDashboard>().add(
                  BlocDashboardEventoCambiarDNI(
                    _controllerDNI.text,
                  ),
                );
            Navigator.pop(context);
          }
        },
        content: Column(
          children: [
            Text(
              l10n.pageHomeChangeDNI,
              style: TextStyle(
                fontSize: 16.pf,
                fontWeight: FontWeight.w600,
                color: colores.onBackground,
              ),
            ),
            SizedBox(height: max(10.ph, 10.sh)),
            EscuelasTextfield.soloNumero(
              controller: _controllerDNI,
              hintText: l10n.commonDNI,
              context: context,
              onChanged: (v) {},
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
