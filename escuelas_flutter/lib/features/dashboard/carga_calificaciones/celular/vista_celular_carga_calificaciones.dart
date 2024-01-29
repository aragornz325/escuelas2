import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/carga_calificaciones/bloc_carga_calificaciones/bloc_carga_calificaciones.dart';
import 'package:escuelas_flutter/features/dashboard/carga_calificaciones/widgets/popups/dialogs.dart';
import 'package:escuelas_flutter/features/dashboard/carga_calificaciones/widgets/widgets.dart';
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return BlocConsumer<BlocCargaCalificaciones, BlocCargaCalificacionesEstado>(
      listener: (context, state) {
        if (state.falloAlEnviarCalificaciones) {
          showDialog<void>(
            context: context,
            builder: (context) => const DialogErrorAlEnviarCalificaciones(),
          );
        }
        if (state.exitoAlEnviarCalificaciones) {
          showDialog<void>(
            context: context,
            builder: (context) => const DialogNotasEnviadasCorrectamente(),
          );
        }
      },
      builder: (context, state) {
        if (state is BlocCargaCalificacionesEstadoCargando) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: [
            SelectorDePeriodo(
              delegate: PeriodoMensualDelegate(context),
              onSeleccionarPeriodo: (periodo) =>
                  context.read<BlocCargaCalificaciones>().add(
                        BlocCargaCalificacionesEventoGuardarFecha(
                          fecha: periodo.fechaDesde,
                        ),
                      ),
              decoration: BoxDecoration(
                color: colores.tertiary,
                borderRadius: BorderRadius.circular(40.sw),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20.pw),
            ),
            NombreAsignaturaYComision(
              nombreAsignatura: state.asignatura?.nombre ?? '',
              nombreComision: state.comision?.nombre ?? '',
            ),
            ListaTarjetaCargaCalificacion(
              listaCalificaciones: state.listaCalificaciones,
              listaEstudiantes: state.estudiantes,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.ph),
              child: const BotonesEnviarNotasYLimpiarNotas(),
            ),
          ],
        );
      },
    );
  }
}
