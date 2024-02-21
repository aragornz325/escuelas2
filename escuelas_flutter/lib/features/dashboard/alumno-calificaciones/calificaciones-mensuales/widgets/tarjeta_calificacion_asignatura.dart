import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/alumno-calificaciones/calificaciones-mensuales/widgets/boton_ingresar_asignatura.dart';
import 'package:escuelas_flutter/features/dashboard/lista_cursos/carga_calificaciones/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// {@template TarjetaCalificacionAsignatura}
/// Componente con un sector donde se puede ver el nombre, promedio,
/// calificacion y texto valorativo del alumno.
/// {@endtemplate}
class TarjetaCalificacionAsignatura extends StatelessWidget {
  /// {@macro TarjetaCalificacionAsignatura}
  const TarjetaCalificacionAsignatura({
    this.calificacion,
    super.key,
  });

  /// Calificacion del alumno
  final CalificacionMensual? calificacion;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InformacionAlumnoOAsignatura(
          // TODO(ANYONE): Cambiar con promedio cuando este en el modelo /Base de datos.
          promedio: calificacion?.calificacion?.index.toDouble() ?? 0,
          tituloTarjeta:
              calificacion?.calificacion?.asignatura?.nombre.capitalize ?? '',
          esInfoAlumno: false,
          idAsignatura: calificacion?.calificacion?.asignaturaId,
        ),
        ElementoCalificacion(
          calificacion: calificacion?.calificacion?.index,
        ),
      ],
    );
  }
}
