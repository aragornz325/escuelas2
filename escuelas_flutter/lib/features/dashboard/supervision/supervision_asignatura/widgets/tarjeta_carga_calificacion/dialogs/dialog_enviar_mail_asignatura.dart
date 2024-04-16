import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/supervision/supervision_asignatura/bloc/bloc_supervision_asignatura.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialogEnviarEmailAsignatura}
/// Dialog para confirmar enviar email a todos los alumnos de una asignatura.
/// {@endtemplate}
class DialogEnviarEmailAsignatura extends StatelessWidget {
  /// {@macro DialogEnviarEmailAsignatura}
  const DialogEnviarEmailAsignatura({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return EscuelasDialog.confirmar(
      onTapConfirmar: () {
        context
            .read<BlocSupervisionAsignatura>()
            .add(const BlocSupervisionAsignaturaEnviarEmailsAsingatura());
        Navigator.of(context).pop();
      },
      content: Text(
        // TODO: L10N
        'Quieres enviar un email a todos los alumnos de esta asignatura?',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: colores.onSecondary,
          fontSize: 16.pf,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
