import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/carga_calificaciones/bloc_carga_calificaciones/bloc_carga_calificaciones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template BotonesEnviarNotasYLimpiarNotas}
/// Botón para enviar las calificaciones y limpiar las notas.
/// {@endtemplate}
class BotonesEnviarNotasYLimpiarNotas extends StatelessWidget {
  /// {@macro BotonesEnviarNotasYLimpiarNotas}
  const BotonesEnviarNotasYLimpiarNotas({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return BlocBuilder<BlocCargaCalificaciones, BlocCargaCalificacionesEstado>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            EscuelasBoton.texto(
              context: context,
              // TODO(anyone): reemplazar por las calificaciones previas ver
              // como vienen las calificaciones previas y mostrarlas
              estaHabilitado: state.listaCalificaciones.isNotEmpty,
              // TODO(ANYONE): Cambiar por el id correspondiente, cuadno este
              // lo de back
              onTap: () => context.read<BlocCargaCalificaciones>().add(
                    const BlocCargaCalificacionesEventoVaciarCalificaciones(),
                  ),
              color: colores.error,
              texto: l10n.commonDeleteAll,
            ),
            EscuelasBoton.texto(
              context: context,
              estaHabilitado:
                  state.calificacionesMensuales?.solicitudNotaMensual != null,
              // TODO(ANYONE): Cambiar por el id correspondiente, cuadno este
              // lo de back
              onTap: () => context.read<BlocCargaCalificaciones>().add(
                    const BlocCargaCalificacionesEventoEnviarCalificaciones(),
                  ),
              color: colores.azul,
              texto: l10n.commonConfirm,
            ),
          ],
        );
      },
    );
  }
}
