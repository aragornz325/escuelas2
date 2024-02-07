import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/supervision_envio_calificaciones/bloc/bloc_supervision_envio_calificaciones.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
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
/// Vista para celular de la pagina 'Supervision de Envio de Calificaciones'
/// {@endtemplate}
class VistaCelularSupervisionEnvioCalificaciones extends StatelessWidget {
  /// {@macro VistaCelularSupervisionEnvioCalificaciones}
  const VistaCelularSupervisionEnvioCalificaciones({super.key});

  // ignore: avoid_field_initializers_in_const_classes
  final eventoSolicitarCaliFaltantes =
      const BlocSupervisionEnvioCalificacionesEventoSolicitarCaliFaltantes();
  // ignore: avoid_field_initializers_in_const_classes
  final eventoEnviarCalificaciones =
      const BlocSupervisionEnvioCalificacionesEventoEnviarCalificaciones();

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return BlocBuilder<BlocSupervisionEnvioCalificaciones,
        BlocSupervisionEnvioCalificacionesEstado>(
      builder: (context, state) {
        if (state is BlocSupervisionEnvioCalificacionesEstadoCargando) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final etiqueta = state.fecha?.nombreMes(context).toUpperCase() ?? '';

        final fechaDesde =
            state.fecha?.copyWith(day: 1) ?? DateTime.now().copyWith(day: 1);

        final fechaHasta = DateTime(
          DateTime.now().year,
          DateTime.now().month + 1,
        ).subtract(const Duration(days: 1));

        final envioDeCalificaciones =
            context.read<BlocSupervisionEnvioCalificaciones>().add(
                  eventoSolicitarCaliFaltantes,
                );

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.pw),
          child: Column(
            children: [
              SelectorDePeriodo(
                delegate: PeriodoMensualDelegate(
                  context,
                  periodo: PeriodoDelSelector(
                    etiqueta: etiqueta,
                    fechaDesde: fechaDesde,
                    fechaHasta: fechaHasta,
                  ),
                ),
                onSeleccionarPeriodo: (periodo) =>
                    context.read<BlocSupervisionEnvioCalificaciones>().add(
                          BlocSupervisionEnvioCalificacionesEventoInicializar(
                            fecha: periodo.fechaDesde,
                          ),
                        ),
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
                      l10n.commonSubject,
                      style: TextStyle(
                        color: colores.onSecondary,
                        fontSize: 12.pf,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      l10n.commonState,
                      style: TextStyle(
                        color: colores.onSecondary,
                        fontSize: 12.pf,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: state.listaAsignaturas
                        .map(
                          (asignatura) => Padding(
                            padding: EdgeInsets.only(bottom: 10.ph),
                            child: ElementoLista.supervisionEnvioCalificaciones(
                              context: context,
                              // TODO(Gon): Cambiar por fecha de carga de
                              // calificaciones (cuando se implemente)
                              fechaDeCarga: DateTime.now(),
                              nombreProfesor: obtenerNombreAbreviado(
                                // asignatura.docentes.first.nombre,
                                'Gonzalo Miguel Rigoni',
                              ),
                              nombreAsignatura: asignatura.nombre,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.ph),
                child: EscuelasBoton.texto(
                  estaHabilitado: true,
                  onTap: () => envioDeCalificaciones,
                  color: colores.azul,
                  texto: l10n.pageGradeSubmissionSupervisionButton(
                    state.asignaturasFaltantes.length,
                  ),
                  context: context,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.ph),
                child: EscuelasBoton.outlined(
                  estaHabilitado: true,
                  onTap: () => context
                      .read<BlocSupervisionEnvioCalificaciones>()
                      .add(eventoEnviarCalificaciones),
                  color: colores.primary,
                  texto: 'Enviar calificaciones',
                  context: context,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
