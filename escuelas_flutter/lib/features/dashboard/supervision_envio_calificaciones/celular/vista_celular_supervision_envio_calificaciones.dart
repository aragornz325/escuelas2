import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/supervision_envio_calificaciones/bloc/bloc_supervision_envio_calificaciones.dart';
import 'package:escuelas_flutter/features/dashboard/supervision_envio_calificaciones/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
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

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

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
              ),
              const _MateriaYEstado(),
              Expanded(
                child: ListaDeAsignaturas(
                  asignaturas: state.listaAsignaturas,
                ),
              ),
              const BotonesEnviarCalificaciones(),
            ],
          ),
        );
      },
    );
  }
}

/// {@template _MateriaYEstado}
/// Muestra dos textos uno de la materia y el otro del estado
/// {@endtemplate}
class _MateriaYEstado extends StatelessWidget {
  /// {@macro _MateriaYEstado}
  const _MateriaYEstado();

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return Padding(
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
    );
  }
}
