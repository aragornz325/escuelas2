import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/supervision_comisiones/bloc/bloc_supervision_comisiones.dart';
import 'package:escuelas_flutter/features/dashboard/supervision_comisiones/widgets/contenedor_fecha_de_carga.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/elemento_lista.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

class ListaComisiones extends StatelessWidget {
  const ListaComisiones({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Expanded(
      child: BlocBuilder<BlocSupervisionComisiones,
          BlocSupervisionComisionesEstado>(
        builder: (context, state) {
          return ListView(
            children: state.listaComisiones
                .map(
                  (supervisionComision) => Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.ph,
                      horizontal: 20.pw,
                    ),
                    child: ElementoLista.supervisionComision(
                      context: context,
                      onTap: () => context.router.push(
                        RutaSupervisionEnvioCalificaciones(
                          idCurso: supervisionComision.comision.id ?? 0,
                          fecha: state.fecha.toString(),
                        ),
                      ),
                      nombreComision: supervisionComision.comision.nombre,
                      colorFondo:
                          supervisionComision.fechaDeNotificacion != null
                              ? colores.primaryContainer
                              : colores.grisDeshabilitado,
                      widgetLateralDerecho: ContenedorFechaDeCarga(
                        supervisionDeCurso: supervisionComision,
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
