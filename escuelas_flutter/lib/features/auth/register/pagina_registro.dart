import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/auth/register/bloc/bloc_registro.dart';
import 'package:escuelas_flutter/features/auth/register/celular/vista_celular.dart';
import 'package:escuelas_flutter/features/auth/register/escritorio/vista_escritorio.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:escuelas_flutter/widgets/escuelas_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaRegistro}
/// Página de registro de usuario.
/// {@endtemplate}
@RoutePage()
class PaginaRegistro extends StatelessWidget {
  /// {@macro PaginaRegistro}
  const PaginaRegistro({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocRegistro>(
      create: (context) => BlocRegistro(),
      child: const EscuelasScaffold(
        cuerpo: FullResponsiveScreen(
          celular: VistaCelularRegistro(),
          escritorio: VistaEscritorioRegistro(),
        ),
      ),
    );
  }
}
