import 'dart:math';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/carga_calificaciones/bloc_carga_calificaciones/bloc_carga_calificaciones.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';
import 'package:rolemissions/rolemissions.dart';

/// {@template TarjetaCargaCalificacionAlumno}
/// Tarjeta de Carga de Calificación de Alumno con un campo para modificar la
/// calificación.
/// {@endtemplate}
class TarjetaCargaCalificacionAlumno extends StatelessWidget {
  /// {@macro TarjetaCargaCalificacionAlumno}
  const TarjetaCargaCalificacionAlumno({
    required this.fecha,
    required this.curso,
    required this.relacionComisionUsuario,
    this.rolDelUsuario,
    super.key,
  });

  /// Fecha actual de la calificación del alumno.
  final DateTime fecha;

  ///
  final ComisionDeCurso curso;

  /// Alumno con la calificación previa.
  final RelacionComisionUsuario relacionComisionUsuario;

  /// Rol del usuario.
  final Role? rolDelUsuario;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocCargaCalificaciones, BlocCargaCalificacionesEstado>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: max(5.ph, 5.sh),
            horizontal: 15.pw,
          ),
          child: EscuelasCargaCalificacionAlumno(
            onChanged: (v) => context.read<BlocCargaCalificaciones>().add(
                  BlocCargaCalificacionesEventoCambiarCalificacionAlumno(
                    calificacion: int.tryParse(v),
                    fecha: fecha,
                    idAlumno: curso.cursoId,
                  ),
                ),
            // TODO(anyone): reemplazar por las calificaciones previas ver como
            // vienen las calificaciones previas y mostrarlas
            listaCalificaciones: const [],
            // TODO(anyone): ver si los modelos seran utilizados de esta forma
            // para traer solamente la calificacion del alumno
            calificacionPrevia: state.listaCalificaciones
                .firstWhere(
                  (c) =>
                      c.id ==
                      state.listaCalificacionesCompensadas
                          .firstWhere(
                            (cc) =>
                                cc.idEstudiante ==
                                relacionComisionUsuario.usuarioId,
                          )
                          .id,
                  // TODO(ANYONE): Cambiar por el id correspondiente, cuadno
                  // este lo de back
                )
                .id
                .toString(),
            // TODO(ANYONE): Cambiar por el id correspondiente, cuando este lo
            // de back
            nombreAlumno: '${relacionComisionUsuario.usuario?.nombre} '
                '${relacionComisionUsuario.usuario?.apellido}',
            esEditable: rolDelUsuario?.name == 'docente'
                ? fecha.mismaFecha(DateTime.now())
                : rolDelUsuario?.name == 'directivo' &&
                    fecha.isBefore(DateTime.now()),
          ),
        );
      },
    );
  }
}
