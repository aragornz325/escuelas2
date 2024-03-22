import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/editar_perfil/bloc/bloc_editar_perfil.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/editar_perfil/celular/vista_celular_editar_perfil.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/editar_perfil/escritorio/vista_escritorio_editar_perfil.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaEditarPerfil}
/// Pagina para editar el perfil.
/// {@endtemplate}
@RoutePage()
class PaginaEditarPerfil extends StatelessWidget {
  /// {@macro PaginaEditarPerfil}
  const PaginaEditarPerfil({
    @PathParam('nombreUsuario') required this.nombreUsuario,
    @PathParam('idUsuario') required this.idUsuario,
    super.key,
  });

  /// Id del usuario a editar el perfil.
  final int idUsuario;

  /// Nombre del usuario.
  final String nombreUsuario;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<BlocEditarPerfil>()
        ..add(
          BlocEditarPerfilEventoTraerUsuario(
            idUsuario: idUsuario,
            nombreUsuario: nombreUsuario,
          ),
        ),
      child: const FullResponsiveScreen(
        celular: VistaCelularEditarPerfil(),
        escritorio: VistaEscritorioEditarPerfil(),
      ),
    );
  }
}
