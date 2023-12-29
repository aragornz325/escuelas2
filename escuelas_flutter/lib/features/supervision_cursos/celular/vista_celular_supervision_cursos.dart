import 'package:escuelas_flutter/extensiones/date_time.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/supervision_cursos/bloc/bloc_supervision_cursos.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/utilidades/funciones/colores.dart';
import 'package:escuelas_flutter/widgets/selector_de_fecha/selector_de_fecha.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';
import 'package:intl/intl.dart';

/// {@template VistaCelularSupervisionCursos}
/// TODO(anyone): AGREGAR DOCUMENTACION.
/// {@endtemplate}
class VistaCelularSupervisionCursos extends StatelessWidget {
  /// {@macro VistaCelularSupervisionCursos}
  const VistaCelularSupervisionCursos({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Scaffold(
      body: BlocBuilder<BlocSupervisionCursos, BlocSupervisionCursosEstado>(
        builder: (context, state) {
          return Column(
            children: [
              const SelectorDeFecha(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: state.listaCursos
                        .map(
                          (e) => Padding(
                            padding: EdgeInsets.only(bottom: 15.ph),
                            child: ElementoLista.supervisionCurso(
                              context: context,
                              onTap: () {},
                              nombreCurso: e.nombre,
                              colorFondo: state.todasMateriasCargadas
                                  ? colores.primaryContainer
                                  : colores.onSecondary,
                              widgetLateralDerecho: state
                                      .habilitacionCargaDeCalificaciones
                                  ? Container(
                                      width: 80.pw,
                                      height: 55.ph,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30.sw),
                                        ),
                                        color: state
                                                .habilitacionCargaDeCalificaciones
                                            ? state.todasMateriasCargadas
                                                ? Colores(context)
                                                    .segunVencimientoSegunFecha(
                                                    dia: 9,
                                                  )
                                                : Colores(context)
                                                    .segunProporcionDeMateriasCargadas(
                                                    proporcion: .4,
                                                  )
                                            : colores.background,
                                      ),
                                      child: Center(
                                        child: Text(
                                          state.todasMateriasCargadas
                                              ? state.fechaUltimaMateriaCargada
                                                  .formatear
                                              : '4/12',
                                          style: TextStyle(
                                            color: colores.background,
                                            fontSize: 15.pf,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(right: 10.pw),
                                      child: Text(
                                        'SIN HABILITAR . 0/12',
                                        style: TextStyle(
                                          fontSize: 15.pf,
                                          fontWeight: FontWeight.w600,
                                          color: colores.onPrimary,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.ph),
                child: Center(
                  child: Text(
                    'Fecha final de envio: ${state.fechaUltimaMateriaCargada.formatear}',
                    style: TextStyle(
                      color: colores.grisSC,
                      fontSize: 16.pf,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
