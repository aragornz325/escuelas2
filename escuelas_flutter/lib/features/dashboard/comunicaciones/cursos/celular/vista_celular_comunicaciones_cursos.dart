import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/bloc/bloc_comunicaciones_cursos.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularComunicacionesCursos}
/// Vista de 'Comunicaciones de cursos' para celulares.
/// {@endtemplate}
class VistaCelularComunicacionesCursos extends StatelessWidget {
  /// {@macro VistaCelularComunicacionesCursos}
  const VistaCelularComunicacionesCursos({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return BlocBuilder<BlocComunicacionesCursos,
        BlocComunicacionesCursosEstado>(
      builder: (context, state) {
        if (state is BlocComunicacionesCursosEstadoCargando) {
          const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state.comisiones.isEmpty) {
          return Expanded(
            child: Center(
              child: Text(
                l10n.pageComissionSupervisionNoComissions,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.pf,
                  color: colores.onBackground,
                ),
              ),
            ),
          );
        }

        return ListaComisionesConAlumnos(
          comisiones: state.comisiones,
        );
      },
    );
  }
}
