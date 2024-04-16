import 'package:auto_route/auto_route.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/features/dashboard/supervision/supervision_envio_calificaciones/bloc/bloc_supervision_envio_calificaciones.dart';
import 'package:escuelas_flutter/utilidades/utilidades.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ListaDeAsignaturas}
/// Lista de asignaturas muestra:
///
/// - Nombre de la asignatura de una comision
/// - Nombre del docente que esta asignado a esa asignatura
/// - Fecha de la carga de las calificaciones(la fecha que cargo/subio el
/// doncente a cargo las calificaciones de los alumnos en caso contrario
/// muestra un mensaje de
/// `sin enviar`).
/// {@endtemplate}
class ListaDeAsignaturas extends StatelessWidget {
  /// {@macro ListaDeAsignaturas}
  const ListaDeAsignaturas({
    required this.asignaturas,
    super.key,
  });

  /// Lista de asignaturas a mostrar
  final List<EstadoCalificacionesAsignatura> asignaturas;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocSupervisionEnvioCalificaciones,
        BlocSupervisionEnvioCalificacionesEstado>(
      builder: (context, state) {
        return ListView(
          children: asignaturas
              .map(
                (asignatura) => Padding(
                  padding: EdgeInsets.only(bottom: 10.ph),
                  child: ElementoLista.supervisionEnvioCalificaciones(
                    onTap: () => context.pushRoute(
                      RutaSupervisionAsignatura(
                        idAsignatura: asignatura.idAsignatura,
                        idComision: state.idComision,
                        fecha: state.fecha.toString(),
                      ),
                    ),
                    context: context,
                    fechaDeCarga: asignatura.fechaRealizacionSolicitud,
                    nombreProfesor:
                        obtenerNombreAbreviado(asignatura.nombreDocente),
                    nombreAsignatura: asignatura.nombreAsignatura,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
