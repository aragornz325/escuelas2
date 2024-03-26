import 'package:auto_route/auto_route.dart';
import 'package:escuelas_commons/escuelas_commons.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/extensiones/build_context.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/lista_cursos/mis_cursos/bloc/bloc_mis_cursos.dart';
import 'package:escuelas_flutter/features/dashboard/lista_cursos/mis_cursos/widgets/item_materia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ListaDeAsignaturasPorComision}
/// Lista de asignaturas por comision
/// {@endtemplate}
class ListaDeAsignaturasPorComision extends StatelessWidget {
  /// {@macro ListaDeAsignaturasPorComision}
  const ListaDeAsignaturasPorComision({
    required this.periodo,
    super.key,
  });

  /// Periodo de la lista de asignaturas
  final DateTime periodo;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return BlocBuilder<BlocMisCursos, BlocMisCursosEstado>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: state.comisiones
              .map(
                (comision) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comision.nombreDeComision.toUpperCase(),
                      style: TextStyle(
                        color: colores.onSecondary,
                        fontSize: 13.pf,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 10.ph),
                    Column(
                      children: comision.listaDeAsignaturas
                          .map(
                            (asignatura) => Padding(
                              padding: EdgeInsets.only(
                                bottom: 10.ph,
                              ),
                              child: ItemMateria(
                                estaCargada: asignatura
                                    .solicitudesDeCalificacionCompletas,
                                estaHabilitado:
                                    periodo.isBefore(DateTime.now()),
                                asignatura: asignatura,
                                onTap: () {
                                  if (context.tienePermiso(
                                    PermisoDeCalificacion.verCalificacion,
                                  )) {
                                    context.pushRoute(
                                      RutaCargaDeCalificaciones(
                                        fecha: periodo.toString(),
                                        idComision: comision.idComision,
                                        idAsignatura: asignatura.idAsignatura,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              )
              .toList(),
        );
      },
    );
  }
}
