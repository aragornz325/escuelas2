import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/mis_cursos/bloc/bloc_mis_cursos.dart';
import 'package:escuelas_flutter/features/mis_cursos/celular/vista_celular_mis_cursos.dart';
import 'package:escuelas_flutter/features/mis_cursos/escritorio/vista_escritorio_mis_cursos.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template VistaEscritorioMisCursos}
/// Pagina para que el usuario pueda ver sus materias asignadas ordenadas por
/// curso
/// {@endtemplate}
@RoutePage()
class PaginaMisCursos extends StatelessWidget {
  /// {@macro PaginaMisCursos}
  const PaginaMisCursos({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BlocMisCursos()..add(const BlocMisCursosEventoInicializar()),
      child: const FullResponsiveScreen(
        celular: VistaCelularMisCursos(),
        escritorio: VistaEscritorioMisCursos(),
      ),
    );
  }
}
