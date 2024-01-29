import 'package:escuelas_flutter/features/dashboard/pantalla_inicio/widgets/menu_opciones_permisos.dart';

import 'package:flutter/material.dart';

/// {@template VistaEscritorioInicio}
/// Vista inicial de Escritorio en la sección de Inicio,
/// donde se encuentran las distintas opciones de redireccion
/// de acuerdo a los permisos del usuario.
/// {@endtemplate}
class VistaEscritorioInicio extends StatelessWidget {
  /// {@macro VistaEscritorioInicio}
  const VistaEscritorioInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return const MenuOpcionesPermisos();
  }
}
