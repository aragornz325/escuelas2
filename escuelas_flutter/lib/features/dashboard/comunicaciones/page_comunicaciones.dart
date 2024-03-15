import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/bloc_comunicaciones/bloc_comunicaciones.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaComunicaciones}
/// Pagina Comunicaciones donde un directivo verifica
/// las comunicaciones en general.
/// {@endtemplate}
@RoutePage()
class PaginaComunicaciones extends StatelessWidget {
  /// {@macro PaginaComunicaciones}
  const PaginaComunicaciones({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocComunicaciones>(
      create: (context) => BlocComunicaciones()
        ..add(
          const BlocComunicacionesEventoInicializar(),
        ),
      child: AutoRouter(
        builder: (context, content) {
          return switch (context.router.current.name) {
            RutaMenuComunicaciones.name => content,
            RutaComunicacionesPendientes.name => content,
            RutaComunicacionesGeneral.name => content,
            RutaComunicacionesCursos.name => content,
            _ => const SizedBox.shrink()
          };
        },
      ),
    );
  }
}
