import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
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
    required this.hintText,
    required this.controller,
    required this.esPassword,
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
      esPassword: false,
      validator: (email) {
        if (email?.isEmpty ?? false) {
          return l10n.commonCompleteTheField;
        } else if (!ExpresionRegular.emailRegExp.hasMatch(email ?? '')) {
          return l10n.commonEnterAValidEmail;
        }
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
  final String hintText;

  /// Tipo de teclado
  final TextInputType? keyboardType;

  /// Controller del textformfield
  final TextEditingController controller;

  /// Identifica si se trata de un textformfield orientado a contraseñas
  final bool esPassword;

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

  @override
  State<EscuelasTextfield> createState() => _EscuelasTextfieldState();
}

class _EscuelasTextfieldState extends State<EscuelasTextfield> {
  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return SizedBox(
      width: widget.width?.sw ?? 300.sw,
      height: widget.height ?? max(40.ph, 40.sh),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType ?? TextInputType.none,
        inputFormatters: widget.inputFormatters,
        cursorColor: widget.cursorColor ?? colores.primary,
        style: TextStyle(color: colores.primary),
        decoration: widget.decoration ??
            InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15.sw),
              filled: true,
              fillColor: colores.background,
              hintText: widget.hintText,
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
              ),
              suffixIcon: widget.esPassword ? widget.suffixIcon : null,
            ),
        validator: widget.validator,
        onChanged: (value) {
          setState(() {
            widget.onChanged?.call(value);
          });
        },
      ),
    );
  }
}
