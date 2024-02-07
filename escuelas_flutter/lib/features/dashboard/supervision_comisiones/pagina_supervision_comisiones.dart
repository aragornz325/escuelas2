import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/dashboard/supervision_comisiones/bloc/bloc_supervision_comisiones.dart';
import 'package:escuelas_flutter/features/dashboard/supervision_comisiones/celular/vista_celular_supervision_comisiones.dart';
import 'package:escuelas_flutter/features/dashboard/supervision_comisiones/escritorio/vista_escritorio_supervision_comisiones.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaSupervisionComisiones}
/// Pagina donde el usuario puede supervisar la cantidad de asignaturas cargadas
/// dentro de las comisiones
/// {@endtemplate}
@RoutePage()
class PaginaSupervisionComisiones extends StatelessWidget {
  /// {@macro PaginaSupervisionComisiones}
  const PaginaSupervisionComisiones({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocSupervisionComisiones>(
      create: (context) => BlocSupervisionComisiones()
        ..add(
          BlocSupervisionComisionesEventoInicializar(
            fecha: DateTime.now(),
          ),
        ),
      child: const FullResponsiveScreen(
        celular: VistaCelularSupervisionComision(),
        escritorio: VistaEscritorioSupervisionComisiones(),
      ),
    );
  }
}
