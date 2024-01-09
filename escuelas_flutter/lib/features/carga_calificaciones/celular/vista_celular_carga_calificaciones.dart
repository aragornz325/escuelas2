import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/carga_calificaciones/bloc_carga_calificaciones/bloc_carga_calificaciones.dart';
import 'package:escuelas_flutter/features/carga_calificaciones/widgets/popups/popups.dart';
import 'package:escuelas_flutter/features/carga_calificaciones/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/delegates/periodo_mensual_delegate.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/selector_de_periodo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularCargaDeCalificaciones}
/// Vista para `celular` de la pagina 'Carga de Calificaciones'
/// {@endtemplate}
class VistaCelularCargaDeCalificaciones extends StatelessWidget {
  /// {@macro VistaCelularCargaDeCalificaciones}
  const VistaCelularCargaDeCalificaciones({
    required this.nombreAsignatura,
    required this.fecha,
    super.key,
  });

  /// Fecha actual de la calificación del alumno.
  final DateTime fecha;

  /// Nombre del curso
  final String nombreAsignatura;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return Column(
      children: [
        SelectorDePeriodo(
          delegate: PeriodoMensualDelegate(context),
          onSeleccionarPeriodo: (periodo) =>
              context.read<BlocCargaCalificaciones>().add(
                    BlocCargaCalificacionesEventoGuardarFecha(fecha: fecha),
                  ),
          decoration: BoxDecoration(
            color: colores.tertiary,
            borderRadius: BorderRadius.circular(40.sw),
          ),
          margin: EdgeInsets.symmetric(horizontal: 20.pw),
        ),
        SizedBox(height: max(20.ph, 20.sh)),
        BlocBuilder<BlocCargaCalificaciones, BlocCargaCalificacionesEstado>(
          builder: (context, state) {
            final curso = state.curso;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.pw),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    nombreAsignatura,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15.pf,
                      color: colores.onSecondary,
                    ),
                  ),
                  if (curso != null)
                    Text(
                      curso.nombre,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15.pf,
                        color: colores.onBackground,
                      ),
                    )
                  else
                    const CircularProgressIndicator(),
                ],
              ),
            );
          },
        ),
        SizedBox(height: max(10.ph, 10.sh)),
        BlocConsumer<BlocCargaCalificaciones, BlocCargaCalificacionesEstado>(
          listener: (context, state) {
            if (state.falloAlEnviarCalificaciones) {
              const DialogErrorAlEnviarCalificaciones().show(context);
            }
            if (state.exitoAlEnviarCalificaciones) {
              const DialogNotasEnviadasCorrectamente().show(context);
            }
          },
          builder: (context, state) {
            final curso = state.curso;

            if (curso == null) {
              return Center(
                child: Text(l10n.pageGradesNoGrades),
              );
            }

            if (state is BlocCargaCalificacionesEstadoCargando) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: state.estudiantes.map(
                    (e) {
                      return TarjetaCargaCalificacionAlumno(
                        curso: curso,
                        relacionComisionUsuario: e,
                        fecha: state.fecha ?? DateTime.now(),
                        rolDelUsuario: state.rolDelUsuario,
                      );
                    },
                  ).toList(),
                ),
              ),
            );
          },
        ),
        SizedBox(height: max(10.ph, 10.sh)),
        const BotonesEnviarNotasYLimpiarNotas(),
        SizedBox(height: max(20.ph, 20.sh)),
      ],
    );
  }
}
