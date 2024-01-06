import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/bloc/bloc_comunidad_academica.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularComunidadAcademica}
/// Vista de la comunidad academica en celular donde se elige la categoria a
/// mostrar
/// {@endtemplate}
class VistaCelularMenuComunidadAcademica extends StatelessWidget {
  /// {@macro VistaCelularComunidadAcademica}
  const VistaCelularMenuComunidadAcademica({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocComunidadAcademica, BlocComunidadAcademicaEstado>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.pw),
          child: Column(
            children: state.listaRoles
                .map(
                  (e) => Padding(
                    padding: EdgeInsets.only(bottom: 15.ph),
                    child: ElementoLista.menu(
                      onTap: () => context.router
                          .push(RutaListadoComunidad(idRol: e.id ?? 0)),
                      nombreOpcion: e.nombre,
                      context: context,
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
