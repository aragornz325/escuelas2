import 'package:escuelas_flutter/features/dashboard/perfil_usuario/perfil_usuario/bloc/bloc_perfil_usuario.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template DialogEliminarDocente}
/// Dialogo para eliminar un docente
/// {@endtemplate}
class DialogEliminarDocente extends StatelessWidget {
  /// {@macro DialogEliminarDocente}
  const DialogEliminarDocente({
    super.key,
    this.idUsuario,
  });

  /// Id del usuario
  final int? idUsuario;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final usuario = context.read<BlocPerfilUsuario>().state.usuario;
    if (usuario == null) {
      return EscuelasDialog.fallido(
          onTap: () {}, content: Text(l10n.commonError));
    }

    return EscuelasDialog.solicitudDeAccion(
      context: context,
      onTapConfirmar: () {
        context.read<BlocPerfilUsuario>().add(
              BlocPerfilUsuarioEventoEliminarDocente(
                idUsuario: idUsuario!,
              ),
            );
        Navigator.of(context).pop();
      },
      titulo: l10n.commonAttention.toUpperCase(),
      content: Column(
        children: [
          Text(
            l10n.pageUserProfileConfirmUserDeletion(
                usuario.nombre.toUpperCase(), usuario.apellido.toUpperCase()),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
