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
  const VistaCelularCargaDeCalificaciones({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    final l10n = context.l10n;

    return Column(
      children: [
        SelectorDePeriodo(
          delegate: PeriodoMensualDelegate(
            context,
            onAvanzar: (periodo) => context.read<BlocCargaCalificaciones>().add(
                  BlocCargaCalificacionesEventoGuardarPeriodo(periodo: periodo),
                ),
            onRetroceder: (periodo) => context
                .read<BlocCargaCalificaciones>()
                .add(
                  BlocCargaCalificacionesEventoGuardarPeriodo(periodo: periodo),
                ),
          ),
        ),
        SizedBox(height: max(20.ph, 20.sh)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.pw),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'MAATEMATICA', // TODO(mati) poner la materia/asignatura correspondiente
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15.pf,
                  color: colores.onBackground,
                ),
              ),
              Text(
                'PRIMERAO', // TODO(mati) el curso correspondiente
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15.pf,
                  color: colores.onSecondary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: max(10.ph, 10.sh)),
        BlocConsumer<BlocCargaCalificaciones, BlocCargaCalificacionesEstado>(
          listener: (context, state) {
            if (state
                is BlocCargaCalificacionesEstadoFallidoAlEnviarCalificaciones) {
              const DialogErrorAlEnviarCalificaciones().show(context);
            }
            if (state
                is BlocCargaCalificacionesEstadoCalificacionesEnviadasCorrectamente) {
              const DialogNotasEnviadasCorrectamente().show(context);
            }
          },
          builder: (context, state) {
            final calificacion = state.calificacion;

            if (calificacion == null) {
              return Center(
                child: Text(l10n.pageQualificationsNotQualification),
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
                  children: calificacion.alumnos.map(
                    (e) {
                      return TarjetaCargaCalificacionAlumno(
                        alumno: e,
                        fecha: state.periodo?.fechaDesde ?? DateTime.now(),
                        listaCalificaciones: state.listaCalificaciones,
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
        BlocBuilder<BlocCargaCalificaciones, BlocCargaCalificacionesEstado>(
          builder: (context, state) {
            return BotonesEnviarNotasYLimpiarNotas(
              calificacion: state.calificacion,
            );
          },
        ),
        SizedBox(height: max(20.ph, 20.sh)),
      ],
    );
  }
}
