import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/utilidades/funciones/funciones.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@templates EscuelasTextfield}
/// Textfield custom del proyecto Escuelas
/// {@endtemplates}
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
    this.fontHintText,
    this.tamanoController,
  });

  /// TextFormField de email con su expresion regular.
  factory EscuelasTextfield.email({
    /// Controller del TextFormField eMail
    required TextEditingController controller,

    /// Contexto para traducciones
    required BuildContext context,

    /// Texto interno
    String? hintText,

    /// Ancho del textfield
    double? width,

    /// Alto del textfield
    double? height,

    /// tamaño de la fuente del hinttext del textfield
    double? fontHintText,

    /// Define si el textfield tiene borde
    bool tieneBorde = false,

    /// Funcion onChanged del textfield
    void Function(String)? onChanged,
  }) {
    final l10n = context.l10n;
    final colores = context.colores;

    return EscuelasTextfield(
      width: width ?? 302.pw,
      height: height ?? 40.ph,
      fontHintText: fontHintText ?? 16.pf,
      hintText: hintText ?? l10n.commonMail,
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
      onChanged: onChanged,
      decoration: tieneBorde
          ? InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(height: 1.7, fontSize: 8.pf),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.sw),
                borderSide: BorderSide(color: colores.rojoTED),
              ),
            )
          : null,
    );
  }

  factory EscuelasTextfield.soloNumero({
    /// Controller del TextFormField de numeros
    required TextEditingController controller,

    /// Texto guía
    required String hintText,

    /// Contexto para traducciones
    required BuildContext context,

    /// Funcion onChanged del textfield
    required void Function(String)? onChanged,

    /// Ancho del textfield
    double? width,

    /// Alto del textfield
    double? height,

    /// tamaño de la fuente del hinttext del textfield
    double? fontHintText,

    /// Define si el textfield tiene borde
    bool tieneBorde = false,
  }) {
    final l10n = context.l10n;

    return EscuelasTextfield(
      width: width ?? 302.pw,
      height: height ?? 40.ph,
      fontHintText: fontHintText ?? 16.pf,
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
      decoration: tieneBorde
          ? InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(height: 1.7, fontSize: 8.pf),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.sw),
              ),
            )
          : null,
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

  final double? fontHintText;

  /// Icono de prefijo
  final IconData? prefixIcon;

  final double? tamanoController;

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
      height: widget.height ?? max(40.ph, 40.sh),
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
        style: TextStyle(
          color: colores.primary,
          fontSize: widget.tamanoController ?? 16.pf,
        ),
        decoration: widget.decoration ??
            InputDecoration(
              prefixIcon: Icon(widget.prefixIcon),
              contentPadding: EdgeInsets.symmetric(horizontal: 15.sw),
              filled: true,
              fillColor: colores.tertiary,
              hintText: widget.hintText ?? '',
              hintStyle: TextStyle(
                fontSize: widget.fontHintText ?? 16.pf,
                color: colores.onSecondary,
                height: 1,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.sw),
                borderSide: BorderSide.none,
              ),
              errorStyle: TextStyle(color: colores.error),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colores.error),
              ),
              suffixIcon: widget.esPassword ? widget.suffixIcon : null,
            ),
        validator: widget.validator,
        onChanged: (value) => setState(() => widget.onChanged?.call(value)),
      ),
    );
  }
}

/// {@templates EscuelasTextFieldPassword}
/// Textfield custom de Escuelas de uso exclusivo para contraseñas
/// {endtemplate}
class EscuelasTextFieldPassword extends StatefulWidget {
  /// {@macro EscuelasTextFieldPassword}
  const EscuelasTextFieldPassword({
    required this.controller,
    super.key,
    this.validator,
    this.hintText,
    this.onChanged,
  });

  /// Controller del TextFormField eMail
  final TextEditingController controller;

  /// Validator para contraseñas
  final String? Function(String? value)? validator;

  /// Texto interno del TextFormField
  final String? hintText;

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
      suffixIcon: Padding(
        padding: EdgeInsets.only(right: 10.sw),
        child: IconButton(
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
      ),
      validator: (value) {
        if (value?.isEmpty ?? false) {
          return l10n.commonCompleteTheField;
        }

        if (widget.validator != null) {
          return widget.validator?.call(value);
        }

        return null;
      },
    );
  }
}
