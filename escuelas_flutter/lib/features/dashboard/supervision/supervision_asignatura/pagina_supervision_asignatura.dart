import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/dashboard/bloc_dashboard/bloc_dashboard.dart';
import 'package:escuelas_flutter/features/dashboard/supervision/supervision_asignatura/bloc/bloc_supervision_asignatura.dart';
import 'package:escuelas_flutter/features/dashboard/supervision/supervision_asignatura/celular/vista_celular_supervision_asignatura.dart';
import 'package:escuelas_flutter/features/dashboard/supervision/supervision_asignatura/escritorio/vista_escritorio_supervision_asignatura.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//TODO(anyone): se podria refactorizar la Carga de calificaciones y el envio de
// mails en una unica vista ?.
/// {@template PaginaSupervisionAsignatura}
/// Pagina de Supervision Asignatura donde un docente puede ver las
/// calificaciones y enviar mails a los estudiantes.
/// {@endtemplate}
@RoutePage()
class PaginaSupervisionAsignatura extends StatelessWidget {
  /// {@macro PaginaSupervisionAsignatura}
  PaginaSupervisionAsignatura({
    @PathParam('idAsignatura') required this.idAsignatura,
    @PathParam('idComision') required this.idComision,
    @PathParam('fecha') required String fecha,
    super.key,
  }) : fecha = DateTime.parse(fecha);

  /// Fecha actual de la calificación del alumno.
  final DateTime fecha;

  /// Id de la comision
  final int idComision;

  /// id de la asignatura
  final int idAsignatura;

  @override
  Widget build(BuildContext context) {
    final idAutor = context.read<BlocDashboard>().state.usuario.id ?? 0;

    return BlocProvider<BlocSupervisionAsignatura>(
      create: (context) => BlocSupervisionAsignatura(fecha: fecha)
        ..add(
          BlocSupervisionAsignaturaEventoInicializar(
            idComision: idComision,
            idAsignatura: idAsignatura,
            idAutor: idAutor,
          ),
        ),
      child: const FullResponsiveScreen(
        celular: VistaCelularSupervisionAsignatura(),
        escritorio: VistaEscritorioSupervisionAsignatura(),
      ),
    );
  }
}
