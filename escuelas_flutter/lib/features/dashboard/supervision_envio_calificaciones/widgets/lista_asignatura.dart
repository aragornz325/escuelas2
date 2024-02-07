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
  final List<Asignatura> asignaturas;

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
                  // TODO(anyoone): Cambiar por fecha de carga de
                  // calificaciones (cuando se implemente) de cada ,ateroa
                  // y reemplazar por el nombnre de la docente asignada a esa
                  // asignatura
                  fechaDeCarga: DateTime.now(),
                  nombreProfesor: obtenerNombreAbreviado(
                    // asignatura.docentes.first.nombre,
                    'Gonzalo Miguel Rigoni',
                  ),
                  nombreAsignatura: asignatura.nombre,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
