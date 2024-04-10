import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/auth/registro/bloc/bloc_registro.dart';
import 'package:escuelas_flutter/features/auth/registro/celular/vista_celular.dart';
import 'package:escuelas_flutter/features/auth/registro/escritorio/vista_escritorio.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:escuelas_flutter/utilidades/utilidades.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';

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
      create: (context) =>
          BlocRegistro(emailAuth: EmailAuthController(client.modules.auth)),
      child: const EscuelasConfirmarCerrarApp(
        child: EscuelasScaffold(
          cuerpo: FullResponsiveScreen(
            celular: VistaCelularRegistro(),
            escritorio: VistaEscritorioRegistro(),
          ),
        ),
      ),
    );
  }
}
