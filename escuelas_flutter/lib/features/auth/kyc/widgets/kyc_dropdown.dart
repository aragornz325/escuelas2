import 'package:escuelas_flutter/widgets/escuelas_dropdown_popup.dart';
import 'package:flutter/material.dart';

/// {@template KycDropdown}
/// Dropdown para seleccionar el año/materia
/// {@endtemplate}
class KycDropdown extends StatelessWidget {
  /// {@macro KycDropdown}
  const KycDropdown({
    required this.lista,
    required this.listaOpcionesSeleccionadas,
    super.key,
  });

  /// lista de opciones a mostrar
  final List<PopupOption> lista;

  /// Devuelve la lista de opciones elegidas
  final ValueChanged<List<PopupOption>> listaOpcionesSeleccionadas;

  @override
  Widget build(BuildContext context) {
    // TODO(Gon): Hacerlo parecido al diseño (todavia no hay)
    return EscuelasDropdownPopup(
      list: lista,
      onChanged: listaOpcionesSeleccionadas,
    );
  }
}
