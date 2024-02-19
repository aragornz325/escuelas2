import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/extensiones/usuario.dart';
import 'package:escuelas_flutter/features/dashboard/bloc_dashboard/bloc_dashboard.dart';
import 'package:escuelas_flutter/features/dashboard/lista_cursos/mis_cursos/bloc/bloc_mis_cursos.dart';
import 'package:escuelas_flutter/features/dashboard/lista_cursos/mis_cursos/celular/vista_celular_directivo_cursos.dart';
import 'package:escuelas_flutter/features/dashboard/lista_cursos/mis_cursos/celular/vista_celular_mis_cursos.dart';
import 'package:escuelas_flutter/features/dashboard/lista_cursos/mis_cursos/escritorio/vista_celular_directivo_cursos.dart';
import 'package:escuelas_flutter/features/dashboard/lista_cursos/mis_cursos/escritorio/vista_escritorio_mis_cursos.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template VistaEscritorioMisCursos}
/// Pagina para que el usuario pueda ver sus materias asignadas ordenadas por
/// curso.
/// {@endtemplate}
@RoutePage()
class PaginaMisCursos extends StatelessWidget {
  /// {@macro PaginaMisCursos}
  const PaginaMisCursos({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = context.read<BlocDashboard>().state.usuario;
    // TODO(anyone): ver como se manejaran los nombre de los roles.
    // pora los nombre de los roles(l10n) en caso de que sean en otro idioma.
    return usuario.nombreRoles == 'Directivo'
        ? BlocProvider<BlocMisCursos>(
            create: (context) => BlocMisCursos()
              ..add(const BlocMisCursosEventoInicializarDirectivo()),
            child: const FullResponsiveScreen(
              celular: VistaCelularDirectivoCursos(),
              escritorio: VistaEscritorioDirectivoCursos(),
            ),
          )
        : BlocProvider(
            create: (context) => BlocMisCursos()
              ..add(
                BlocMisCursosEventoInicializar(
                  usuarioId: usuario.id ?? 0,
                ),
              ),
            child: const FullResponsiveScreen(
              celular: VistaCelularMisCursos(),
              escritorio: VistaEscritorioMisCursos(),
            ),
          );
  }
}
