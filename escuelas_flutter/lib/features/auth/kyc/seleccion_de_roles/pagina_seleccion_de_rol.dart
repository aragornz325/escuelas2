import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/features/auth/kyc/seleccion_de_roles/celular/vista_celular_seleccion_de_rol.dart';
import 'package:escuelas_flutter/features/auth/kyc/seleccion_de_roles/escritorio/vista_escritorio_seleccion_de_rol.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaSeleccionDeRol}
/// Pagina de la pantalla Asignación de Roles donde el usuario elige que rol
/// quiere solicitar.
/// {@endtemplate}
@RoutePage()
class PaginaSeleccionDeRol extends StatelessWidget {
  /// {@macro PaginaSeleccionDeRol}
  const PaginaSeleccionDeRol({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocKyc(),
      child: const FullResponsiveScreen(
        celular: VistaCelularSeleccionDeRol(),
        escritorio: VistaEscritorioSeleccionDeRol(),
      ),
    );
  }
}
