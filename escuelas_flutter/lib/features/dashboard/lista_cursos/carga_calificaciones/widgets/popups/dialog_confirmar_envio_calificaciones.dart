import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/lista_cursos/carga_calificaciones/bloc/bloc_carga_calificaciones.dart';
import 'package:escuelas_flutter/features/dashboard/supervision/supervision_asignatura/bloc/bloc_supervision_asignatura.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialogConfirmarActualizarCalificaciones}
/// Dialog para confirmar actualizar calificaciones de una asignatura.
/// {@endtemplate}
class DialogConfirmarEnvioDeCalificaciones extends StatelessWidget {
  /// {@macro DialogConfirmarActualizarCalificaciones}
  const DialogConfirmarEnvioDeCalificaciones(
      {super.key,
      required this.totalEvaluacionesDefinidas,
      required this.totalAlumnosAEvaluar});

  final int totalEvaluacionesDefinidas;
  final int totalAlumnosAEvaluar;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    final l10n = context.l10n;

    return EscuelasDialog.solicitudDeAccion(
      context: context,
      onTapConfirmar: () {
        context.read<BlocCargaCalificaciones>().add(
              const BlocCargaCalificacionesEventoEnviarCalificaciones(
                  confirmadoRevision: true),
            );
        Navigator.of(context).pop();
      },
      content: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                color: colores.onBackground,
                fontSize: 16.pf,
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                  text: l10n.dialogGradesConfirmation(
                    totalEvaluacionesDefinidas,
                    totalAlumnosAEvaluar,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
