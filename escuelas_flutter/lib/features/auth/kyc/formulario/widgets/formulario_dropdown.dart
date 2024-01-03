import 'package:escuelas_flutter/widgets/escuelas_dropdown_popup.dart';
import 'package:flutter/material.dart';

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
    // TODO(Gon): Hacerlo parecido al diseño (todavia no hay 23/12/23)
    return EscuelasDropdownPopup(
      list: lista,
      onChanged: listaOpcionesSeleccionadas,
      initiallySelected: opcionesPreSeleccionadas,
    );
  }
}
