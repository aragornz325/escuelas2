import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/perfil_comunicados/bloc/bloc_perfil_comunicados.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/perfil_comunicados/celular/vista_celular_perfil_comunicados.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/perfil_comunicados/escritorio/vista_escritorio_perfil_comunicados.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaPerfilComunicados}
/// TODO(mati) add docu
/// {@endtemplate}
@RoutePage()
class PaginaPerfilComunicados extends StatelessWidget {
  /// {@macro PaginaPerfilComunicados}
  const PaginaPerfilComunicados({
    @PathParam('idUsuario') required this.idUsuario,
    super.key,
  });

  /// Id del usuario a ver los comunicados
  final int idUsuario;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocPerfilComunicados>(
      create: (context) => BlocPerfilComunicados(),
      child: const FullResponsiveScreen(
        celular: VistaCelularPerfilComunicados(),
        escritorio: VistaEscritorioPerfilComunicados(),
      ),
    );
  }
}
