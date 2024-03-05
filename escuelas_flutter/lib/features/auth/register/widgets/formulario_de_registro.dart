import 'package:escuelas_commons/escuelas_commons.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/register/bloc/bloc_registro.dart';
import 'package:escuelas_flutter/features/auth/register/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template FormularioRegistro}
/// Formulario de registro de usuario donde el mismo ingresa sus datos
/// personales.
/// {@endtemplate}
class FormularioRegistro extends StatefulWidget {
  /// {@macro FormularioRegistro}
  const FormularioRegistro({
    super.key,
  });

  @override
  State<FormularioRegistro> createState() => _FormularioRegistroState();
}

class _FormularioRegistroState extends State<FormularioRegistro> {
  final TextEditingController nombreController = TextEditingController();

  final TextEditingController apellidoController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController contraseniaController = TextEditingController();

  final TextEditingController confirmarContraseniaController =
      TextEditingController();

  final TextEditingController documentoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool get lasContraseniasCoinciden =>
      contraseniaController.text.isNotEmpty &&
      confirmarContraseniaController.text.isNotEmpty &&
      contraseniaController.text == confirmarContraseniaController.text &&
      confirmarContraseniaController.text.length >= 12 &&
      contraseniaController.text.length >= 12;

  bool get lasContraseniasContienen12Caracteres =>
      contraseniaController.text.isNotEmpty &&
      confirmarContraseniaController.text.isNotEmpty &&
      contraseniaController.text.length >= 12 &&
      confirmarContraseniaController.text.length >= 12;

  @override
  void dispose() {
    nombreController.dispose();
    apellidoController.dispose();
    emailController.dispose();
    contraseniaController.dispose();
    confirmarContraseniaController.dispose();

    super.dispose();
  }

  bool? emailValido;
  bool? contraseniaValido;
  bool? confirmarContraseniaValida;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextfieldConValidacion(
                  controller: nombreController,
                  onChanged: () => _formKey.currentState?.validate(),
                  hintText: l10n.commonName,
                  icon: Icons.person_outline,
                ),
              ),
              SizedBox(width: 15.pw),
              Flexible(
                child: TextfieldConValidacion(
                  controller: apellidoController,
                  onChanged: () => _formKey.currentState?.validate(),
                  hintText: l10n.commonLastname,
                  icon: Icons.person_outline,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.ph),
          TextfieldConValidacionMail(
            controller: emailController,
            onChanged: () => _formKey.currentState?.validate(),
            hintText: l10n.commonEmail,
            icon: Icons.email_outlined,
          ),
          SizedBox(height: 15.ph),
          EscuelasTextFieldPassword(
            onValidate: (value) => contraseniaValido = value,
            controller: contraseniaController,
            hintText: l10n.commonPassword,
            onChanged: (value) =>
                setState(() => _formKey.currentState?.validate()),
            backgroundColor: contraseniaValido ?? true
                ? colores.tertiary
                : colores.error.withOpacity(.3),
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
                  Text(
                    l10n.pageRegisterMinimucCaractersForPassword(
                      const RedemptorisMissioConfigs()
                          .minimoDeCaracteresPassword,
                    ),
                    style: TextStyle(
                      color: colores.verdeConfirmar,
                      fontSize: 14.pf,
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 15.ph),
          EscuelasTextFieldPassword(
            onValidate: (value) => confirmarContraseniaValida = value,
            controller: confirmarContraseniaController,
            hintText: l10n.pageRegisterConfirmPassword,
            onChanged: (value) =>
                setState(() => _formKey.currentState?.validate()),
            backgroundColor: confirmarContraseniaValida ?? true
                ? colores.tertiary
                : colores.error.withOpacity(.3),
          ),
          if (lasContraseniasCoinciden)
            Padding(
              padding: EdgeInsets.only(left: 15.pw),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  l10n.pageRegisterPasswordMatch,
                  style: TextStyle(
                    color: colores.verdeConfirmar,
                    fontSize: 14.pf,
                  ),
                ),
              ),
            ),
          if (!lasContraseniasCoinciden)
            Padding(
              padding: EdgeInsets.only(left: 15.pw),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  l10n.pageRegisterPasswordDoNotMatch,
                  style: TextStyle(
                    color: colores.error,
                    fontSize: 14.pf,
                  ),
                ),
              ),
            ),
          SizedBox(height: 15.ph),
          TextfieldConValidacion(
            keyboardType: TextInputType.number,
            controller: documentoController,
            onChanged: () => _formKey.currentState?.validate(),
            hintText: l10n.commonDNI,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            icon: Icons.credit_card_outlined,
          ),
          SizedBox(height: 45.ph),
          EscuelasBoton.texto(
            estaHabilitado: true,
            width: 100.wp - 40.pw,
            height: 40.ph,
            onTap: () {
              if (_formKey.currentState?.validate() ?? false) {
                context.read<BlocRegistro>().add(
                      BlocRegistroEventoRegistrarUsuario(
                        nombre: nombreController.text,
                        apellido: apellidoController.text,
                        email: emailController.text,
                        contrasenia: contraseniaController.text,
                        documento: documentoController.text,
                      ),
                    );
              }
            },
            color: Colors.blue,
            texto: l10n.pageRegisterRegisterButton,
            context: context,
          ),
          SizedBox(
            height: 30.ph,
            child: Center(
              child: Text(
                l10n.pageLoginTextOr,
                style: TextStyle(
                  color: colores.onBackground,
                  fontSize: 14.pf,
                ),
              ),
            ),
          ),
          EscuelasBoton.loginGoogle(
            texto: l10n.pageRegisterRegisterWithGoogle,
            width: 100.wp - 40.pw,
            onTap: () => context.read<BlocRegistro>().add(
                  const BlocRegistroEventoRegistrarseConGoogle(),
                ),
            context: context,
          ),
        ],
      ),
    );
  }
}
