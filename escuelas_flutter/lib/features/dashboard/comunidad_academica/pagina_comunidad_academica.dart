import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/bloc/bloc_comunidad_academica.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaComunidadAcademica}
/// Pagina de la comunidad academica donde se muestran los usuarios de la
/// institucion
/// {@endtemplate}
@RoutePage()
class PaginaComunidadAcademica extends StatelessWidget {
  /// {@macro PaginaComunidadAcademica}
  const PaginaComunidadAcademica({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocComunidadAcademica()
        ..add(BlocComunidadAcademicaEventoInicializar()),
      child: AutoRouter(
        builder: (context, content) {
          return switch (context.router.current.name) {
            RutaMenuComunidadAcademica.name => content,
            RutaListadoComunidad.name => content,
            _ => const SizedBox.shrink()
          };
        },
      ),
    );
  }
}
