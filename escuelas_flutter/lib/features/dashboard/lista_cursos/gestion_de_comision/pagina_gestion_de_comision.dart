import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/dashboard/lista_cursos/gestion_de_comision/bloc/bloc_gestion_de_comision.dart';
import 'package:escuelas_flutter/features/dashboard/lista_cursos/gestion_de_comision/celular/vista_celular_gestion_de_comision.dart';
import 'package:escuelas_flutter/features/dashboard/lista_cursos/gestion_de_comision/escritorio/vista_escritorio_gestion_de_comision.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaGestionDeComision}
/// TODO(mati): documentar
/// {@endtemplate}
@RoutePage()
class PaginaGestionDeComision extends StatelessWidget {
  /// {@macro PaginaGestionDeComision}
  const PaginaGestionDeComision({
    @PathParam('idAsignatura') required this.idAsignatura,
    @PathParam('idAsignatura') required this.idComision,
    super.key,
  });

  /// Id de la asignatura
  final int idAsignatura;

  /// Id de la comision a obtener
  final int idComision;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocGestionDeComision>(
      create: (context) => BlocGestionDeComision(
        idAsignatura: idAsignatura,
        idComision: idComision,
      )..add(const BlocGestionDeComisionEventoInicializar()),
      child: const FullResponsiveScreen(
        celular: VistaCelularGestionDeComision(),
        escritorio: VistaEscritorioGestionDeComision(),
      ),
    );
  }
}
