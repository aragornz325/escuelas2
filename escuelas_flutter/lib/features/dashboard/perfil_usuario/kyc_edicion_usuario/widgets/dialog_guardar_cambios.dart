import 'package:escuelas_flutter/features/dashboard/perfil_usuario/perfil_usuario/bloc/bloc_perfil_usuario.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template DialogGuardarCambios}
/// Dialogo para preguntar si desea guardar cambios
/// {@endtemplate}
class DialogGuardarCambios extends StatelessWidget {
  /// {@macro DialogGuardarCambios}
  const DialogGuardarCambios({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = context.read<BlocPerfilUsuario>().state.usuario;
    final l10n = context.l10n;

    return EscuelasDialog.solicitudDeAccion(
      onTapConfirmar: () {
        context
            .read<BlocPerfilUsuario>()
            .add(BlocPerfilUsuarioEventoInsertarInformacionDeKyc());
      },
      content: Text(
        '${l10n.pageUserProfileKyCConfirmationSaveChanges} ${usuario?.nombre ?? ''} ${usuario?.apellido ?? ''}?',
      ),
      context: context,
    );
  }
}
