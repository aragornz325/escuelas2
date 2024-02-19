import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/lista_cursos/mis_cursos/bloc/bloc_mis_cursos.dart';
import 'package:escuelas_flutter/features/dashboard/lista_cursos/mis_cursos/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularDirectivoCursos}
/// Vista para celulares del directivo de cursos.
/// donde el directivo puede ver todos las comisiones de la institucion con sus
/// asignatura y navegar a dicha vista.
/// {@endtemplate}
class VistaCelularDirectivoCursos extends StatelessWidget {
  /// {@macro VistaCelularDirectivoCursos}
  const VistaCelularDirectivoCursos({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return BlocBuilder<BlocMisCursos, BlocMisCursosEstado>(
      builder: (context, state) {
        if (state is BlocMisCursosEstadoCargando) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.comisionesConAsignaturas.isEmpty) {
          return Center(
            child: Text(
              l10n.pageCoursesThereAreNoCourses,
              style: TextStyle(
                fontSize: 16.pf,
                fontWeight: FontWeight.w700,
                color: colores.onBackground,
              ),
            ),
          );
        }
        return Expanded(
          child: ListaDeComisionesConSusAsignaturas(
            comisiones: state.comisionesConAsignaturas,
          ),
        );
      },
    );
  }
}
