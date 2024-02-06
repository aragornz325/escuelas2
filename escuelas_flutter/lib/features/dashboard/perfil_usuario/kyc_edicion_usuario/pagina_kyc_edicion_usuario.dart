import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/kyc_edicion_usuario/celular/vista_celular_kyc_edicion_usuario.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/perfil_usuario/bloc/bloc_perfil_usuario.dart';
import 'package:escuelas_flutter/src/full_responsive/full_responsive_screen.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template PaginaKyCEdicionUsuario}
/// Pagina en la que se le editan los datos de un usuario
/// {@endtemplate}
@RoutePage()
class PaginaKyCEdicionUsuario extends StatelessWidget {
  const PaginaKyCEdicionUsuario({
    @PathParam('userID') required this.idUsuario,
    super.key,
  });

/// ID del usuario que se edita
  final int idUsuario;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocPerfilUsuario>(
      create: (context) => BlocPerfilUsuario()
        ..add(BlocPerfilUsuarioEventoTraerUsuario(idUsuario: idUsuario)),
      child: const FullResponsiveScreen(
        celular: VistaCelularKyCEdicionUsuario(),
        escritorio: Placeholder(),
      ),
    );
  }
}
