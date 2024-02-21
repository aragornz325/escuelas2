import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/dashboard/alumno-calificaciones/calificaciones-mensuales/bloc_calificaciones_mensuales/bloc_calificaciones_mensuales.dart';
import 'package:escuelas_flutter/features/dashboard/alumno-calificaciones/calificaciones-mensuales/celular/vista_celular_calificaciones_mensuales.dart';
import 'package:escuelas_flutter/features/dashboard/alumno-calificaciones/calificaciones-mensuales/escritorio/vista_escritorio_calificaciones_mensuales.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaCalificacionesMensuales}
/// Pagina de Calificaciones Mensuales donde un alumno puede ver su ultima
/// calificacion de cada materia y el promedio.
/// {@endtemplate}
@RoutePage()
class PaginaCalificacionesMensuales extends StatelessWidget {
  /// {@macro PaginaCalificacionesMensuales}
  const PaginaCalificacionesMensuales({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final fechaActual = DateTime.now();
    return BlocProvider<BlocCalificacionesMensuales>(
      create: (context) => BlocCalificacionesMensuales(fecha: fechaActual)
        ..add(
        const   BlocCalificacionesMensualesEventoInicializar(),
        ),
      child: const FullResponsiveScreen(
        celular: VistaCelularCalificacionesMensuales(),
        escritorio: VistaEscritorioCalificacionesMensuales(),
      ),
    );
  }
}
