// ignore_for_file: lines_longer_than_80_chars

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/pendientes/bloc_comunicaciones_pendientes/bloc_comunicaciones_pendientes.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template DialogAprobarNotificacion}
/// Dialogo para confirmar la aprobacion de una notificacion
/// {@endtemplate}
class DialogAprobarNotificacion extends StatelessWidget {
  /// {@macro DialogAprobarNotificacion}
  const DialogAprobarNotificacion({
    required this.idSolicitud,
    super.key,
  });

  final int idSolicitud;

  /// Muestra dialog que indica al usuario que la notificacion fue aprobada con
  /// exito.
  void _onConfirmarExito(BuildContext context) {
    Navigator.of(context).pop();
    context.read<BlocComunicacionesPendientes>().add(
          BlocComunicacionesPendientesEventoEnviarEstadoNotificaciones(
            estadoSolicitud: EstadoDeSolicitud.aprobado,
            solicitudId: idSolicitud,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return EscuelasDialog.solicitudDeAccion(
      estaHabilitado: true,
      titulo: l10n.commonWarning.toUpperCase(),
      context: context,
      onTapConfirmar: () {
        _onConfirmarExito(context);
      },
      content: Text(
        textAlign: TextAlign.center,
        l10n.pagePendingCommunicationsDialogDescription,
      ),
    );
  }
}
