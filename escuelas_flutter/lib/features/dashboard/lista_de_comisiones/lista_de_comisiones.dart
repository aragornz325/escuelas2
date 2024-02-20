import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:flutter/material.dart';

/// {@template PaginaListaDeComisiones}
/// Pagina para que un usuario con los permisos necesarios pueda ver todas las
/// comisiones de la institucion.
/// {@endtemplate}
@RoutePage()
class PaginaListaDeComisiones extends StatelessWidget {
  /// {@macro PaginaListaDeComisiones}
  const PaginaListaDeComisiones({super.key});

  @override
  Widget build(BuildContext context) {
    AutoRouter.of(context);

    return AutoRouter(
      builder: (context, content) {
        return switch (context.router.current.name) {
          RutaComisiones.name => content,
          RutaGestionDeComision.name => content,
          _ => const SizedBox.shrink()
        };
      },
    );
  }
}
