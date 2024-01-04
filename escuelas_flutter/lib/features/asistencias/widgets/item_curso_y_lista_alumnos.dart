import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/asistencias/bloc_asistencias/bloc_asistencias.dart';
import 'package:escuelas_flutter/features/asistencias/widgets/widgets.dart';
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
    super.key,
  });

  /// On tap del item curso que se cerrara la lista de los alumnos a mostrar
  final VoidCallback onTap;

  /// Indice del curso
  final int indexCurso;

  /// Curso a mostrar
  final ModeloCurso curso;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Column(
      children: [
        ItemCurso(
          ancho: 400.pw,
          curso: curso,
          onTap: onTap,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: curso.alumnos.length,
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
                      curso.alumnos[index].nombre,
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
                    onTap: () => context.read<BlocAsistencias>().add(
                          BlocAsistenciasEventoCambiarEstadoAsistencia(
                            idAlumno: curso.alumnos[index].id,
                            idCurso: curso.id,
                            estado: curso.alumnos[index].asistencia,
                          ),
                        ),
                    child: Container(
                      width: 80.pw,
                      height: max(25.ph, 25.sh),
                      decoration: BoxDecoration(
                        color: curso.alumnos[index].asistencia
                            .colorEstado(context),
                        borderRadius: BorderRadius.all(
                          Radius.circular(35.sw),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          curso.alumnos[index].asistencia.nombreEstado(context),
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
      ],
    );
  }
}
