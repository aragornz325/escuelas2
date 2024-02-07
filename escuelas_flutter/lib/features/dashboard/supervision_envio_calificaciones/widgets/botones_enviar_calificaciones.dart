import 'dart:math';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/supervision_envio_calificaciones/bloc/bloc_supervision_envio_calificaciones.dart';
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
  const BotonesEnviarCalificaciones({
    required this.asignaturasFaltantes,
    super.key,
  });

  /// lista de asignaturas faltantes
  final List<Asignatura> asignaturasFaltantes;

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

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 15.ph),
          child: EscuelasBoton.texto(
            width: 340.pw,
            height: max(40.ph, 40.sh),
            // TODO(mati): Habilitar cuando la lista tenga aunquesea 1 sin
            // cargar
            estaHabilitado: true,
            onTap: () => context.read<BlocSupervisionEnvioCalificaciones>().add(
                  eventoSolicitarCaliFaltantes,
                ),
            color: colores.azul,
            texto: l10n.pageGradeSubmissionSupervisionButton(
              asignaturasFaltantes.length,
            ),
            context: context,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15.ph),
          child: EscuelasBoton.outlined(
            width: 340.pw,
            height: max(40.ph, 40.sh),
            // TODO(mati): Habilitar cuando esten todas las
            // calificaciones cargadas
            estaHabilitado: false,
            tamanioFuente: 16.pf,
            anchoDeLasLetras: FontWeight.w700,
            onTap: () => context
                .read<BlocSupervisionEnvioCalificaciones>()
                .add(eventoEnviarCalificaciones),
            color: colores.primaryContainer,
            colorTexto: colores.primaryContainer,
            texto: l10n.pageGradeSubmissionSupervisionButtonSendQualifications,
            context: context,
          ),
        ),
      ],
    );
  }
}
