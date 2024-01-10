import 'dart:math';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/date_time.dart';
import 'package:escuelas_flutter/extensiones/comision_de_curso.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/inasistencias/bloc_inasistencias/bloc_inasistencias.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ItemCurso}
/// Un curso cuando no esta desplegado.
/// {@endtemplate}
class ItemCurso extends StatelessWidget {
  /// {@macro ItemCurso}
  const ItemCurso({
    required this.onTap,
    required this.comisionDeCurso,
    this.ancho,
    super.key,
  });

  /// OnTap del item.
  final VoidCallback onTap;

  /// Lista de cursos a mostrar
  final ComisionDeCurso comisionDeCurso;

  /// ancho modificable en caso de que quiera cambiarlo
  final double? ancho;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: max(7.ph, 7.sh),
        horizontal: 15.pw,
      ),
      child: InkWell(
        onTap: onTap,
        child: BlocBuilder<BlocInasistencias, BlocInasistenciasEstado>(
          builder: (context, state) {
            //Cantidad de estudiantes presentes.
            final estudiantesPresentes = comisionDeCurso.cantidadDeNoAusentes(
                state.asistenciasDiarias(comisionDeCurso.id ?? 0));

            return ElementoLista(
              ancho: ancho ?? 300.pw,
              altura: max(50.ph, 50.sh),
              borderRadius: 50,
              texto: Text(
                comisionDeCurso.nombre.toUpperCase(),
                style: TextStyle(
                  color: comisionDeCurso.ultimaModificacion.mismaFecha(
                    state.fechaActual ?? DateTime.now(),
                  )
                      ? colores.onBackground
                      : colores.onSecondary,
                  fontSize: 16.pf,
                  fontWeight: FontWeight.w800,
                ),
              ),
              widgetLateralDerecho: Padding(
                padding: EdgeInsets.only(right: 10.pw),
                child: Text(
                  '$estudiantesPresentes'
                  '/${comisionDeCurso.estudiantes?.length ?? 0}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colores.onSecondary,
                    fontSize: 16.pf,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
