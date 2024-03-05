import 'package:escuelas_commons/config/escuelas_config.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/utilidades/funciones/funciones.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template EscuelasTextfield}
/// Textfield custom del proyecto Escuelas
/// {@endtemplate}
class EscuelasTextfield extends StatefulWidget {
  /// {@macro EscuelasTextfield}
  const EscuelasTextfield({
    required this.controller,
    required this.esPassword,
    this.hintText,
    this.focusNode,
    super.key,
    this.width,
    this.height,
    this.decoration,
    this.keyboardType,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.inputFormatters,
    this.cursorColor,
    this.obscureText,
    this.maxLength,
    this.maxLines,
    this.prefixIcon,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.backgroundColor,
  });

  /// TextFormField de email con su expresion regular.
  factory EscuelasTextfield.email({
    /// Controller del TextFormField eMail
    required TextEditingController controller,

    /// Contexto para traducciones
    required BuildContext context,
  }) {
    final l10n = context.l10n;

    return EscuelasTextfield(
      hintText: l10n.commonMail,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      esPassword: false,
      validator: (email) {
        if (email?.isEmpty ?? false) {
          return l10n.commonCompleteTheField;
        } else if (!ExpresionesRegulares.email.hasMatch(email ?? '')) {
          return l10n.commonEnterAValidEmail;
        }
        return null;
      },
    );
  }

  factory EscuelasTextfield.soloNumero({
    /// Controller del TextFormField eMail
    required TextEditingController controller,

    /// Texto guía
    required String hintText,

    /// Contexto para traducciones
    required BuildContext context,

    /// Funcion onChanged del textfield
    required void Function(String)? onChanged,
  }) {
    final l10n = context.l10n;

    return EscuelasTextfield(
      hintText: hintText,
      controller: controller,
      esPassword: false,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: onChanged,
      validator: (value) {
        if (value?.isEmpty ?? false) {
          return l10n.commonCompleteTheField;
        } else if (!ExpresionesRegulares.numerosUnicamente
            .hasMatch(value ?? '')) {
          return l10n.commonOnlyNumbers;
        }
        return null;
      },
    );
  }

  /// Requiere un texto y un icono para el sufijo.
  factory EscuelasTextfield.conIcono({
    /// Controller del TextFormField eMail
    required TextEditingController controller,

    /// Texto guía
    required String hintText,

    /// Contexto para traducciones
    required BuildContext context,

    /// Funcion onChanged del textfield
    required void Function(String)? onChanged,

    /// Icono de sufijo
    required Widget suffixIcon,
    required ValueChanged<bool> onValidate,
    required List<TextInputFormatter>? inputFormatters,

    /// Texto de error
    String? invalidText,

    /// Color del fondo del campo de texto
    Color? backgroundColor,

    /// Tipo de teclado
    TextInputType? keyboardType,

    /// Ancho del campo de texto.
    double? width,
  }) {
    final l10n = context.l10n;

    return EscuelasTextfield(
      hintText: hintText,
      width: width,
      controller: controller,
      backgroundColor: backgroundColor,
      esPassword: false,
      inputFormatters: inputFormatters ??
          [FilteringTextInputFormatter.deny(RegExp(r'[^a-zA-Z\s]'))],
      onChanged: onChanged,
      keyboardType: keyboardType,
      suffixIcon: suffixIcon,
      validator: (value) {
        if (value?.isEmpty ?? false) {
          onValidate(false);
          return invalidText ?? l10n.commonCompleteTheField;
        }
        onValidate(true);
        return null;
      },
    );
  }

  /// Requiere un texto y un icono para el sufijo con validación de email.
  factory EscuelasTextfield.emailConIcono({
    /// Controller del TextFormField eMail
    required TextEditingController controller,

    /// Texto guía
    required String hintText,

    /// Contexto para traducciones
    required BuildContext context,

    /// Funcion onChanged del textfield
    required void Function(String)? onChanged,

    /// Icono de sufijo
    required Widget suffixIcon,

    /// Funcion de validacion
    required ValueChanged<bool> onValidate,

    /// Color del fondo del campo de texto
    Color? backgroundColor,

    /// Ancho del campo de texto.
    double? width,
  }) {
    final l10n = context.l10n;

    return EscuelasTextfield(
      hintText: hintText,
      width: width,
      controller: controller,
      backgroundColor: backgroundColor,
      esPassword: false,
      onChanged: onChanged,
      suffixIcon: suffixIcon,
      validator: (value) {
        if (value?.isEmpty ?? false) {
          onValidate(false);
          return l10n.commonCompleteTheField;
        } else if (!ExpresionesRegulares.email.hasMatch(value ?? '')) {
          onValidate(false);
          return l10n.commonEnterAValidEmail;
        }
        onValidate(true);
        return null;
      },
    );
  }

  /// Ancho del campo de texto.
  final double? width;

