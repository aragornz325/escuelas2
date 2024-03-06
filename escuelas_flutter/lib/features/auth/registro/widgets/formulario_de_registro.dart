import 'package:escuelas_commons/escuelas_commons.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/auth/registro/bloc/bloc_registro.dart';
import 'package:escuelas_flutter/features/auth/registro/widgets/widgets.dart';
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
  final TextEditingController _nombreController = TextEditingController();

  final TextEditingController _apellidoController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _contraseniaController = TextEditingController();

  final TextEditingController _confirmarContraseniaController =
      TextEditingController();

  final TextEditingController _documentoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool get lasContraseniasCoinciden =>
      _contraseniaController.text.isNotEmpty &&
      _confirmarContraseniaController.text.isNotEmpty &&
      _contraseniaController.text == _confirmarContraseniaController.text &&
      _confirmarContraseniaController.text.length >= 12 &&
      _contraseniaController.text.length >= 12;

  bool get lasContraseniasNoCoinciden =>
      _contraseniaController.text.isNotEmpty &&
      _confirmarContraseniaController.text.isNotEmpty &&
      _contraseniaController.text == _confirmarContraseniaController.text &&
      _confirmarContraseniaController.text.length !=
          _contraseniaController.text.length;

  bool get lasContraseniasContienen12Caracteres =>
      _contraseniaController.text.isNotEmpty &&
      _confirmarContraseniaController.text.isNotEmpty &&
      _contraseniaController.text.length >= 12 &&
      _confirmarContraseniaController.text.length >= 12;

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _emailController.dispose();
    _contraseniaController.dispose();
    _confirmarContraseniaController.dispose();

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
                  controller: _nombreController,
                  onChanged: () => setState(() {}),
                  hintText: l10n.commonName,
                  icon: Icons.person_outline,
                ),
              ),
              SizedBox(width: 15.pw),
              Flexible(
                child: TextfieldConValidacion(
                  controller: _apellidoController,
                  onChanged: () => setState(() {}),
                  hintText: l10n.commonLastname,
                  icon: Icons.person_outline,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.ph),
          TextfieldConValidacionMail(
            controller: _emailController,
            onChanged: () => setState(() {}),
            hintText: l10n.commonEmail,
            icon: Icons.email_outlined,
          ),
          SizedBox(height: 15.ph),
          EscuelasTextFieldPassword(
            onValidate: (value) => contraseniaValido = value,
            controller: _contraseniaController,
            hintText: l10n.commonPassword,
            onChanged: (value) => setState(() {}),
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
                    l10n.pageRegisterMinimumCaractersForPassword(
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
            controller: _confirmarContraseniaController,
            hintText: l10n.pageRegisterConfirmPassword,
            onChanged: (value) => setState(() {}),
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
          if (lasContraseniasNoCoinciden)
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
            controller: _documentoController,
            onChanged: () => setState(() {}),
            hintText: l10n.commonDNI,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            icon: Icons.credit_card_outlined,
          ),
          SizedBox(height: 45.ph),
          EscuelasBoton.texto(
            estaHabilitado: _nombreController.text.isNotEmpty &&
                _apellidoController.text.isNotEmpty &&
                _emailController.text.isNotEmpty &&
                _contraseniaController.text.isNotEmpty &&
                _confirmarContraseniaController.text.isNotEmpty &&
                _documentoController.text.isNotEmpty,
            width: 100.wp - 40.pw,
            height: 40.ph,
            backgroundColorDeshabilitado: colores.botonRegistroDeshabilitado,
            onTap: () {
              setState(() {});
              if (_formKey.currentState?.validate() ?? false) {
                context.read<BlocRegistro>().add(
                      BlocRegistroEventoRegistrarUsuario(
                        nombre: _nombreController.text,
                        apellido: _apellidoController.text,
                        email: _emailController.text,
                        contrasenia: _contraseniaController.text,
                        documento: _documentoController.text,
                      ),
                    );
              }
            },
            color: colores.primary,
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
