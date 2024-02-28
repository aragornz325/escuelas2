import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/bloc/bloc_administrar_plantillas.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/dialog/dialog.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template RowModoEliminar}
/// Row que contiene el boton para cancelar el modo eliminar y el boton
/// para eliminar las plantillas seleccionadas
/// {@endtemplate}
class RowModoEliminar extends StatelessWidget {
  /// {@macro RowModoEliminar}
  const RowModoEliminar({
    super.key,
  });

  Future<void> onConfirmarEliminado(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocAdministrarPlantillas>(),
        child: const DialogConfirmarEliminado(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colores = context.colores;

    return BlocBuilder<BlocAdministrarPlantillas,
        BlocAdministrarPlantillasEstado>(
      builder: (context, state) {
        return state.modoEliminar
            ? Row(
                children: [
                  InkWell(
                    onTap: () => context.read<BlocAdministrarPlantillas>().add(
                          BlocAdministrarPlantillasEventoAlternarModoEliminar(),
                        ),
                    child: Text(
                      l10n.commonCancel,
                      style: TextStyle(
                        color: colores.error,
                        fontSize: 14.pf,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.sw),
                  GestureDetector(
                    onTap: () => onConfirmarEliminado(context),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.sw),
                        ),
                        color: colores.error,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: .1,
                            blurRadius: 2,
                            offset: const Offset(-2, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.pw,
                          vertical: 2.ph,
                        ),
                        child: Text(
                          l10n.commonDelete,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.pf,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : InkWell(
                onTap: () => context.read<BlocAdministrarPlantillas>().add(
                      BlocAdministrarPlantillasEventoAlternarModoEliminar(),
                    ),
                child: Icon(
                  Icons.delete_outline,
                  color: colores.error,
                  size: 24.sw,
                ),
              );
      },
    );
  }
}
