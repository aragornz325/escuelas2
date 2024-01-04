import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dropdown_popup.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template FormularioDropdown}
/// Dropdown para seleccionar el año/materia
/// {@endtemplate}
class FormularioDropdown extends StatelessWidget {
  /// {@macro FormularioDropdown}
  const FormularioDropdown({
    required this.lista,
    required this.listaOpcionesSeleccionadas,
    this.opcionesPreSeleccionadas = const [],
    super.key,
  });

  /// lista de opciones a mostrar
  final List<PopupOption> lista;

  /// Devuelve la lista de opciones elegidas
  final ValueChanged<List<PopupOption>> listaOpcionesSeleccionadas;

  /// Opciones inicialmente seleccionadas
  final List<PopupOption> opcionesPreSeleccionadas;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return EscuelasDropdownPopup(
      width: 285.pw,
      hintText: l10n.pageKycDropdownTitle,
      list: lista,
      onChanged: listaOpcionesSeleccionadas,
      initiallySelected: opcionesPreSeleccionadas,
    );
  }
}
