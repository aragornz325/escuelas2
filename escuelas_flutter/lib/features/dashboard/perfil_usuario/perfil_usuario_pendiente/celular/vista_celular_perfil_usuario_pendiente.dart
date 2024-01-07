import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/bloc/bloc_perfil_usuario.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/widgets/seccion_cursos.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/widgets/tarjeta_perfil.dart';
import 'package:escuelas_flutter/gen/fonts.gen.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template VistaCelularPerfilUsuarioPendiente}
/// Vista celular de la pantalla 'Perfil de usuario pendiente'
/// {@endtemplate}
class VistaCelularPerfilUsuarioPendiente extends StatelessWidget {
  /// {@macro VistaCelularPerfilUsuario}
  const VistaCelularPerfilUsuarioPendiente({super.key});

  /// Dialog para confirmar la asignacion de un rol al usuario
  void _dialogAsignarRol(
    BuildContext context,
    Usuario? usuario,
  ) {
    final colores = context.colores;

    final l10n = context.l10n;

    showDialog<void>(
      context: context,
      builder: (context) => EscuelasDialog.confirmar(
        context: context,
        ancho: 260.pw,
        onTapConfirmar: () => context
            .read<BlocPerfilUsuario>()
            .add(BlocPerfilUsuarioEventoAceptarSolicitud()),
        content: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              color: colores.grisSC,
              fontSize: 16.pf,
              fontWeight: FontWeight.w600,
              fontFamily: FontFamily.nunito,
            ),
            children: <TextSpan>[
              TextSpan(
                text: l10n.pageRoleAssigmentDialogFirstText,
                style: TextStyle(
                  color: colores.grisSC,
                  fontSize: 16.pf,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.nunito,
                ),
              ),
              TextSpan(
                text: usuario?.nombre ?? '',
                style: TextStyle(
                  color: colores.onBackground,
                  fontSize: 16.pf,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.nunito,
                ),
              ),
              TextSpan(
                text: l10n.pageRoleAssigmentDialogSecondText,
                style: TextStyle(
                  color: colores.grisSC,
                  fontSize: 16.pf,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.nunito,
                ),
              ),
              TextSpan(
                text: '${usuario?.roles?.first.rol?.nombre.toUpperCase()}?',
                style: TextStyle(
                  color: colores.onBackground,
                  fontSize: 16.pf,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.nunito,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return BlocBuilder<BlocPerfilUsuario, BlocPerfilUsuarioEstado>(
      builder: (context, state) {
        if (state is BlocPerfilUsuarioEstadoCargando) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TarjetaPerfil(
              nombreRol: state.nombreRol,
              nombre: state.usuarioPendiente?.nombre ?? '',
              apellido: state.usuarioPendiente?.apellido ?? '',
            ),
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SeccionCursos(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.ph),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EscuelasBoton.texto(
                    estaHabilitado: true,
                    onTap: () => Navigator.of(context).pop,
                    color: colores.error,
                    texto: l10n.commonDecline.toUpperCase(),
                    context: context,
                  ),
                  SizedBox(width: 20.ph),
                  EscuelasBoton.texto(
                    estaHabilitado: true,
                    onTap: () => _dialogAsignarRol(context, state.usuario),
                    color: colores.verdeConfirmar,
                    texto: l10n.commonConfirm.toUpperCase(),
                    context: context,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
