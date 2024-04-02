import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/bloc_dashboard/bloc_dashboard.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:escuelas_flutter/widgets/escuelas_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialogCambiarContrasenia}
/// Dialog para cambiar la contraseña.
/// {@endtemplate}
class DialogCambiarContrasenia extends StatefulWidget {
  /// {@macro DialogCambiarContrasenia}
  const DialogCambiarContrasenia({super.key});

  @override
  State<DialogCambiarContrasenia> createState() =>
      _DialogCambiarContraseniaState();
}

class _DialogCambiarContraseniaState extends State<DialogCambiarContrasenia> {
  /// Key para el formulario.
  final _formKey = GlobalKey<FormState>();

  /// Controlador para la contraseña.
  final _controllerPassword = TextEditingController();

  /// Controlador para que las contrasenias coincidan para cambiar la contraseña
  final _controllerRepeatPassword = TextEditingController();

  /// Getter para saber si las contraseñas contienen 12 caracteres.
  bool get lasContraseniasContienen12Caracteres =>
      _controllerPassword.text.isNotEmpty &&
      _controllerRepeatPassword.text.isNotEmpty &&
      _controllerPassword.text.length >= 12 &&
      _controllerRepeatPassword.text.length >= 12;

  /// Getter para saber si las contraseñas son iguales
  bool get lasContraseniasCoinciden =>
      _controllerPassword.text == _controllerRepeatPassword.text;

  @override
  void dispose() {
    _controllerPassword.dispose();
    _controllerRepeatPassword.dispose();

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
                  BlocDashboardEventoCambiarContrasenia(
                    _controllerPassword.text,
                  ),
                );
            Navigator.pop(context);
          }
        },
        content: Column(
          children: [
            Text(
              l10n.pageHomeYouChangePassword,
              style: TextStyle(
                fontSize: 16.pf,
                fontWeight: FontWeight.w600,
                color: colores.onBackground,
              ),
            ),
            SizedBox(height: max(10.ph, 10.sh)),
            EscuelasTextFieldPassword(
              hintText: l10n.commonPassword,
              controller: _controllerPassword,
              onValidate: (v) {},
              onChanged: (v) => setState(() {}),
            ),
            SizedBox(height: max(10.ph, 10.sh)),
            EscuelasTextFieldPassword(
              hintText: l10n.pageRegisterConfirmPassword,
              controller: _controllerRepeatPassword,
              onValidate: (v) {},
              onChanged: (v) => setState(() {}),
            ),
            if (lasContraseniasContienen12Caracteres)
              Padding(
                padding: EdgeInsets.only(left: 15.pw),
                child: Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: colores.verdeConfirmar,
                      size: 14.pf,
                    ),
                    if (lasContraseniasCoinciden)
                      Text(
                        l10n.pageRegisterPasswordMatch,
                        style: TextStyle(
                          color: colores.verdeConfirmar,
                          fontSize: 14.pf,
                        ),
                      ),
                    if (false == lasContraseniasCoinciden)
                      Text(
                        l10n.pageRegisterPasswordDoNotMatch,
                        style: TextStyle(
                          color: colores.error,
                          fontSize: 14.pf,
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
