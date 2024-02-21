import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/dashboard/alumno-calificaciones/calificaciones-anuales/bloc_calificaciones_anuales/bloc_calificaciones_anuales.dart';
import 'package:escuelas_flutter/features/dashboard/alumno-calificaciones/calificaciones-anuales/celular/vista_celular_calificaciones_anuales.dart';
import 'package:escuelas_flutter/features/dashboard/alumno-calificaciones/calificaciones-anuales/escritorio/vista_escritorio_calificaciones_anuales.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaCalificacionesAnuales}
/// Pagina Calificaciones Anuales donde un alumno puede visualizar la
/// calificacion de cada mes durante el año en curso.
/// {@endtemplate}
@RoutePage()
class PaginaCalificacionesAnuales extends StatelessWidget {
  /// {@macro PaginaCalificacionesAnuales}
  const PaginaCalificacionesAnuales({
    @PathParam('idAsignatura') required this.idAsignatura,
    super.key,
  });

  /// Id de la asignatura para mostrar el historial de calificaciones en el año.
  final int idAsignatura;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocCalificacionesAnuales>(
      create: (context) => BlocCalificacionesAnuales()
        ..add(
          BlocCalificacionesAnualesEventoInicializar(
            idAsignatura: idAsignatura,
            anio: DateTime.now().year,
          ),
        ),
      child: const FullResponsiveScreen(
        celular: VistaCelularCalificacionesAnuales(),
        escritorio: VistaEscritorioCalificacionesAnuales(),
      ),
    );
  }
}
