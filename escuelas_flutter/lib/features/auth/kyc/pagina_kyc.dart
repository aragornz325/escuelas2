import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/widgets/drawer/bloc/bloc_drawer.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlocDrawer>(
          create: (context) => BlocDrawer(),
        ),
        BlocProvider<BlocKyc>(
          create: (context) => BlocKyc()..add(const BlocKycEventoInicializar()),
        ),
      ],
      child: EscuelasScaffold(
        tieneAppBar: true,
        tieneDrawer: false,
        cuerpo: AutoRouter(
          builder: (context, content) {
            return switch (context.router.current.name) {
              RutaSeleccionDeRol.name => content,
              RutaFormulario.name => content,
              RutaEspera.name => content,
              _ => const SizedBox.shrink()
            };
          },
        ),
      ),
    );
  }
}
