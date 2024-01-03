import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/asistencias/bloc_asistencias/bloc_asistencias.dart';
import 'package:escuelas_flutter/features/asistencias/celular/vista_celular_asistencias.dart';
import 'package:escuelas_flutter/features/asistencias/escritorio/vista_escritorio_asistencias.dart';
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
    return BlocProvider<BlocAsistencias>(
      create: (context) =>
          BlocAsistencias()..add(const BlocAsistenciasEventoInicializar()),
      child: const FullResponsiveScreen(
        celular: VistaCelularInasistencias(),
        escritorio: VistaEscritorioInasistencias(),
      ),
    );
  }
}
