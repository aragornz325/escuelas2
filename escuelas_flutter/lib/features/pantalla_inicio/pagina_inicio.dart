import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/pantalla_inicio/bloc/bloc_inicio.dart';
import 'package:escuelas_flutter/features/pantalla_inicio/celular/vista_celular_inicio.dart';
import 'package:escuelas_flutter/features/pantalla_inicio/escritorio/vista_escritorio_inicio.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocInicio>(
      create: (context) =>
          BlocInicio()..add(BlocInicioEventoTraerInfoInicial()),
      child: const FullResponsiveScreen(
        celular: VistaCelularInicio(),
        escritorio: VistaEscritorioInicio(),
      ),
    );
  }
}
