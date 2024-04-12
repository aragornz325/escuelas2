import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/supervision/supervision_asignatura/bloc/bloc_supervision_asignatura.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialogConfirmarEnvioDeEmail}
/// Dialogo de confirmar envio de email a un estudiante
/// {@endtemplate}
class DialogConfirmarEnvioDeEmail extends StatelessWidget {
  /// {@macro DialogConfirmarEnvioDeEmail}
  const DialogConfirmarEnvioDeEmail({
    this.usuario,
    super.key,
  });

  /// usuario a enviar el email y mostrar.
  final Usuario? usuario;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return EscuelasDialog.solicitudDeAccion(
      context: context,
      onTapConfirmar: () => context.read<BlocSupervisionAsignatura>().add(
            BlocSupervisionAsignaturaEnviarEmails(usuario?.id ?? 0),
          ),
      content: Text(
        '¿Enviar calificaciones al correo para ${usuario?.nombre} ${usuario?.apellido}?', //TODO(anyone): L10N
        textAlign: TextAlign.center,
        style: TextStyle(
          color: colores.onBackground,
          fontSize: 16.pf,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
