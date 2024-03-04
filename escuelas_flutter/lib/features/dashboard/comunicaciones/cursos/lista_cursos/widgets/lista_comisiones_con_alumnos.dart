import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ListaComisionesConAlumnos}
/// Lista de comisiones con sus alumnos y podes navegar al cuaderno de
/// Lista de comisiones con sus alumnos y podes navegar al cuaderno de
/// comunicado del alumno que clickeas.
/// {@endtemplate}
class ListaComisionesConAlumnos extends StatelessWidget {
  /// {@macro ListaComisionesConAlumnos}
  const ListaComisionesConAlumnos({
    required this.comisiones,
    super.key,
  });

  /// Comisiones a mostrar con los alumnos que estan inscritos.
  final List<ComisionDeCurso> comisiones;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final colores = context.colores;

    return DefaultTextStyle(
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 15.pf,
        color: colores.onBackground,
      ),
      child: ListView(
        children: comisiones
            .map(
              (comision) => Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10.pw,
                  vertical: max(8.ph, 8.sh),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25.sw)),
                  color: colores.tertiary,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.pw),
                  child: ExpansionTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.sw),
                    ),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.sw),
                    ),
                    title: Text(
                      comision.nombre,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16.pf,
                        color: colores.onBackground,
                      ),
                    ),
                    children: (comision.estudiantes?.map(
                              (alumno) {
                                if ((comision.estudiantes ?? []).isEmpty) {
                                  return ListTile(
                                    title: Text(
                                      l10n.pageAttendanceNotAbsentStudents,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }
                                return ListTile(
                                  onTap: () => context.pushRoute(
                                    RutaPerfilComunicados(
                                      idUsuario:
                                          alumno.usuario?.idUserInfo ?? 0,
                                      nombreUsuario:
                                          alumno.usuario?.nombre ?? '',
                                    ),
                                  ),
                                  title: Text(
                                    '${alumno.usuario?.nombre ?? ''}'
                                    ' ${alumno.usuario?.apellido ?? ''}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              },
                            ) ??
                            [])
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
