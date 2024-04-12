import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/supervision/supervision_envio_calificaciones/bloc/bloc_supervision_envio_calificaciones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template BotonesEnviarCalificaciones}
/// Botones para enviar calificaciones y para reenviar a los profesores que les
/// falta cargar las calificaciones de esa asignatura, y muestra cuantos de la
/// lista les falta cargar.
/// {@endtemplate}
class BotonesEnviarCalificaciones extends StatelessWidget {
  /// {@macro BotonesEnviarCalificaciones}
  const BotonesEnviarCalificaciones({super.key});

  // ignore: avoid_field_initializers_in_const_classes
  final eventoSolicitarCaliFaltantes =
      const BlocSupervisionEnvioCalificacionesEventoSolicitarCaliFaltantes();

  // ignore: avoid_field_initializers_in_const_classes
  final eventoEnviarCalificaciones =
      const BlocSupervisionEnvioCalificacionesEventoEnviarCalificaciones();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final colores = context.colores;

    return BlocBuilder<BlocSupervisionEnvioCalificaciones,
        BlocSupervisionEnvioCalificacionesEstado>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15.ph),
              child: EscuelasBoton.texto(
                width: 340.pw,
                height: max(40.ph, 40.sh),
                estaHabilitado: state.solicitarCargaDeCalificaciones,
                onTap: () =>
                    context.read<BlocSupervisionEnvioCalificaciones>().add(
                          eventoSolicitarCaliFaltantes,
                        ),
                color: colores.azul,
                texto: l10n.pageGradeSubmissionSupervisionButton(
                  state.asignaturasFaltantes,
                ),
                context: context,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.ph),
              child: EscuelasBoton.outlined(
                width: 340.pw,
                height: max(40.ph, 40.sh),
                estaHabilitado: state.enviarCalificaciones,
                tamanioFuente: 16.pf,
                anchoDeLasLetras: FontWeight.w700,
                onTap: () => context
                    .read<BlocSupervisionEnvioCalificaciones>()
                    .add(eventoEnviarCalificaciones),
                color: colores.primaryContainer,
                colorTexto: colores.primaryContainer,
                texto:
                    l10n.pageGradeSubmissionSupervisionButtonSendQualifications,
                context: context,
              ),
            ),
          ],
        );
      },
    );
  }
}
