import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/dashboard/lista_de_comisiones/comisiones/bloc/bloc_comisiones.dart';
import 'package:escuelas_flutter/features/dashboard/lista_de_comisiones/comisiones/vista_celular_comisiones/vista_celular_comisiones.dart';
import 'package:escuelas_flutter/features/dashboard/lista_de_comisiones/comisiones/vista_escritorio_comisiones/vista_escritorio_comisiones.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaComisiones}
/// Pagina para que el usuario pueda ver todas las comisiones.
/// {@endtemplate}
@RoutePage()
class PaginaComisiones extends StatelessWidget {
  /// {@macro PaginaComisiones}
  const PaginaComisiones({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocComisiones>(
      create: (context) => BlocComisiones()
        ..add(
          const BlocComisionesEventoInicializar(),
        ),
      child: const FullResponsiveScreen(
        celular: VistaCelularComisiones(),
        escritorio: VistaEscritorioComisiones(),
      ),
    );
  }
}
