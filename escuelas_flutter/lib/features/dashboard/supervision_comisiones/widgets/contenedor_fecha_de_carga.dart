import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/utilidades/funciones/colores.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

class ContenedorFechaDeCarga extends StatelessWidget {
  const ContenedorFechaDeCarga({
    required this.supervisionDeCurso,
    super.key,
  });

  int cantidadAsignaturasCargadas({
    required SupervisionDeCurso supervisionDeCurso,
  }) {
    var cant = 0;
    final lista =
        supervisionDeCurso.comision.solicitudesCalificacionMensual ?? [];
    for (final solicitud in lista) {
      if (solicitud.solicitud != null) {
        cant++;
      }
    }
    return cant;
  }

  bool get todasAsignaturasCargadas =>
      supervisionDeCurso.comision.solicitudesCalificacionMensual?.every(
        (element) => element.solicitud?.fechaRealizacion != null,
      ) ??
      false;

  final SupervisionDeCurso supervisionDeCurso;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final tieneSolicitudesCalificacionMensual =
        supervisionDeCurso.comision.solicitudesCalificacionMensual != null &&
            (supervisionDeCurso
                    .comision.solicitudesCalificacionMensual?.isNotEmpty ??
                false);

    final todasAsignaturasCargadas = cantidadAsignaturasCargadas(
          supervisionDeCurso: supervisionDeCurso,
        ) ==
        supervisionDeCurso.comision.solicitudesCalificacionMensual?.length;

    final ratio = cantidadAsignaturasCargadas(
          supervisionDeCurso: supervisionDeCurso,
        ) /
        (supervisionDeCurso.comision.solicitudesCalificacionMensual?.length ??
            0);
    final fechaDeCargaDeLaUltimaAsignatura = tieneSolicitudesCalificacionMensual
        ? supervisionDeCurso.comision.solicitudesCalificacionMensual
                ?.map((e) => e.solicitud?.fechaRealizacion)
                .reduce((DateTime? value, DateTime? element) {
              if (value == null) {
                return element;
              } else if (element == null) {
                return value;
              } else {
                return value.isAfter(element) ? value : element;
              }
            }) ??
            DateTime.now()
        : DateTime.now();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.pw),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(30.sw),
        ),
        color: tieneSolicitudesCalificacionMensual
            ? todasAsignaturasCargadas
                ? Colores(context).segunVencimientoSegunFecha(
                    dia: fechaDeCargaDeLaUltimaAsignatura.day,
                  )
                : Colores(context).segunProporcionDeMateriasCargadas(
                    proporcion: ratio,
                  )
            : colores.grisDeshabilitado,
      ),
      child: Center(
        child: Text(
          supervisionDeCurso.comision.solicitudesCalificacionMensual == null ||
                  (supervisionDeCurso
                          .comision.solicitudesCalificacionMensual?.isEmpty ??
                      true)
              ? 'SIN HABILITAR'
              : todasAsignaturasCargadas
                  ? fechaDeCargaDeLaUltimaAsignatura.formatear
                  : '${cantidadAsignaturasCargadas(
                      supervisionDeCurso: supervisionDeCurso,
                    )} de '
                      '${supervisionDeCurso.comision.solicitudesCalificacionMensual?.length}',
          style: TextStyle(
            color: colores.background,
            fontSize: 15.pf,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
