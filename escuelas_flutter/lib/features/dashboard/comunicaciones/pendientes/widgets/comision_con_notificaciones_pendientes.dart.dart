import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/pendientes/bloc_comunicaciones_pendientes/bloc_comunicaciones_pendientes.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/pendientes/widgets/elemento_notificacion_pendiente.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ComisionConNotificacionesPendientes}
/// Componente contenedor de la lista de notificaciones pendientes separado
/// en comisiones.
/// {@endtemplate}
class ComisionConNotificacionesPendientes extends StatelessWidget {
  /// {@macro ComisionConNotificacionesPendientes}
  const ComisionConNotificacionesPendientes({
    required this.comision,
    super.key,
  });

  final ComisionDeCurso? comision;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return BlocBuilder<BlocComunicacionesPendientes,
        BlocComunicacionesPendientesEstado>(
      builder: (context, state) {
        if (state is BlocComunicacionesPendientesEstadoCargando) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final listaNotificacionesPendientes =
            state.listaNotificacionesPendientes;

        final notificacionesPorComision = listaNotificacionesPendientes
            .where(
              (solicitudNotificacion) =>
                  comision?.id == solicitudNotificacion.comisionId,
            )
            .toList();

        return Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                comision?.nombre ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16.pf,
                  color: colores.onBackground,
                ),
              ),
            ),
            Divider(
              color: colores.grisSobreBackground,
            ),
            Column(
              children: notificacionesPorComision.map(
                (solicitudNotificacion) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.sh,
                      horizontal: 1.pw,
                    ),
                    child: ElementoNotificacionPendiente(
                      solicitudNotificacion: solicitudNotificacion,
                    ),
                  );
                },
              ).toList(),
            ),
          ],
        );
      },
    );
  }
}
