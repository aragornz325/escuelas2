import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:flutter/material.dart';

/// {@template PaginaSupervision}
/// Pagina para que un directivo pueda supervisar las comision para enviar
/// mails.
/// {@endtemplate}
@RoutePage()
class PaginaSupervision extends StatelessWidget {
  /// {@macro PaginaSupervision}
  const PaginaSupervision({super.key});

  @override
  Widget build(BuildContext context) {
    AutoRouter.of(context);

    return AutoRouter(
      builder: (context, content) {
        return switch (context.router.current.name) {
          RutaSupervisionComisiones.name => content,
          RutaSupervisionEnvioCalificaciones.name => content,
          RutaSupervisionAsignatura.name => content,
          _ => const SizedBox.shrink()
        };
      },
    );
  }
}
