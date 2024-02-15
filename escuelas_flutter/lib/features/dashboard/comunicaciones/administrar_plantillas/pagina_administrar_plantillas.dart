import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/bloc/bloc_administrar_plantillas.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/celular/vista_celular_Administrar_plantillas.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaAdministrarPlantillas}
/// Pagina donde se muestra la lista de las plantillas de comunicaciones
/// {@endtemplate}
@RoutePage()
class PaginaAdministrarPlantillas extends StatelessWidget {
  /// {@macro PaginaAdministrarPlantillas}
  const PaginaAdministrarPlantillas({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlocAdministrarPlantillas()
        ..add(const BlocAdministrarPlantillasEventoInicializar()),
      child: const FullResponsiveScreen(
        celular: VistaCelularAdministrarPlantillas(),
        escritorio: Placeholder(),
      ),
    );
  }
}
