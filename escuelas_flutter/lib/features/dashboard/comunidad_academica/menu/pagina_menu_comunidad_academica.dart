import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/menu/celular/vista_celular_menu_comunidad_academica.dart';
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/menu/escritorio/vista_escritorio_menu_comunidad_academica.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';

/// {@template PaginaMenuComunidadAcademica}
/// Pagina de la comunidad academica donde se elige la categoria a mostrar
/// {@endtemplate}
@RoutePage()
class PaginaMenuComunidadAcademica extends StatelessWidget {
  /// {@macro PaginaMenuComunidadAcademica}
  const PaginaMenuComunidadAcademica({super.key});

  @override
  Widget build(BuildContext context) {
    return const FullResponsiveScreen(
      celular: VistaCelularMenuComunidadAcademica(),
      escritorio: VistaEscritorioMenuComunidadAcademica(),
    );
  }
}
