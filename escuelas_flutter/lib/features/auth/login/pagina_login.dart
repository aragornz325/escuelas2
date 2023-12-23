import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/auth/login/bloc/bloc_login.dart';
import 'package:escuelas_flutter/features/auth/login/celular/vista_celular_login.dart';
import 'package:escuelas_flutter/features/auth/login/escritorio/vista_escritorio_login.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaLogin}
/// Pagina de la pantalla Login donde el usuario puede iniciar sesion.
/// {@endtemplate}
@RoutePage()
class PaginaLogin extends StatelessWidget {
  /// {@macro PaginaLogin}
  const PaginaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocLogin>(
      create: (context) => BlocLogin(),
      child: const FullResponsiveScreen(
        celular: VistaCelularLogin(),
        escritorio: VistaEscritorioLogin(),
      ),
    );
  }
}
