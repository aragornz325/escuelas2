import 'package:escuelas_flutter/features/auth/kyc/widgets/kyc_dropdown.dart';
import 'package:flutter/material.dart';

class PreguntaYRespuesta extends StatelessWidget {
  const PreguntaYRespuesta({
    required this.titulo,
    super.key,
  });
  final String titulo;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(titulo),
        const KycDropdown(),
      ],
    );
  }
}
