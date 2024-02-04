import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

class ContenedorFechaDeCarga extends StatelessWidget {
  const ContenedorFechaDeCarga({
    required this.supervisionDeCurso,
    super.key,
  });

  /// Devuelve la cantidad de asignaturas cargadas de una comision
  int cantidadAsignaturasCargadas({
    required SupervisionDeCurso supervisionDeCurso,
  }) {
    var cant = 0;
    final lista =
        supervisionDeCurso.comision.solicitudesCalificacionMensual ?? [];
    for (final solicitud in lista) {
      if (solicitud.solicitud?.fechaRealizacion != null) {
        cant++;
      }
    }
    return cant;
  }

  /// Devuelve un color que tan tarde se cargaron las notas
  Color colorSegunVencimientoSegunFecha({
    required BuildContext context,
    required int dia,
  }) {
    final colores = context.colores;
    if (dia > 0 && dia <= 4) {
      return colores.verdeConfirmar;
    } else if (dia > 4 && dia <= 6) {
      return colores.verdeTEA;
    } else if (dia > 6 && dia <= 8) {
      return colores.naranjaTEP;
    } else if (dia > 8 && dia >= 9) {
      return colores.rojoTED;
    } else {
      return colores.onSecondary;
    }
  }

  /// Devuelve un color segun la proporcion de materias cargadas (la proporcion
  /// debe ser un valor entre 0 y 1)
  Color colorSegunProporcionDeMateriasCargadas({
    required BuildContext context,
    required double proporcion,
  }) {
    final colores = context.colores;
    if (proporcion >= .8) {
      return colores.verdeConfirmar;
    } else if (proporcion >= 0.6) {
      return colores.naranjaMediaFalta;
    } else {
      return colores.error;
    }
  }

  /// Devuelve si todas las asignaturas de una comision estan cargadas
  bool get todasAsignaturasCargadas =>
      supervisionDeCurso.comision.solicitudesCalificacionMensual?.every(
        (element) => element.solicitud?.fechaRealizacion != null,
      ) ??
      false;

  /// Devuelve si hay solicitudes de calificacion mensual
  bool get haySolicitudes =>
      supervisionDeCurso.comision.solicitudesCalificacionMensual != null &&
      (supervisionDeCurso.comision.solicitudesCalificacionMensual?.isNotEmpty ??
          false);

  /// Devuelve la proporcion de materias cargadas
  double get proporcion =>
      cantidadAsignaturasCargadas(
        supervisionDeCurso: supervisionDeCurso,
      ) /
      (supervisionDeCurso.comision.solicitudesCalificacionMensual?.length ?? 0);

  /// Devuelve la cantidad de asignaturas cargadas sobre la cantidad de
  /// asignaturas que tiene la comision
  String get proporcionAsignaturasCargadas => '${cantidadAsignaturasCargadas(
        supervisionDeCurso: supervisionDeCurso,
      )} de '
      '${supervisionDeCurso.comision.solicitudesCalificacionMensual?.length}';

  /// Devuelve la fecha de carga de la ultima asignatura cargada
  DateTime? get fechaDeCargaDeLaUltimaAsignatura => haySolicitudes
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
        })
      : null;

  /// Objeto de donde se obtiene la informacion de la comision
  final SupervisionDeCurso supervisionDeCurso;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Container(
      constraints: BoxConstraints(
        minWidth: 90.pw,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.pw),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(30.sw),
        ),
        color: haySolicitudes
            ? todasAsignaturasCargadas
                ? colorSegunVencimientoSegunFecha(
                    context: context,
                    dia: fechaDeCargaDeLaUltimaAsignatura?.day ?? 0,
                  )
                : colorSegunProporcionDeMateriasCargadas(
                    context: context,
                    proporcion: proporcion,
                  )
            : colores.grisDeshabilitado,
      ),
      child: Center(
        child: Text(
          !haySolicitudes
              ? 'SIN HABILITAR'
              : todasAsignaturasCargadas
                  ? fechaDeCargaDeLaUltimaAsignatura?.formatear ?? ''
                  : proporcionAsignaturasCargadas,
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
