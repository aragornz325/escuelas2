import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// {@template TextfieldConValidacion}
/// Textfield con validaciones.
/// {@endtemplate}
class TextfieldConValidacion extends StatefulWidget {
  /// {@macro TextfieldConValidacion}
  const TextfieldConValidacion({
    required this.onChanged,
    required this.hintText,
    required this.controller,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
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

  /// Tipo de teclado que se muestra.
  final TextInputType? keyboardType;

  /// Formateadores que se aplican al texto.
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<TextfieldConValidacion> createState() => _TextfieldConValidacionState();
}

class _TextfieldConValidacionState extends State<TextfieldConValidacion> {
  bool? valido;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return EscuelasTextfield.conIcono(
      onValidate: (value) => valido = value,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      hintText: widget.hintText,
      context: context,
      width: widget.width,
      onChanged: (value) => setState(() => widget.onChanged?.call()),
      suffixIcon: Icon(
        valido == null
            ? widget.icon
            : valido ?? false
                ? Icons.check_circle
                : Icons.error_outline,
        color: valido == null
            ? colores.onSecondary
            : valido ?? true
                ? colores.verdeConfirmar
                : colores.error,
      ),
      backgroundColor:
          valido ?? true ? colores.tertiary : colores.error.withOpacity(.3),
    );
  }
}
