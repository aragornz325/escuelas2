import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/perfil_comunicados/bloc/bloc_perfil_comunicados.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/perfil_comunicados/celular/vista_celular_perfil_comunicados.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/perfil_comunicados/escritorio/vista_escritorio_perfil_comunicados.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaPerfilComunicados}
/// Pagina de la pantalla 'Perfil de comunicados', donde se muestra la
/// lista de notificaciones de un usuario y establecer una conversacion con el.
/// {@endtemplate}
@RoutePage()
class PaginaPerfilComunicados extends StatelessWidget {
  /// {@macro PaginaPerfilComunicados}
  const PaginaPerfilComunicados({
    @PathParam('idUsuario') required this.idUsuario,
    @PathParam('nombreUsuario') required this.nombreUsuario,
    super.key,
  });

  /// Id del usuario a ver los comunicados.
  final int idUsuario;

  /// Nombre del usuario/alumno.
  final String nombreUsuario;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocPerfilComunicados>(
      create: (context) => BlocPerfilComunicados(
        idUsuario: idUsuario,
        nombreUsuario: nombreUsuario,
      )..add(BlocPerfilComunicadosEventoInicializar()),
      child: const FullResponsiveScreen(
        celular: VistaCelularPerfilComunicados(),
        escritorio: VistaEscritorioPerfilComunicados(),
      ),
    );
  }
}
