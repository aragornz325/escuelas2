import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/mis_cursos/bloc/bloc_mis_cursos.dart';
import 'package:escuelas_flutter/features/mis_cursos/widgets/item_materia.dart';
import 'package:escuelas_flutter/widgets/selector_de_fecha/bloc/bloc_selector_de_fecha.dart';
import 'package:escuelas_flutter/widgets/selector_de_fecha/selector_de_fecha.dart';
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

    return BlocBuilder<BlocSelectorDeFecha, BlocSelectorDeFechaEstado>(
      builder: (context, stateFecha) {
        return Column(
          children: [
            const SelectorDeFecha(),
            BlocBuilder<BlocMisCursos, BlocMisCursosEstado>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: state.listaCursosConMaterias.keys
                          .map(
                            (cursoId) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    cursoId.toString(),
                                    style: TextStyle(
                                      color: colores.onSecondary,
                                      fontSize: 13.pf,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                Column(
                                  children:
                                      state.listaCursosConMaterias[cursoId]!
                                          .map(
                                            (materia) => Padding(
                                              padding: EdgeInsets.only(
                                                bottom: 10.ph,
                                              ),
                                              child: ItemMateria(
                                                estaCargada: false,
                                                estaHabilitado: stateFecha.fecha
                                                    .isBefore(DateTime.now()),
                                                materia: materia,
                                                onTap: () {},
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
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
