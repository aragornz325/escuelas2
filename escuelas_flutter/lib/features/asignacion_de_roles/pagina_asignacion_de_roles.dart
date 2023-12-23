import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/asignacion_de_roles/bloc/bloc_asignacion_de_roles.dart';
import 'package:escuelas_flutter/features/asignacion_de_roles/widgets/widgets.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class PaginaAsignacionDeRoles extends StatelessWidget {
  const PaginaAsignacionDeRoles({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocAsignacionDeRoles(),
      child: const FullResponsiveScreen(
        celular: VistaCelularAsignacionDeRoles(),
        escritorio: VistaEscritorioAsignacionDeRoles(),
      ),
    );
  }
}