  /// Alto del campo de texto.
  final double? height;

  /// Decoración del textfield
  final InputDecoration? decoration;

  /// Texto interno del TextFormField
  final String? hintText;

  /// Tipo de teclado
  final TextInputType? keyboardType;

  /// Controller del textformfield
  final TextEditingController controller;

  /// Identifica si se trata de un textformfield orientado a contraseñas
  final bool esPassword;

  /// Identifica si el texto debe ser oculto
  final bool? obscureText;

  /// Icono derecho
  final Widget? suffixIcon;

  /// Validators para cada textformfield
  final String? Function(String? value)? validator;

  /// Funcion onChanged
  final void Function(String)? onChanged;

  /// Formateadores de texto para ponerle restricciones a el usuario
  /// sobre que tipo de caracteres puede completar en el campo de texto.
  final List<TextInputFormatter>? inputFormatters;

  /// Color del cursor al estar con el foco puesto
  final Color? cursorColor;

  /// Caracteres maximos de longitud
  final int? maxLength;

  /// Lineas maximas a ingresar
  final int? maxLines;

  /// Focus Node del textfield
  final FocusNode? focusNode;

  /// Icono de prefijo
  final Widget? prefixIcon;

  /// Color del fondo del campo de texto
  final Color? backgroundColor;

  /// Al completar el textfield ejecuta esa accion.
  final void Function()? onEditingComplete;

  /// Al apretar siguiente en el teclado ejecuta esa accion.
  final void Function(String)? onFieldSubmitted;

  @override
  State<EscuelasTextfield> createState() => _EscuelasTextfieldState();
}

class _EscuelasTextfieldState extends State<EscuelasTextfield> {
  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        onEditingComplete: widget.onEditingComplete,
        onFieldSubmitted: widget.onFieldSubmitted,
        focusNode: widget.focusNode,
        controller: widget.controller,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        inputFormatters: widget.inputFormatters,
        obscureText: widget.obscureText ?? false,
        cursorColor: widget.cursorColor ?? colores.primary,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        style: TextStyle(color: colores.primary),
        decoration: widget.decoration ??
            InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15.sw),
              filled: true,
              fillColor: widget.backgroundColor ?? colores.tertiary,
              hintText: widget.hintText ?? '',
              hintStyle: TextStyle(
                fontSize: 16.pf,
                color: colores.onSecondary,
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
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
            ),
        validator: widget.validator,
        onChanged: (value) => setState(() => widget.onChanged?.call(value)),
      ),
    );
  }
}

/// {@template EscuelasTextFieldPassword}
/// Textfield custom de Escuelas de uso exclusivo para contraseñas
/// {@endtemplate}
class EscuelasTextFieldPassword extends StatefulWidget {
  /// {@macro EscuelasTextFieldPassword}
  const EscuelasTextFieldPassword({
    required this.controller,
    required this.onValidate,
    this.validator,
    this.hintText,
    this.onChanged,
    this.backgroundColor,
    super.key,
  });

  /// Controller del TextFormField eMail
  final TextEditingController controller;

  /// Validator para contraseñas
  final String? Function(String? value)? validator;

  final ValueChanged<bool> onValidate;

  /// Texto interno del TextFormField
  final String? hintText;

  final Color? backgroundColor;

  /// Funcion onChanged del textfield
  final void Function(String)? onChanged;
  @override
  State<EscuelasTextFieldPassword> createState() =>
      _EscuelasTextFieldPasswordState();
}

class _EscuelasTextFieldPasswordState extends State<EscuelasTextFieldPassword> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final colores = context.colores;

    return EscuelasTextfield(
      hintText: widget.hintText ?? l10n.commonPassword,
      controller: widget.controller,
      esPassword: true,
      obscureText: _obscureText,
      maxLines: 1,
      onChanged: (value) {
        setState(() {});
        widget.onChanged?.call(value);
      },
      backgroundColor: widget.backgroundColor,
      suffixIcon: IconButton(
        icon: _obscureText
            ? Icon(
                Icons.visibility_off_outlined,
                color: colores.onSecondary,
                size: 25.pw,
              )
            : Icon(
                Icons.visibility_outlined,
                color: colores.onSecondary,
                size: 25.pw,
              ),
        onPressed: () => setState(() => _obscureText = !_obscureText),
      ),
      validator: (value) {
        if (value?.isEmpty ?? false) {
          widget.onValidate(false);
          return l10n.pageRegisterInvalidPassword;
        }

        if ((value?.length ?? 0) < 12) {
          widget.onValidate(false);
          return l10n.pageRegisterMinimucCaractersForPassword(
            const RedemptorisMissioConfigs().minimoDeCaracteresPassword,
          );
        }

        if (widget.validator != null) {
          return widget.validator?.call(value);
        }

        widget.onValidate(true);
        return null;
      },
    );
  }
}
