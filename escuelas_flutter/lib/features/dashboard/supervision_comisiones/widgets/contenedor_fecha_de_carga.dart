import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ContenedorFechaDeCarga}
/// Contenedor que muestra la fecha de carga de las calificaciones de una
/// comision o la proporcion de materias cargadas
/// {@endtemplate}
class InformacionComision extends StatelessWidget {
  /// {@macro ContenedorFechaDeCarga}
  const InformacionComision({
    required this.supervisionDeCurso,
    super.key,
  });

  /// Devuelve la cantidad de asignaturas cargadas de una comision
  int get cantidadAsignaturasCargadas {
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
      cantidadAsignaturasCargadas /
      (supervisionDeCurso.comision.solicitudesCalificacionMensual?.length ?? 0);

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

    final l10n = context.l10n;

    final proporcionAsignaturasCargadas =
        l10n.pageComissionSupervisionProportionOfLoadedsubjects(
      cantidadAsignaturasCargadas,
      supervisionDeCurso.comision.solicitudesCalificacionMensual?.length ?? 0,
    );

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
              ? l10n.pageComissionSupervisionWithoutEnabling.toUpperCase()
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
