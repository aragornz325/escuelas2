import 'package:escuelas_flutter/widgets/escuelas_dropdown_popup.dart';
import 'package:flutter/material.dart';

class KycDropdown extends StatelessWidget {
  const KycDropdown({
    required this.lista,
    required this.value,
    super.key,
  });
  final List<PopupOption> lista;
  final ValueChanged<List<PopupOption>> value;

  @override
  Widget build(BuildContext context) {
    return EscuelasDropdownPopup(
      list: lista,
      onChanged: value,
    );
  }
}
