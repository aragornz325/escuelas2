import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/bloc/bloc_comunicaciones_cursos.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/celular/vista_celular_comunicaciones_cursos.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/escritorio/vista_escritorio_comunicaciones_cursos.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaComunicacionesCursos}
/// Pagina de 'Comunicaciones de cursos' donde aparece la lista de cursos y sus
/// alumnos.
/// {@endtemplate}
@RoutePage()
class PaginaComunicacionesCursos extends StatelessWidget {
  /// {@macro PaginaComunicacionesCursos}
  const PaginaComunicacionesCursos({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocComunicacionesCursos>(
      create: (context) => BlocComunicacionesCursos()
        ..add(const BlocComunicacionesCursosEventoInicializar()),
      child: const FullResponsiveScreen(
        celular: VistaCelularComunicacionesCursos(),
        escritorio: VistaEscritorioComunicacionesCursos(),
      ),
    );
  }
}
