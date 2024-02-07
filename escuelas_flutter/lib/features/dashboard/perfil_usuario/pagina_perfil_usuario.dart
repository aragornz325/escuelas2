import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/perfil_usuario/bloc/bloc_perfil_usuario.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/perfil_usuario/celular/vista_celular_perfil_usuario.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/perfil_usuario/escritorio/vista_escritorio_perfil_usuario.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaPerfilUsuario}
/// Pagina de perfil de usuario donde se pueden ver los datos del usuario
/// {@endtemplate}
@RoutePage()
class PaginaPerfilUsuario extends StatelessWidget {
  /// {@macro PaginaPerfilUsuario}
  const PaginaPerfilUsuario({
    @PathParam('userId') required this.idUsuario,
    super.key,
  });

  /// Id del usuario
  final int idUsuario;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocPerfilUsuario>(
      create: (context) => BlocPerfilUsuario()
        ..add(BlocPerfilUsuarioEventoTraerUsuario(idUsuario: idUsuario)),
      child: const FullResponsiveScreen(
        celular: VistaCelularPerfilUsuario(),
        escritorio: VistaEscritorioPerfilUsuario(),
      ),
    );
  }
}
