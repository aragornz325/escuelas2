import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/dashboard/bloc_dashboard/bloc_dashboard.dart';
import 'package:escuelas_flutter/features/dashboard/pantalla_inicio/bloc/bloc_inicio.dart';
import 'package:escuelas_flutter/features/dashboard/pantalla_inicio/celular/vista_celular_inicio.dart';
import 'package:escuelas_flutter/features/dashboard/pantalla_inicio/escritorio/vista_escritorio_inicio.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaInicio}
/// Pagina de visualización Inicio, el usuario puede tener acceso
/// a las distintas opciones correspondientes a sus permisos, pudiendo
/// redirigirse.
/// {@endtemplate}
@RoutePage()
class PaginaInicio extends StatefulWidget {
  /// {@macro PaginaInicio}
  const PaginaInicio({
    super.key,
  });

  @override
  State<PaginaInicio> createState() => _PaginaInicioState();
}

class _PaginaInicioState extends State<PaginaInicio> {
  @override
  Widget build(BuildContext context) {
    final usuario = context.read<BlocDashboard>().state.usuario;

    return BlocProvider<BlocInicio>(
      create: (context) =>
          BlocInicio(usuario: usuario)..add(BlocInicioEventoInicializar()),
      child: const FullResponsiveScreen(
        celular: VistaCelularInicio(),
        escritorio: VistaEscritorioInicio(),
      ),
    );
  }
}
