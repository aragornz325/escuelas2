import 'package:escuelas_flutter/widgets/escuelas_dropdown_popup.dart';
import 'package:flutter/material.dart';

class KycDropdown extends StatelessWidget {
  const KycDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return EscuelasDropdownPopup(
      list: [],
      onChanged: (value) {},
    );
  }
}
