import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/bloc_comunicaciones/bloc_comunicaciones.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/pendientes/celular/vista_celular_comunicaciones_pendientes.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/pendientes/escritorio/vista_escritorio_comunicaciones_pendientes.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaComunicacionesPendientes}
// TODO(ANYONE): Add docu
/// {@endtemplate}
@RoutePage()
class PaginaComunicacionesPendientes extends StatelessWidget {
  /// {@macro PaginaComunicacionesPendientes}
  const PaginaComunicacionesPendientes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocComunicaciones>(
      // TODO(ANYONE): Cambiar a bloc correspondiente
      create: (context) => BlocComunicaciones()
        ..add(BlocComunicacionesEventoInicializar(fecha: DateTime.now())),
      child: const FullResponsiveScreen(
        celular: VistaCelularComunicacionesPendientes(),
        escritorio: VistaEscritorioComunicacionesPendientes(),
      ),
    );
  }
}
