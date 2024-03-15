import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/bloc_comunicaciones/bloc_comunicaciones.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/menu_comunicaciones/celular/vista_celular_comunicaciones.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/menu_comunicaciones/escritorio/vista_escritorio_comunicaciones.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaMenuComunicaciones}
/// Pagina MenuComunicaciones donde un directivo verifica
/// las MenuComunicaciones en general.
/// {@endtemplate}
@RoutePage()
class PaginaMenuComunicaciones extends StatelessWidget {
  /// {@macro PaginaMenuComunicaciones}
  const PaginaMenuComunicaciones({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocComunicaciones>(
      create: (context) => BlocComunicaciones()
        ..add(
          const BlocComunicacionesEventoInicializar(),
        ),
      child: const FullResponsiveScreen(
        celular: VistaCelularMenuComunicaciones(),
        escritorio: VistaEscritorioMenuComunicaciones(),
      ),
    );
  }
}
