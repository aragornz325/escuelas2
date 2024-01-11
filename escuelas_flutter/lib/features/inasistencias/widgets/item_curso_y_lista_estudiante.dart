import 'dart:math';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/inasistencias/bloc_inasistencias/bloc_inasistencias.dart';
import 'package:escuelas_flutter/features/inasistencias/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ItemCursoConListaDeEstudiantes}
/// Item Curso con una lista de estudiantes a modificar la asistencia a dicho
/// estudiante
/// {@endtemplate}
class ItemCursoConListaDeEstudiantes extends StatelessWidget {
  /// {@macro ItemCursoConListaDeEstudiantes}
  const ItemCursoConListaDeEstudiantes({
    required this.onTap,
    required this.comisionDeCurso,
    super.key,
  });

  /// On tap del item curso que se cerrara la lista de los estudiantes a mostrar
  final VoidCallback onTap;

  /// Curso a mostrar
  final ComisionDeCurso comisionDeCurso;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<BlocInasistencias, BlocInasistenciasEstado>(
      builder: (context, state) {
        // Lista de estudiantes de un curso
        final estudiantesPorCurso =
            state.asistenciasDiarias(comisionDeCurso.id ?? 0);

        return Column(
          children: [
            ItemCurso(
              ancho: 400.pw,
              comisionDeCurso: comisionDeCurso,
              onTap: onTap,
            ),
            if ((comisionDeCurso.estudiantes ?? []).isEmpty)
              // TODO(anyone): hacer una vista cuando no hay cursos.
              SizedBox(
                height: max(150.ph, 150.sh),
                child: Center(
                  child: Text(l10n.pageAttendanceNotAbsentStudents),
                ),
              )
            else
              Expanded(
                child: _ListaEstudiantesDelCurso(
                  comisionDeCurso: comisionDeCurso,
                  inasistenciasDelCurso: estudiantesPorCurso,
                ),
              ),
            const Spacer(),
            BotonFinalizarInasistencias(
              comisionDeCurso: comisionDeCurso,
              inasistencias: estudiantesPorCurso,
              fecha: state.fechaActual ?? DateTime.now(),
            ),
          ],
        );
      },
    );
  }
}

/// {@template _ListaEstudiantesDelCurso}
/// Lista de estudiantes del curso a modificar la asistencia de ese estudiante
/// {@endtemplate}
class _ListaEstudiantesDelCurso extends StatelessWidget {
  /// {@macro _ListaEstudiantesDelCurso}
  const _ListaEstudiantesDelCurso({
    required this.comisionDeCurso,
    required this.inasistenciasDelCurso,
  });

  /// Curso a mostrar
  final ComisionDeCurso comisionDeCurso;

  /// Inasistencias de ese curso
  final List<AsistenciaDiaria> inasistenciasDelCurso;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return ListView.builder(
      itemCount: comisionDeCurso.estudiantes?.length ?? 0,
      itemBuilder: (context, index) {
        //Estudiante del curso
        final estudiante = comisionDeCurso.estudiantes?[index];

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.pw,
            vertical: max(10.ph, 10.sh),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 250.pw,
                child: Text(
                  '${estudiante?.usuario?.nombre ?? ''} '
                  '${estudiante?.usuario?.apellido ?? ''}',
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
                      BlocAsistenciaEventoCambiarInasistenciaEstudiante(
                        idCurso: comisionDeCurso.id ?? 0,
                        idEstudiante: estudiante?.usuarioId ?? 0,
                        fecha: DateTime.now(),
                        estadoInasistencia:
                            inasistenciasDelCurso[index].estadoDeAsistencia,
                      ),
                    ),
                child: Container(
                  width: 80.pw,
                  height: max(25.ph, 25.sh),
                  decoration: BoxDecoration(
                    color: inasistenciasDelCurso[index]
                        .estadoDeAsistencia
                        .colorEstado(context),
                    borderRadius: BorderRadius.all(
                      Radius.circular(35.sw),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      inasistenciasDelCurso[index]
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
        );
      },
    );
  }
}
