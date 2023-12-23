import 'package:escuelas_flutter/features/asignacion_de_roles/widgets/widgets.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';

class PaginaAsignacionDeRoles extends StatelessWidget {
  const PaginaAsignacionDeRoles({super.key});

  @override
  Widget build(BuildContext context) {
    return const FullResponsiveScreen(
      celular: VistaCelularAsignacionDeRoles(),
      escritorio: VistaEscritorioAsignacionDeRoles(),
    );
  }
}
