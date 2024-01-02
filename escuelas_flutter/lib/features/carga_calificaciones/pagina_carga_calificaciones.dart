import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/carga_calificaciones/bloc_carga_calificaciones/bloc_carga_calificaciones.dart';
import 'package:escuelas_flutter/features/carga_calificaciones/celular/vista_celular_carga_calificaciones.dart';
import 'package:escuelas_flutter/features/carga_calificaciones/escritorio/vista_escritorio_carga_calificaciones.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaInicio}
/// Todo agregar docu
/// {@endtemplate}
@RoutePage()
class PaginaCargaDeCalificaciones extends StatelessWidget {
  /// {@macro PaginaInicio}
  const PaginaCargaDeCalificaciones({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocCargaCalificaciones>(
      create: (context) => BlocCargaCalificaciones(),
      child: const FullResponsiveScreen(
        celular: VistaCelularCargaDeCalificaciones(),
        escritorio: VistaEscritorioCargaDeCalificaciones(),
      ),
    );
  }
}
