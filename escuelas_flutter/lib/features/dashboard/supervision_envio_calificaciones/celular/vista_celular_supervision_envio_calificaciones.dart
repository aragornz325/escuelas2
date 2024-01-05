import 'package:escuelas_flutter/extensiones/date_time.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/supervision_envio_calificaciones/bloc/bloc_supervision_envio_calificaciones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/utilidades/funciones/nombre_abreviado.dart';
import 'package:escuelas_flutter/widgets/elemento_lista.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/delegates/periodo_delegate.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/delegates/periodo_mensual_delegate.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/selector_de_periodo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularSupervisionEnvioCalificaciones}
/// TODO(anyone): AGREGAR DOCUMENTACION.
/// {@endtemplate}
class VistaCelularSupervisionEnvioCalificaciones extends StatelessWidget {
  /// {@macro VistaCelularSupervisionEnvioCalificaciones}
  const VistaCelularSupervisionEnvioCalificaciones({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return BlocBuilder<BlocSupervisionEnvioCalificaciones,
        BlocSupervisionEnvioCalificacionesEstado>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.pw),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SelectorDePeriodo(
                      delegate: PeriodoMensualDelegate(
                        context,
                        periodo: Periodo(
                          etiqueta:
                              state.fecha?.nombreMes(context).toUpperCase() ??
                                  '',
                          fechaDesde: state.fecha?.copyWith(day: 1) ??
                              DateTime.now().copyWith(day: 1),
                          fechaHasta: DateTime(
                            DateTime.now().year,
                            DateTime.now().month + 1,
                          ).subtract(const Duration(days: 1)),
                        ),
                      ),
                      onSeleccionarPeriodo: (periodo) {},
                      decoration: BoxDecoration(
                        color: colores.tertiary,
                        borderRadius: BorderRadius.circular(40.sw),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 20.pw),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.ph,
                        horizontal: 10.pw,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Asignatura',
                            style: TextStyle(
                              color: colores.onSecondary,
                              fontSize: 12.pf,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Estado',
                            style: TextStyle(
                              color: colores.onSecondary,
                              fontSize: 12.pf,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...state.listaAsignaturas.map(
                      (asignatura) => Padding(
                        padding: EdgeInsets.only(bottom: 10.ph),
                        child: ElementoLista.supervisionEnvioCalificaciones(
                          context: context,
                          // TODO(Gon): Cambiar por fecha de carga de calificaciones (cuando se implemente)
                          fechaDeCarga: asignatura.fechaCreacion,
                          nombreProfesor: obtenerNombreAbreviado(
                            // asignatura.docentes.first.nombre,
                            'Gonzalo Miguel Rigoni',
                          ),
                          nombreAsignatura: asignatura.nombre,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              EscuelasBoton.texto(
                estaHabilitado: true,
                onTap: () {},
                color: colores.azul,
                texto: 'Solicitar calificaciones faltantes (0)',
                context: context,
              ),
            ],
          ),
        );
      },
    );
  }
}
