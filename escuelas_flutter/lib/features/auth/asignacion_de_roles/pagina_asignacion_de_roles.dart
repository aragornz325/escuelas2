import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/auth/asignacion_de_roles/bloc/bloc_asignacion_de_roles.dart';
import 'package:escuelas_flutter/features/auth/asignacion_de_roles/celular/vista_celular_asignacion_de_roles.dart';
import 'package:escuelas_flutter/features/auth/asignacion_de_roles/escritorio/vista_escritorio_asignacion_de_roles.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaAsignacionDeRoles}
/// Pagina de la pantalla Asignacion de Rol donde se asigna un rol a los
/// usuarios pendientes
/// {@endtemplate}
@RoutePage()
class PaginaAsignacionDeRoles extends StatelessWidget {
  /// {@macro PaginaAsignacionDeRoles}
  const PaginaAsignacionDeRoles({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocAsignacionDeRoles>(
      create: (context) => BlocAsignacionDeRoles()
        ..add(const BlocAsignacionDeRolesEventoInicializar()),
      child: const FullResponsiveScreen(
        celular: VistaCelularAsignacionDeRoles(),
        escritorio: VistaEscritorioAsignacionDeRoles(),
      ),
    );
  }
}
