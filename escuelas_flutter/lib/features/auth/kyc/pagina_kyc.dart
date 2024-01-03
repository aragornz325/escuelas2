import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// {@template VistaEscritorioKyc}
/// Pagina de la pantalla 'Kyc'
/// {@endtemplate}
@RoutePage()
class PaginaKyc extends StatelessWidget {
  /// {@macro PaginaKyc}
  const PaginaKyc({super.key});

  @override
  Widget build(BuildContext context) {
    return EscuelasScaffold(
      cuerpo: AutoRouter(
        builder: (context, content) {
          return switch (context.router.current.name) {
            RutaSeleccionDeRol.name => content,
            RutaFormulario.name => content,
            _ => const SizedBox.shrink()
          };
        },
      ),
    );
  }
}
