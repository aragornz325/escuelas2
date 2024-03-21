import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/dashboard/supervision_envio_calificaciones/bloc/bloc_supervision_envio_calificaciones.dart';
import 'package:escuelas_flutter/features/dashboard/supervision_envio_calificaciones/celular/vista_celular_supervision_envio_calificaciones.dart';
import 'package:escuelas_flutter/features/dashboard/supervision_envio_calificaciones/escritorio/vista_escritorio_supervision_envio_calificaciones.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template VistaEscritorioSupervisionEnvioCalificaciones}
/// Vista para celular de la pagina 'Supervision de Envio de Calificaciones'
/// donde se supervisa la carga de calificaciones de las materias de un curso
/// {@endtemplate}
@RoutePage()
class PaginaSupervisionEnvioCalificaciones extends StatelessWidget {
  /// {@macro PaginaSupervisionEnvioCalificaciones}
  PaginaSupervisionEnvioCalificaciones({
    @PathParam('idCurso') required this.idCurso,
    @PathParam('fecha') required String fecha,
    super.key,
  }) : fecha = DateTime.parse(fecha);

  /// Id del curso a supervisar
  final int idCurso;

  /// Fecha del periodo a supervisar
  final DateTime fecha;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocSupervisionEnvioCalificaciones>(
      create: (context) => BlocSupervisionEnvioCalificaciones(fecha)
        ..add(
          BlocSupervisionEnvioCalificacionesEventoInicializar(
            idCurso: idCurso,
            fecha: fecha,
          ),
        ),
      child: const FullResponsiveScreen(
        celular: VistaCelularSupervisionEnvioCalificaciones(),
        escritorio: VistaEscritorioSupervisionEnvioCalificaciones(),
      ),
    );
  }
}
