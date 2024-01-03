import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/supervision_cursos/bloc/bloc_supervision_cursos.dart';
import 'package:escuelas_flutter/features/supervision_cursos/celular/vista_celular_supervision_cursos.dart';
import 'package:escuelas_flutter/features/supervision_cursos/escritorio/vista_escritorio_supervision_cursos.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template VistaEscritorioSupervisionCursos}
// TODO(anyone): AGREGAR DOCUMENTACION
/// {@endtemplate}
@RoutePage()
class PaginaSupervisionCursos extends StatelessWidget {
  /// {@macro PaginaSupervisionCursos}
  const PaginaSupervisionCursos({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocSupervisionCursos>(
      create: (context) => BlocSupervisionCursos()
        ..add(BlocSupervisionCursosEventoInicializar()),
      child: const FullResponsiveScreen(
        celular: VistaCelularSupervisionCursos(),
        escritorio: VistaEscritorioSupervisionCursos(),
      ),
    );
  }
}
