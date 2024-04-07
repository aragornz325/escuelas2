import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_commons/manejo_de_calificaciones/manejo_de_calificaciones.dart';
import 'package:escuelas_flutter/features/dashboard/lista_cursos/carga_calificaciones/widgets/widgets.dart';
import 'package:escuelas_flutter/utilidades/funciones/funciones.dart';
import 'package:flutter/material.dart';

/// {@template TarjetaCargaCalificacion}
/// Componente con un sector donde se puede ver el nombre, promedio y texto
/// valorativo del alumno. Con un boton para agregar/modificar la calificacion
/// {@endtemplate}
class TarjetaCargaCalificacion extends StatelessWidget {
  /// {@macro TarjetaCargaCalificacion}
  const TarjetaCargaCalificacion({
    required this.listaCalificacionesMesesRestantes,
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

  /// Lista de Calificaciones de meses anteriores al actual
  final List<List<CalificacionMensual>> listaCalificacionesMesesRestantes;

  double _promedioDeCalificacionesRestantesYActual() {
    final listaValorCalificacionesMesessRestantes =
        listaCalificacionesMesesRestantes
            .expand(
              (listaCalificacionesPorMes) => listaCalificacionesPorMes
                  .where(
                    (calMensual) =>
                        calMensual.calificacion?.estudianteId == alumno?.id,
                  )
                  .toList(),
            )
            .map(
              (calificacionMensual) =>
                  ManejadorDeCalificaciones.obtenerValorDeCalificacion(
                calificacionMensual.calificacion?.tipoCalificacion ??
                    TipoCalificacion.numericoDecimal,
                calificacionMensual.calificacion?.index ?? 0,
              ),
            )
            .toList()
          ..add(calificacion ?? 'S/C');

    final listaParaPromedio = listaValorCalificacionesMesessRestantes
        .map(
          (calificacion) => calificacion == 'S/C'
              ? double.parse('0')
              : double.parse(calificacion),
        )
        .toList();
    return calcularPromedio(listaParaPromedio);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InformacionAlumnoOAsignatura(
          promedio: _promedioDeCalificacionesRestantesYActual(),
          tituloTarjeta: "${alumno?.apellido} ${alumno?.nombre}",
        ),
        BotonCargaCalificacion(
          calificacion: calificacion ?? 'S/C',
          esEditable: esEditable,
          idAlumno: alumno?.id ?? 0,
        ),
      ],
    );
  }
}
