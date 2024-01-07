import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/bloc/bloc_perfil_usuario.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/perfil_usuario_pendiente/celular/vista_celular_perfil_usuario_pendiente.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/perfil_usuario_pendiente/escritorio/vista_escritorio_perfil_usuario_pendiente.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaPerfilUsuarioPendiente}
/// Pagina de perfil de usuario donde se pueden ver los datos del usuario
/// pendiente
/// {@endtemplate}
@RoutePage()
class PaginaPerfilUsuarioPendiente extends StatelessWidget {
  /// {@macro PaginaPerfilUsuarioPendiente}
  const PaginaPerfilUsuarioPendiente({
    @PathParam('pendingUserId') required this.idUsuarioPendiente,
    super.key,
  });

  /// Id del usuario pendiente
  final int idUsuarioPendiente;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocPerfilUsuario>(
      create: (context) => BlocPerfilUsuario()
        ..add(
          BlocPerfilUsuarioEventoTraerUsuarioPendiente(
            idUsuarioPendiente: idUsuarioPendiente,
          ),
        ),
      child: const FullResponsiveScreen(
        celular: VistaCelularPerfilUsuarioPendiente(),
        escritorio: VistaEscritorioPerfilUsuarioPendiente(),
      ),
    );
  }
}
