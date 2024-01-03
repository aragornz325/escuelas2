import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:flutter/material.dart';

//TODO(anyone): Unir las dos carpetas en una sola la de carga de calificaciones y mis cursos cuando no hay tantos mr
/// {@template PaginaListaCursos}
/// Pagina para que el usuario pueda ver sus cursos
/// {@endtemplate}
@RoutePage()
class PaginaListaCursos extends StatelessWidget {
  /// {@macro PaginaListaCursos}
  const PaginaListaCursos({super.key});

  @override
  Widget build(BuildContext context) {
    AutoRouter.of(context);

    return AutoRouter(
      builder: (context, content) {
        return switch (context.router.current.name) {
          RutaMisCursos.name => content,
          RutaCargaDeCalificaciones.name => content,
          _ => const SizedBox.shrink()
        };
      },
    );
  }
}
