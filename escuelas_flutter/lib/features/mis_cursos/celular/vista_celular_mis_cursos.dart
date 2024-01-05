import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/mis_cursos/bloc/bloc_mis_cursos.dart';
import 'package:escuelas_flutter/features/mis_cursos/widgets/item_materia.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/delegates/periodo_mensual_delegate.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/selector_de_periodo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularMisCursos}
/// Vista para celular de la pagina 'Mis Cursos' donde se muestra una lista de
/// las materias ordenas por curso
/// {@endtemplate}
class VistaCelularMisCursos extends StatelessWidget {
  /// {@macro VistaCelularMisCursos}
  const VistaCelularMisCursos({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Column(
      children: [
        SelectorDePeriodo(
          delegate: PeriodoMensualDelegate(context),
          onSeleccionarPeriodo: (periodo) {},
          decoration: BoxDecoration(
            color: colores.tertiary,
            borderRadius: BorderRadius.circular(40.sw),
          ),
          margin: EdgeInsets.symmetric(horizontal: 20.pw),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: BlocBuilder<BlocMisCursos, BlocMisCursosEstado>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.pw,
                    vertical: 20.ph,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: state.listaCursosConMaterias.keys
                        .map(
                          (cursoId) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cursoId.toString(),
                                style: TextStyle(
                                  color: colores.onSecondary,
                                  fontSize: 13.pf,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 10.ph),
                              Column(
                                children: state.listaCursosConMaterias[cursoId]!
                                    .map(
                                      (materia) => Padding(
                                        padding: EdgeInsets.only(
                                          bottom: 10.ph,
                                        ),
                                        child: ItemMateria(
                                          estaCargada: false,
                                          // TODO(anyone): aca hay que chequear
                                          //la fecha de la lista de materias
                                          //actual y hacer la validacion con eso
                                          estaHabilitado: true,
                                          materia: materia,
                                          onTap: () => context.pushRoute(
                                            const RutaCargaDeCalificaciones(),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
