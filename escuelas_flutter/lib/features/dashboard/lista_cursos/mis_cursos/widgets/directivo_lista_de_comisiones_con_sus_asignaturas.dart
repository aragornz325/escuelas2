import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ListaDeComisionesConSusAsignaturas}
/// Lista de comisiones con la lista de asignaturas.
/// {@endtemplate}
class ListaDeComisionesConSusAsignaturas extends StatelessWidget {
  /// {@macro ListaDeComisionesConSusAsignaturas}
  const ListaDeComisionesConSusAsignaturas({
    required this.comisiones,
    super.key,
  });

  /// Lista de comisiones con la lista de asignaturas.
  final List<ComisionConAsignaturas> comisiones;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return SingleChildScrollView(
      child: Column(
        children: comisiones
            .map(
              (comision) => Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.pw,
                  vertical: max(5.ph, 5.sh),
                ),
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 16.pf,
                    fontWeight: FontWeight.w700,
                    color: colores.onBackground,
                  ),
                  child: ExpansionTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.sw),
                    ),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.sw),
                    ),
                    backgroundColor: colores.tertiary,
                    collapsedBackgroundColor: colores.tertiary,
                    title: Text(comision.comision.nombre),
                    children: comision.asignaturas
                        .map(
                          (asignatura) => InkWell(
                            onTap: () => context.pushRoute(
                              RutaGestionDeComision(
                                idAsignatura: asignatura.id ?? 0,
                                idComision: comision.comision.id ?? 0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.pw,
                                vertical: max(10.ph, 10.sh),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    asignatura.nombre.toUpperCase(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
