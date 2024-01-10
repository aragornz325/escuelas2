import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/inasistencias/bloc_inasistencias/bloc_inasistencias.dart';
import 'package:escuelas_flutter/features/inasistencias/celular/vista_celular_inasistencias.dart';
import 'package:escuelas_flutter/features/inasistencias/escritorio/vista_escritorio_inasistencias.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaInasistencia}
/// Pagina Inasistencia donde un directivo puede tomar inasistencias y ver las
/// anteriores
/// {@endtemplate}
@RoutePage()
class PaginaInasistencia extends StatelessWidget {
  /// {@macro PaginaInasistencia}
  const PaginaInasistencia({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocInasistencias>(
      create: (context) => BlocInasistencias()
        ..add(BlocInasistenciasEventoInicializar(fecha: DateTime.now())),
      child: const FullResponsiveScreen(
        celular: VistaCelularInasistencias(),
        escritorio: VistaEscritorioInasistencias(),
      ),
    );
  }
}
