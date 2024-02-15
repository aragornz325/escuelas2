import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/perfil_usuario/bloc/bloc_perfil_usuario.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template DialogUsuarioEditado}
/// Dialogo para notificar que el usuario ha sido editado exitosamente
/// {@endtemplate}
class DialogUsuarioEditado extends StatelessWidget {
  /// {@macro DialogUsuarioEditado}
  const DialogUsuarioEditado({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final usuario = context.read<BlocPerfilUsuario>().state.usuario;

    return EscuelasDialog.exitoso(
      context: context,
      onTap: () =>
          context.router.push(RutaPerfilUsuario(idUsuario: usuario?.id ?? 0)),
      content: Text(l10n.pageUserProfileKyCSuccessfulEdition),
    );
  }
}
