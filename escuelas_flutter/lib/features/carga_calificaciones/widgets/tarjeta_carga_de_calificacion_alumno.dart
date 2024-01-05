import 'dart:math';

import 'package:escuelas_flutter/features/asistencias/bloc_asistencias/bloc_asistencias.dart';
import 'package:escuelas_flutter/features/carga_calificaciones/bloc_carga_calificaciones/bloc_carga_calificaciones.dart';
import 'package:escuelas_flutter/features/modelos_temporales.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template TarjetaCargaCalificacionAlumno}
/// Tarjeta de Carga de Calificación de Alumno con un campo para modificar la
/// calificación.
/// {@endtemplate}
class TarjetaCargaCalificacionAlumno extends StatelessWidget {
  /// {@macro TarjetaCargaCalificacionAlumno}
  const TarjetaCargaCalificacionAlumno({
    required this.fecha,
    required this.listaCalificaciones,
    required this.alumno,
    this.rolDelUsuario,
    super.key,
  });

  /// Fecha actual de la calificación del alumno.
  final DateTime fecha;

  // TODO(anyone): reemplazar modelo

  /// Lista de calificaciones previas del alumno.
  final List<ModeloCalificacion> listaCalificaciones;

  /// Alumno con la calificación previa.
  final ModeloAlumno alumno;

  /// Rol del usuario.
  final Rol? rolDelUsuario;

  @override
  Widget build(BuildContext context) {
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
                idAlumno: alumno.id,
              ),
            ),
        nombreAlumno: alumno.nombre,
        calificacionPrevia:

            // TODO(anyone): ver otro condicional por que
            //viene un tipo int? cuando es un String?
            (alumno.calificacion) != null
                ? alumno.calificacion.toString()
                : null,
        listaCalificaciones: _obtenerCalificacionesPrevias(
          listaCalificaciones,
          alumno.id,
          DateTime.now(),
        ),
        // TODO(anyone): reemplazar por los roles reales
        esEditable: rolDelUsuario?.nombre == 'docente'
            ? fecha.month == DateTime.now().month &&
                fecha.day == DateTime.now().day
            : rolDelUsuario?.nombre == 'directivo' &&
                fecha.isBefore(DateTime.now()),
      ),
    );
  }

  // TODO(anyone): ver si esta bien la funcion si depende de las notas
  // anteriores del mes en el que esta o de todas

  /// Obtiene las calificaciones previas del usuario en el mes y año actual.
  List<double> _obtenerCalificacionesPrevias(
    List<ModeloCalificacion> lista,
    int idUsuario,
    DateTime fechaActual,
  ) {
    final calificacionesPrevias = <double>[];

    for (final calificacion in lista) {
      final fechaCalificacion = calificacion.fecha;

      // Verificar si la calificación pertenece al usuario y si no es del día
      // actual
      if (calificacion.alumnos.any((alumno) => alumno.id == idUsuario) &&
          !_esMismoDia(fechaCalificacion, DateTime.now())) {
        // Agregar la calificación a la lista de calificaciones previas
        final calificacionUsuario = calificacion.alumnos
            .firstWhere((alumno) => alumno.id == idUsuario)
            .calificacion
            ?.toDouble();
        calificacionesPrevias.add(calificacionUsuario ?? 0);
      }
    }

    return calificacionesPrevias;
  }

  /// Verifica si dos fechas son del mismo mes y año.
  bool _esMismoDia(DateTime fecha1, DateTime fecha2) {
    return fecha1.year == fecha2.year && fecha1.month == fecha2.month;
  }
}
