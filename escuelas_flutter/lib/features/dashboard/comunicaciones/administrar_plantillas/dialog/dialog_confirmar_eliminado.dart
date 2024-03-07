import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/bloc/bloc_administrar_plantillas.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialogConfirmarEliminado}
/// Dialogo para confirmar la eliminacion de una plantilla o mas plantillas
/// {@endtemplate}
class DialogConfirmarEliminado extends StatelessWidget {
  /// {@macro DialogConfirmarEliminado}
  const DialogConfirmarEliminado({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.read<BlocAdministrarPlantillas>().state;
    final colores = context.colores;

    return EscuelasDialog.solicitudDeAccion(
      estaHabilitado: true,
      titulo: l10n.commonAttention,
      context: context,
      onTapConfirmar: () => {
        context.read<BlocAdministrarPlantillas>().add(
              BlocAdministrarPlantillasEventoEliminarPlantillas(),
            ),
        Navigator.of(context).pop(),
      },
      content: Column(
        children: [
          Text(
            l10n.pageManageTemplatesDialogYouWillEliminate,
            style: TextStyle(
              color: colores.grisSC,
              fontSize: 16.pf,
            ),
          ),
          if (state.listaDePlantillasConCheckbox
                  .where((element) => element.seleccionado)
                  .length ==
              1)
            Text(
              '"${state.listaDePlantillasConCheckbox.where((element) => element.seleccionado).map((e) => e.plantilla.titulo)}"',
              style: TextStyle(
                color: colores.onBackground,
                fontWeight: FontWeight.bold,
                fontSize: 16.pf,
              ),
            )
          else
            Text(
              '${state.listaDePlantillasConCheckbox.where((element) => element.seleccionado).length} ${l10n.pageManageTemplatesDialogSuccessPartOne}s',
              style: TextStyle(
                color: colores.onBackground,
                fontWeight: FontWeight.bold,
                fontSize: 16.pf,
              ),
            ),
          Text(
            l10n.pageManageTemplatesDialogFromYourTemplatesList,
            style: TextStyle(
              color: colores.grisSC,
              fontSize: 16.pf,
            ),
          ),
          Text(
            l10n.pageManageTemplatesWantContinue,
            style: TextStyle(
              color: colores.grisSC,
              fontSize: 16.pf,
            ),
          ),
        ],
      ),
    );
  }
}
