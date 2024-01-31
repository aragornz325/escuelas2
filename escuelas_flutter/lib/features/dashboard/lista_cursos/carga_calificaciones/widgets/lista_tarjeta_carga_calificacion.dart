import 'package:collection/collection.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_commons/manejo_de_calificaciones/manejo_de_calificaciones.dart';
import 'package:escuelas_flutter/features/dashboard/lista_cursos/carga_calificaciones/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ListaTarjetaCargaCalificacion}
/// Lista de tarjetas de carga de calificaciones
/// {@endtemplate}
class ListaTarjetaCargaCalificacion extends StatelessWidget {
  /// {@macro ListaTarjetaCargaCalificacion}
  const ListaTarjetaCargaCalificacion({
    required this.listaEstudiantes,
    required this.listaCalificacionesMesActual,
    required this.listaCalificacionesMesesRestantes,
    super.key,
  });

  /// Lista de Estudiantes
  final List<RelacionComisionUsuario> listaEstudiantes;

  /// Lista de Calificaciones del mes actual
  final List<CalificacionMensual> listaCalificacionesMesActual;

  /// Lista de Calificaciones de meses anteriores al actual
  final List<List<CalificacionMensual>> listaCalificacionesMesesRestantes;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: listaEstudiantes.map(
            (relacionComisionUsuario) {
              final calificacion = listaCalificacionesMesActual
                  .firstWhereOrNull(
                    (calificacionMensual) =>
                        calificacionMensual.calificacion?.estudianteId ==
                        relacionComisionUsuario.usuario?.id,
                  )
                  ?.calificacion;

              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 5.ph,
                  horizontal: 15.pw,
                ),
                child: TarjetaCargaCalificacion(
                  listaCalificacionesMesesRestantes:
                      listaCalificacionesMesesRestantes,
                  alumno: relacionComisionUsuario.usuario,
                  calificacion: calificacion == null
                      ? 'S/C' // TODO(anyone): l10n
                      : ManejadorDeCalificaciones.obtenerValorDeCalificacion(
                          calificacion.tipoCalificacion,
                          calificacion.index,
                        ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
