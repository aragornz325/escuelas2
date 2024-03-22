import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_textfield.dart';
import 'package:flutter/material.dart';

/// {@template TextfieldConValidacion}
/// Textfield con validaciones.
/// {@endtemplate}
class TextfieldNumerosConValidacion extends StatefulWidget {
  /// {@macro TextfieldConValidacion}
  const TextfieldNumerosConValidacion({
    required this.onChanged,
    required this.hintText,
    required this.controller,
    required this.icon,
    super.key,
  });

  /// Funcion que se ejecuta cuando el texto cambia.
  final VoidCallback? onChanged;

  /// Texto que se muestra como placeholder.
  final String hintText;

  /// Icono que se muestra al final del textfield.
  final IconData icon;

  /// Controlador del textfield.
  final TextEditingController controller;

  @override
  State<TextfieldNumerosConValidacion> createState() =>
      _TextfieldNumerosConValidacionState();
}

class _TextfieldNumerosConValidacionState
    extends State<TextfieldNumerosConValidacion> {
  bool? valido;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return EscuelasTextfield.soloNumerosConIcono(
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
            : valido ?? true
                ? colores.verdeConfirmar
                : colores.error,
      ),
      backgroundColor:
          valido ?? true ? colores.tertiary : colores.error.withOpacity(.3),
    );
  }
}
