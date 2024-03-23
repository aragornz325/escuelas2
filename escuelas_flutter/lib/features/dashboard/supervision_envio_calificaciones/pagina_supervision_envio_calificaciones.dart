import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/dashboard/supervision_envio_calificaciones/bloc/bloc_supervision_envio_calificaciones.dart';
import 'package:escuelas_flutter/features/dashboard/supervision_envio_calificaciones/celular/vista_celular_supervision_envio_calificaciones.dart';
import 'package:escuelas_flutter/features/dashboard/supervision_envio_calificaciones/escritorio/vista_escritorio_supervision_envio_calificaciones.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template VistaEscritorioSupervisionEnvioCalificaciones}
/// Vista para celular de la pagina 'Supervision de Envio de Calificaciones'
/// donde se supervisa la carga de calificaciones de las asignaturas de una
/// comision
/// {@endtemplate}
@RoutePage()
class PaginaSupervisionEnvioCalificaciones extends StatelessWidget {
  /// {@macro PaginaSupervisionEnvioCalificaciones}
  PaginaSupervisionEnvioCalificaciones({
    @PathParam('idComision') required this.idComision,
    @PathParam('fecha') required String fecha,
    super.key,
  }) : fecha = DateTime.parse(fecha);

  /// Id de la comision a supervisar
  final int idComision;

  /// Fecha del periodo a supervisar
  final DateTime fecha;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocSupervisionEnvioCalificaciones>(
      create: (context) => BlocSupervisionEnvioCalificaciones(
        idComision: idComision,
        fecha: fecha,
      )..add(
          const BlocSupervisionEnvioCalificacionesEventoInicializar(),
        ),
      child: const FullResponsiveScreen(
        celular: VistaCelularSupervisionEnvioCalificaciones(),
        escritorio: VistaEscritorioSupervisionEnvioCalificaciones(),
      ),
    );
  }
}
