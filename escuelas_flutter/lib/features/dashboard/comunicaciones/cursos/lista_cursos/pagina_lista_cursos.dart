import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/lista_cursos/bloc/bloc_comunicaciones_lista_cursos.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/lista_cursos/celular/vista_celular_comunicaciones_lista_cursos.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/lista_cursos/escritorio/vista_escritorio_comunicaciones_lista_cursos.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaComunicacionesListaCursos}
/// Pagina de 'Comunicaciones lista de cursos' donde aparece la lista de cursos
/// y sus alumnos de cada.
/// {@endtemplate}
@RoutePage()
class PaginaComunicacionesListaCursos extends StatelessWidget {
  /// {@macro PaginaComunicacionesListaCursos}
  const PaginaComunicacionesListaCursos({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocComunicacionesListaCursos>(
      create: (context) => BlocComunicacionesListaCursos()
        ..add(const BlocComunicacionesListaCursosEventoInicializar()),
      child: const FullResponsiveScreen(
        celular: VistaCelularComunicacionesListaCursos(),
        escritorio: VistaEscritorioComunicacionesListaCursos(),
      ),
    );
  }
}
