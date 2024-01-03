import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/carga_calificaciones/bloc_carga_calificaciones/bloc_carga_calificaciones.dart';
import 'package:escuelas_flutter/features/carga_calificaciones/celular/vista_celular_carga_calificaciones.dart';
import 'package:escuelas_flutter/features/carga_calificaciones/escritorio/vista_escritorio_carga_calificaciones.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:escuelas_flutter/widgets/selector_de_fecha/bloc/bloc_selector_de_fecha.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaCargaDeCalificaciones}
/// Pagina de Carga de Calificaciones.
///
/// En esta vista se muestra el calendario de la fecha actual y la lista de los
/// alumnos de un curso y de una materia.
/// Se puede modificar la calificación de los alumnos y ver de meses anteriores.
/// {@endtemplate}
@RoutePage()
class PaginaCargaDeCalificaciones extends StatelessWidget {
  /// {@macro PaginaCargaDeCalificaciones}
  const PaginaCargaDeCalificaciones({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlocCargaCalificaciones>(
          create: (context) => BlocCargaCalificaciones()
            ..add(
              BlocCargaCalificacionesEventoInicializar(
                fecha: DateTime.now(),
              ),
            ),
        ),
        BlocProvider<BlocSelectorDeFecha>(
          create: (context) => BlocSelectorDeFecha(),
        ),
      ],
      child: const FullResponsiveScreen(
        celular: VistaCelularCargaDeCalificaciones(),
        escritorio: VistaEscritorioCargaDeCalificaciones(),
      ),
    );
  }
}
