import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/supervision/supervision_asignatura/bloc/bloc_supervision_asignatura.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialogConfirmarActualizarCalificaciones}
/// Dialog para confirmar actualizar calificaciones de una asignatura.
/// {@endtemplate}
class DialogConfirmarActualizarCalificaciones extends StatelessWidget {
  /// {@macro DialogConfirmarActualizarCalificaciones}
  const DialogConfirmarActualizarCalificaciones({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return EscuelasDialog.solicitudDeAccion(
      context: context,
      onTapConfirmar: () {
        context.read<BlocSupervisionAsignatura>().add(
              const BlocSupervisionAsignaturaActualizarCalificaciones(),
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
              children: const [
                TextSpan(
                    text:
                        '¿Desea actualizar las calificaciones?'), // TODO: i18n
              ],
            ),
          ),
        ],
      ),
    );
  }
}
