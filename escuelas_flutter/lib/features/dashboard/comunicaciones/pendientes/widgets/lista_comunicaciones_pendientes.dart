import 'package:escuelas_flutter/features/dashboard/comunicaciones/pendientes/bloc_comunicaciones_pendientes/bloc_comunicaciones_pendientes.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/pendientes/bloc_comunicaciones_pendientes/bloc_comunicaciones_pendientes_estado.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/pendientes/widgets/comision_con_notificaciones_pendientes.dart.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ListaComunicacionesPendientes}
/// Lista de notificaciones pendientes separada
/// en comisiones.
/// {@endtemplate}
class ListaComunicacionesPendientes extends StatelessWidget {
  /// {@macro ListaComunicacionesPendientes}
  const ListaComunicacionesPendientes({super.key});

  /// Muestra el dialog exitoso cuando se aprueba correctamente
  /// una solicitud de notificacion pendiente
  Future<void> _showDialogExito(
    BuildContext context,
  ) {
    final l10n = context.l10n;

    return showDialog<void>(
      context: context,
      builder: (_) => EscuelasDialog.exitoso(
        altura: 82.ph,
        context: context,
        onTap: () {
          Navigator.of(_).pop();
        },
        content: SizedBox(
          height: 25.ph,
          child: Text(
            l10n.pagePendingCommunicationsDialogSuccess,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.pf,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocConsumer<BlocComunicacionesPendientes,
        BlocComunicacionesPendientesEstado>(
      listener: (context, state) {
        if (state is BlocComunicacionesPendientesEstadoAprobacionExitosa) {
          _showDialogExito(context);
        }
      },
      builder: (context, state) {
        if (state is BlocComunicacionesPendientesEstadoCargando) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final listaComisionesConComunicacionesPendientes =
            state.listaComisiones;

        if (listaComisionesConComunicacionesPendientes.isEmpty) {
          return Center(
            child: Text(
              l10n.pagePendingCommunicationsEmptyList,
              style: TextStyle(
                fontSize: 18.pf,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8.ph,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: listaComisionesConComunicacionesPendientes.map(
                (comision) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.sh,
                      horizontal: 15.pw,
                    ),
                    child: ComisionConNotificacionesPendientes(
                      comision: comision,
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        );
      },
    );
  }
}
