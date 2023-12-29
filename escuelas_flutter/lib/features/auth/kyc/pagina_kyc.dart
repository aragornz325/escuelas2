import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template VistaEscritorioKyc}
/// Pagina de la pantalla 'Kyc'
/// {@endtemplate}
@RoutePage()
class PaginaKyc extends StatelessWidget {
  /// {@macro PaginaKyc}
  const PaginaKyc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocKyc(),
      child: EscuelasScaffold(
        cuerpo: AutoRouter(
          builder: (context, content) {
            return switch (context.router.current.name) {
              PaginaSeleccionDeRol.name => content,
              PaginaFormulario.name => content,
              _ => const SizedBox.shrink()
            };
          },
        ),
      ),
    );
  }
}
