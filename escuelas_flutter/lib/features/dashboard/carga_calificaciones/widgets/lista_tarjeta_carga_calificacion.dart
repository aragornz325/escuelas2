import 'package:collection/collection.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/features/dashboard/carga_calificaciones/modelos/modelos.dart';
import 'package:escuelas_flutter/features/dashboard/carga_calificaciones/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ListaTarjetaCargaCalificacion}
/// Lista de tarjetas de carga de calificaciones
/// {@endtemplate}
class ListaTarjetaCargaCalificacion extends StatelessWidget {
  /// {@macro ListaTarjetaCargaCalificacion}
  const ListaTarjetaCargaCalificacion({
    required this.listaEstudiantes,
    required this.listaCalificaciones,
    super.key,
  });

  final List<RelacionComisionUsuario> listaEstudiantes;

  final List<CalificacionDeAlumno> listaCalificaciones;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: listaEstudiantes.map(
            (relacionComisionUsuario) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 5.ph,
                  horizontal: 15.pw,
                ),
                child: TarjetaCargaCalificacion(
                  alumno: relacionComisionUsuario.usuario,
                  calificacion: listaCalificaciones
                          .firstWhereOrNull(
                            (calificacionDeAlumno) =>
                                calificacionDeAlumno.idAlumno ==
                                relacionComisionUsuario.usuario?.id,
                          )
                          ?.calificacion ??
                      'S/C',
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
