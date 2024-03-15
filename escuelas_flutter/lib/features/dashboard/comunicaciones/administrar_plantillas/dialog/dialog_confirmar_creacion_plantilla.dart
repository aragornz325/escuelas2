import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/bloc/bloc_administrar_plantillas.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template DialogConfirmarCreacionPlantilla}
/// Dialogo para confirmar la creacion de una nueva plantilla
/// {@endtemplate}
class DialogConfirmarCreacionPlantilla extends StatelessWidget {
  /// {@macro DialogConfirmarCreacionPlantilla}
  const DialogConfirmarCreacionPlantilla({
    required this.tituloPlantilla,
    required this.descripcionPlantilla,
    required this.necesitaSupervision,
    super.key,
  });

  /// titulo de la plantilla
  final String tituloPlantilla;

  /// Descripcion de la plantilla
  final String descripcionPlantilla;

  /// Verifica si Necesita Supervision
  final bool necesitaSupervision;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return EscuelasDialog.solicitudDeAccion(
      estaHabilitado: true,
      titulo: l10n.commonAttention,
      context: context,
      onTapConfirmar: () {
        context.read<BlocAdministrarPlantillas>().add(
              BlocAdministrarPlantillasEventoAgregarPlantilla(
                nombrePlantilla: tituloPlantilla,
                descripcionPlantilla: descripcionPlantilla,
                necesitaSupervision: necesitaSupervision,
              ),
            );
        Navigator.of(context).pop();
      },
      content: Column(
        children: [
          Text(
            textAlign: TextAlign.center,
            l10n.pageManageTemplatesWillCreate,
          ),
          Text(
            '"$tituloPlantilla"',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(l10n.pageManageTemplatesWantContinue),
        ],
      ),
    );
  }
}
