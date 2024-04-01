import 'package:escuelas_flutter/features/dashboard/pantalla_inicio/widgets/menu_opciones_permisos.dart';
import 'package:flutter/material.dart';

/// {@template VistaCelularInicio}
/// Vista inicial de celular en la sección de Inicio,
/// donde se encuentran las distintas opciones de redireccion
/// de acuerdo a los permisos del usuario.
/// {@endtemplate}

class VistaCelularInicio extends StatefulWidget {
  /// {@macro VistaCelularInicio}
  const VistaCelularInicio({super.key});

  @override
  State<VistaCelularInicio> createState() => _VistaCelularInicioState();
}

class _VistaCelularInicioState extends State<VistaCelularInicio> {
  @override
  void initState() {
    super.initState();
    // TODO: implementar si el usuario necesita cambiar la contraseña
  }

  @override
  Widget build(BuildContext context) {
    return const MenuOpcionesPermisos();
  }
}
