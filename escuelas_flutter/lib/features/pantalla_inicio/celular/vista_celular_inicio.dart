import 'package:escuelas_flutter/features/pantalla_inicio/widgets/menu_opciones_permisos.dart';
import 'package:flutter/material.dart';

/// {@template VistaCelularInicio}
/// Vista inicial de celular en la sección de Inicio,
/// donde se encuentran las distintas opciones de redireccion
/// de acuerdo a los permisos del usuario.
/// {@endtemplate}

class VistaCelularInicio extends StatelessWidget {
  /// {@macro VistaCelularInicio}
  const VistaCelularInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return const MenuOpcionesPermisos();
  }
}
