import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/dashboard/carga_calificaciones/bloc_carga_calificaciones/bloc_carga_calificaciones.dart';
import 'package:escuelas_flutter/features/dashboard/carga_calificaciones/celular/vista_celular_carga_calificaciones.dart';
import 'package:escuelas_flutter/features/dashboard/carga_calificaciones/escritorio/vista_escritorio_carga_calificaciones.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaCargaDeCalificaciones}
/// Pagina de Carga de Calificaciones.
///
/// En esta vista se muestra el calendario de la fecha actual y la lista de los
/// alumnos de un curso y de una materia.
/// Se puede modificar la calificación de los alumnos y ver de meses anteriores.
/// {@endtemplate}
@RoutePage()
class PaginaCargaDeCalificaciones extends StatelessWidget {
  /// {@macro PaginaCargaDeCalificaciones}
  PaginaCargaDeCalificaciones({
    @PathParam('nombreAsignatura')
    required this.nombreAsignatura, // TODO(SAM): Cambiar a idasignatura
    @PathParam('idCurso') required this.idCurso, // ID comision
    @PathParam('fecha') required String fecha,
    super.key,
  }) : fecha = DateTime.parse(fecha);

  /// Fecha actual de la calificación del alumno.
  final DateTime fecha;

  /// Id del curso.
  final int idCurso;

  /// Nombre del curso
  final String nombreAsignatura;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocCargaCalificaciones>(
      create: (context) => BlocCargaCalificaciones()
        ..add(
          BlocCargaCalificacionesEventoInicializar(
            fecha: fecha,
            idCurso: idCurso,
          ),
        ),
      child: FullResponsiveScreen(
        celular: VistaCelularCargaDeCalificaciones(
          fecha: fecha,
          nombreAsignatura: nombreAsignatura,
        ),
        escritorio: const VistaEscritorioCargaDeCalificaciones(),
      ),
    );
  }
}
