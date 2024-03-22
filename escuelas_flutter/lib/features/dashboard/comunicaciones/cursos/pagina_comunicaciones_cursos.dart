import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:flutter/material.dart';

/// {@template PaginaComunicacionesCursos}
/// Pagina de 'Comunicaciones de cursos' donde aparece la lista de cursos y sus
/// alumnos de cada.
/// {@endtemplate}
@RoutePage()
class PaginaComunicacionesCursos extends StatelessWidget {
  /// {@macro PaginaComunicacionesCursos}
  const PaginaComunicacionesCursos({super.key});

  @override
  Widget build(BuildContext context) {
    AutoRouter.of(context);

    return AutoRouter(
      builder: (context, content) {
        return switch (context.router.current.name) {
          RutaComunicacionesListaCursos.name => content,
          RutaPerfilComunicados.name => content,
          _ => const SizedBox.shrink()
        };
      },
    );
  }
}
