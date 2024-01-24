import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/auth/usuarios_pendientes/bloc/bloc_usuarios_pendientes.dart';
import 'package:escuelas_flutter/features/auth/usuarios_pendientes/celular/vista_celular_usuarios_pendientes.dart';
import 'package:escuelas_flutter/features/auth/usuarios_pendientes/escritorio/vista_escritorio_usuarios_pendientes.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaUsuariosPendientes}
/// Pagina de la pantalla Usuarios Pendientes donde se asigna un rol a los
/// usuarios pendientes
/// {@endtemplate}
@RoutePage()
class PaginaUsuariosPendientes extends StatelessWidget {
  /// {@macro PaginaUsuariosPendientes}
  const PaginaUsuariosPendientes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocUsuariosPendientes>(
      create: (context) => BlocUsuariosPendientes()
        ..add(const BlocUsuariosPendientesEventoInicializar()),
      child: const FullResponsiveScreen(
        celular: VistaCelularUsuariosPendientes(),
        escritorio: VistaEscritorioUsuariosPendientes(),
      ),
    );
  }
}
