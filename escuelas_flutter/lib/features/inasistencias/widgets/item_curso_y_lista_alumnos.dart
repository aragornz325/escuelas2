import 'dart:math';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extension_estado_asistencia.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/inasistencias/bloc_inasistencias/bloc_inasistencias.dart';
import 'package:escuelas_flutter/features/inasistencias/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ItemCursoConListaDeAlumnos}
/// Item Curso con una lista de alumnos a modificar la asistencia a dicho
/// alumnos
/// {@endtemplate}
class ItemCursoConListaDeAlumnos extends StatelessWidget {
  /// {@macro ItemCursoConListaDeAlumnos}
  const ItemCursoConListaDeAlumnos({
    required this.onTap,
    required this.indexCurso,
    required this.curso,
    required this.fecha,
    super.key,
  });

  /// On tap del item curso que se cerrara la lista de los alumnos a mostrar
  final VoidCallback onTap;

  /// Indice del curso
  final int indexCurso;

  /// Curso a mostrar
  final ComisionDeCurso curso;

  /// Fecha en la que se finalizaron las asistencias
  final DateTime fecha;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    final l10n = context.l10n;

    return BlocBuilder<BlocInasistencias, BlocInasistenciasEstado>(
      builder: (context, state) {
        final estudiantesPorCurso = state.asistenciasDiarias(curso.idCurso);

        final estudiantes = curso.cursadas ?? [];

        return Column(
          children: [
            ItemCurso(
              ancho: 400.pw,
              curso: curso,
              onTap: onTap,
            ),
            if (estudiantes.isEmpty)
              //TODO(anyone): hacer una vista cuando no hay cursos.
              Center(
                child: Text(l10n.pageAttendanceNotAbsentStudents),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: estudiantes.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.pw,
                      vertical: max(10.ph, 10.sh),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 250.pw,
                          child: Text(
                            estudiantes[index].usuario?.nombre ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: colores.onBackground,
                              fontWeight: FontWeight.w400,
                              fontSize: 15.pf,
                            ),
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () => context.read<BlocInasistencias>().add(
                                BlocAsistenciaEventoCambiarInasistenciaAlumno(
                                  idCurso: curso.idCurso,
                                  idAlumno: estudiantes[index].usuarioId,
                                  fecha: DateTime.now(),
                                  asistenciaDiaria: estudiantesPorCurso[index]
                                      .estadoDeAsistencia
                                      .cambiarEstado(),
                                ),
                              ),
                          child: Container(
                            width: 80.pw,
                            height: max(25.ph, 25.sh),
                            decoration: BoxDecoration(
                              color: estudiantesPorCurso[index]
                                  .estadoDeAsistencia
                                  .colorEstado(context),
                              borderRadius: BorderRadius.all(
                                Radius.circular(35.sw),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                estudiantesPorCurso[index]
                                    .estadoDeAsistencia
                                    .nombreEstado(context),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: colores.background,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13.pf,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            BotonFinalizarInasistencias(
              curso: curso,
              asistencias: estudiantesPorCurso,
              fecha: fecha,
            ),
          ],
        );
      },
    );
  }
}
