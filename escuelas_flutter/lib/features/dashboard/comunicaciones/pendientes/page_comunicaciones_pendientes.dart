import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/pendientes/bloc_comunicaciones_pendientes/bloc_comunicaciones_pendientes.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/pendientes/celular/vista_celular_comunicaciones_pendientes.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/pendientes/escritorio/vista_escritorio_comunicaciones_pendientes.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaComunicacionesPendientes}
/// Pagina ComunicacionesPendientes donde un directivo verifica
/// las comunicaciones pendientes, pudiendo editarlas aprobarlas, rechazarlas.
/// {@endtemplate}
@RoutePage()
class PaginaComunicacionesPendientes extends StatelessWidget {
  /// {@macro PaginaComunicacionesPendientes}
  const PaginaComunicacionesPendientes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocComunicacionesPendientes>(
      create: (context) => BlocComunicacionesPendientes()
        ..add(
          const BlocComunicacionesPendientesEventoInicializar(),
        ),
      child: const FullResponsiveScreen(
        celular: VistaCelularComunicacionesPendientes(),
        escritorio: VistaEscritorioComunicacionesPendientes(),
      ),
    );
  }
}
