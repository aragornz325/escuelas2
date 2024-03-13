import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// {@template TextfieldConValidacionMail}
/// Textfield con validaciones y tiene validacion de email.
/// {@endtemplate}
class TextfieldConValidacionMail extends StatefulWidget {
  const TextfieldConValidacionMail({
    required this.onChanged,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.width,
    super.key,
  });

  /// Funcion que se ejecuta cuando el texto cambia.
  final VoidCallback? onChanged;

  /// Texto que se muestra como placeholder.
  final String hintText;

  /// Ancho del textfield.
  final double? width;

  /// Icono que se muestra al final del textfield.
  final IconData icon;

  /// Controlador del textfield.
  final TextEditingController controller;

  @override
  State<TextfieldConValidacionMail> createState() =>
      _TextfieldConValidacionMailState();
}

class _TextfieldConValidacionMailState
    extends State<TextfieldConValidacionMail> {
  bool? valido;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return EscuelasTextfield.emailConIcono(
      onValidate: (value) => valido = value,
      controller: widget.controller,
      hintText: widget.hintText,
      context: context,
      onChanged: (value) => setState(() => widget.onChanged?.call()),
      suffixIcon: Icon(
        valido == null
            ? widget.icon
            : valido ?? false
                ? Icons.check_circle
                : Icons.error_outline,
        color: valido == null
            ? colores.onSecondary
            : valido ?? false
                ? colores.verdeConfirmar
                : colores.error,
      ),
      backgroundColor:
          valido ?? true ? colores.tertiary : colores.error.withOpacity(.3),
    );
  }
}
