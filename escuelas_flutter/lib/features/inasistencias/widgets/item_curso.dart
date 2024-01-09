import 'dart:math';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/date_time.dart';
import 'package:escuelas_flutter/extensiones/extension_curso.dart';
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
    required this.curso,
    this.ancho,
    super.key,
  });

  /// OnTap del item.
  final VoidCallback onTap;

  /// Lista de cursos a mostrar
  final ComisionDeCurso curso;

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
        child: ElementoLista(
          ancho: ancho ?? 300.pw,
          borderRadius: 50,
          texto: Text(
            curso.nombre.toUpperCase(),
            style: TextStyle(
              color: curso.ultimaModificacion.mismaFecha(
                DateTime.now(),
              ) //TODO(anyone): cambiar por la fecha del calendario
                  ? colores.onBackground
                  : colores.onSecondary,
              fontSize: 16.pf,
              fontWeight: FontWeight.w800,
            ),
          ),
          widgetLateralDerecho:
              BlocBuilder<BlocInasistencias, BlocInasistenciasEstado>(
            builder: (context, state) {
              return Text(
                '${curso.cantidadDeNoAusentes(state.asistenciasDiarias(curso.idCurso))}'
                '/${curso.cursadas?.length ?? 0}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colores.onSecondary,
                  fontSize: 16.pf,
                  fontWeight: FontWeight.w700,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
