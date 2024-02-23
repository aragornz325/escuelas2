import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/menu_comunicaciones/celular/vista_celular_comunicaciones.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/menu_comunicaciones/escritorio/vista_escritorio_comunicaciones.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';

/// {@template PaginaComunicacionesCursos}
// TODO(ANYONE): Add docu
/// {@endtemplate}
@RoutePage()
class PaginaComunicacionesCursos extends StatelessWidget {
  /// {@macro PaginaComunicacionesCursos}
  const PaginaComunicacionesCursos({super.key});

  @override
  Widget build(BuildContext context) {
    return const FullResponsiveScreen(
      // TODO(ANYONE): Cambiar vistas
      celular: VistaCelularMenuComunicaciones(),
      escritorio: VistaEscritorioMenuComunicaciones(),
    );
  }
}
