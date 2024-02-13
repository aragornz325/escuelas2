import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/utilidades/utilidades.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ListaDeAsignaturas}
/// La lista de asignaturas con el texto del nombre de la asignatura con el
/// docente y la fecha en la que cargo esa asignatura sus calificaciones.
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
    return SingleChildScrollView(
      child: Column(
        children: asignaturas
            .map(
              (asignatura) => Padding(
                padding: EdgeInsets.only(bottom: 10.ph),
                child: ElementoLista.supervisionEnvioCalificaciones(
                  context: context,
                  fechaDeCarga:  asignatura.fechaRealizacionSolicitud,
                  nombreProfesor:
                      obtenerNombreAbreviado(asignatura.nombreDocente),
                  nombreAsignatura: asignatura.nombreAsignatura,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
