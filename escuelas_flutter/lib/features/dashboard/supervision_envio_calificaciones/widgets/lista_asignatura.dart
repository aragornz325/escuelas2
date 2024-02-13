import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/utilidades/utilidades.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
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
    return ListView(
      children: asignaturas
          .map(
            (asignatura) => Padding(
              padding: EdgeInsets.only(bottom: 10.ph),
              child: ElementoLista.supervisionEnvioCalificaciones(
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
  }
}
