import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/features/dashboard/carga_calificaciones/widgets/tarjeta_carga_calificacion/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// {@template TarjetaCargaCalificacion}
/// Componente con un sector donde se puede ver el nombre, promedio y texto
/// valorativo del alumno. Con un boton para agregar/modificar la calificacion
/// {@endtemplate}
class TarjetaCargaCalificacion extends StatefulWidget {
  /// {@macro TarjetaCargaCalificacion}
  const TarjetaCargaCalificacion({
    required this.alumno,
    this.esEditable = true,
    this.calificacion,
    super.key,
  });

  /// Alumno a calificar
  final Usuario? alumno;

  /// Indica si se puede editar la calificacion
  final bool esEditable;

  /// Calificacion del alumno
  final String? calificacion;

  @override
  State<TarjetaCargaCalificacion> createState() =>
      _TarjetaCargaCalificacionState();
}

class _TarjetaCargaCalificacionState extends State<TarjetaCargaCalificacion> {
  @override
  Widget build(BuildContext context) {
    final calificacion =
        widget.calificacion == 'S/C' || widget.calificacion == null
            ? '0'
            : widget.calificacion!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InformacionAlumno(
          calificacion: calificacion,
          nombreAlumno: widget.alumno?.nombre ?? '',
        ),
        BotonCargaCalificacion(
          calificacion: calificacion,
          esEditable: widget.esEditable,
          idAlumno: widget.alumno?.id ?? 0,
        ),
      ],
    );
  }
}
