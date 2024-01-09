import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template FormularioDropdown}
/// Dropdown para seleccionar el año/materia
/// {@endtemplate}
class FormularioDropdown extends StatefulWidget {
  /// {@macro FormularioDropdown}
  const FormularioDropdown({
    required this.lista,
    required this.listaOpcionesSeleccionadas,
    super.key,
  });

  /// lista de opciones a mostrar
  final List<EscuelasDropdownOption<int>> lista;

  /// Devuelve la lista de opciones elegidas
  final ValueChanged<EscuelasDropdownOption<int>> listaOpcionesSeleccionadas;

  @override
  State<FormularioDropdown> createState() => _FormularioDropdownState();
}

class _FormularioDropdownState extends State<FormularioDropdown> {
  /// Texto del dropdown, puede ser el valor seleccionado o el texto por defecto
  String? valueText;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return EscuelasDropdown(
      width: 285.pw,
      isValid: true,
      items: widget.lista,
      valueText: valueText ?? '',
      hintText: valueText ?? l10n.pageKycDropdownTitle,
      onChanged: (value) {
        widget.listaOpcionesSeleccionadas(
          [widget.lista.firstWhere((e) => e.value == value)].first,
        );
        setState(
          () => valueText =
              widget.lista.firstWhere((e) => e.value == value).title,
        );
      },
    );
  }
}
