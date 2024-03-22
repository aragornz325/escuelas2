import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/editar_perfil/bloc/bloc_editar_perfil.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialogConfirmarCambios}
/// Dialogo de confirmar cambios.
/// {@endtemplate}
class DialogConfirmarCambios extends StatelessWidget {
  /// {@macro DialogConfirmarCambios}
  const DialogConfirmarCambios({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return EscuelasDialog.solicitudDeAccion(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sw),
      ),
      onTapConfirmar: () => context.read<BlocEditarPerfil>().add(
            const BlocEditarPerfilEventoConfirmarCambios(),
          ),
      content: BlocBuilder<BlocEditarPerfil, BlocEditarPerfilEstado>(
        builder: (context, state) {
          return Text(
            l10n.pageEditProfileButtonConfirmEditUser(state.nombreUsuario),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colores.onSecondary,
              fontSize: 14.pf,
              fontWeight: FontWeight.w600,
            ),
          );
        },
      ),
    );
  }
}
