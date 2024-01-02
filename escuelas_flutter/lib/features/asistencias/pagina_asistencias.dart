import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/asistencias/bloc_asistencias/bloc_asistencias_bloc.dart';
import 'package:escuelas_flutter/features/asistencias/celular/vista_celular_asistencias.dart';
import 'package:escuelas_flutter/features/asistencias/escritorio/vista_escritorio_asistencias.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaAsistencia}
/// Pagina Asistencia donde un directivo puede tomar asistencias y ver las
/// anteriores
/// {@endtemplate}
@RoutePage()
class PaginaAsistencia extends StatelessWidget {
  /// {@macro PaginaAsistencia}
  const PaginaAsistencia({super.key});
// TODO(GON/ANYONE): Verificar si se usa Asistencia o Inasistencia
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocAsistencias>(
      create: (context) => BlocAsistencias(),
      child: const FullResponsiveScreen(
        celular: VistaCelularAsistencias(),
        escritorio: VistaEscritorioAsistencias(),
      ),
    );
  }
}
