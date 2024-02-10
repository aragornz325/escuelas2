import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/extensiones/usuario.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/perfil_usuario/bloc/bloc_perfil_usuario.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/widgets/seccion_cursos.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/widgets/seccion_datos_personales.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/widgets/tarjeta_perfil.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template VistaCelularPerfilUsuario}
/// Vista celular de la pantalla 'Perfil de usuario'
/// {@endtemplate}
class VistaCelularPerfilUsuario extends StatelessWidget {
  /// {@macro VistaCelularPerfilUsuario}
  const VistaCelularPerfilUsuario({super.key});

  /// Dialog que notifica que el usuario ha sido eliminado exitosamente
  Future<void> _eliminadoConExito(BuildContext context) {
    final l10n = context.l10n;
    final usuario = context.read<BlocPerfilUsuario>().state.usuario;

    return showDialog<void>(
      context: context,
      builder: (_) => EscuelasDialog.exitoso(
        context: context,
        onTap: () {
          context.router.push(const RutaComunidadAcademica());
          Navigator.of(context).pop();
        },
        content: Text(
            '${usuario?.nombre} ${usuario?.apellido}${l10n.pageUserProfileTeacherSuccessfullyEliminated}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final usuario = context.read<BlocPerfilUsuario>().state.usuario;

    return BlocConsumer<BlocPerfilUsuario, BlocPerfilUsuarioEstado>(
      listener: (context, state) {
        if (state is BlocPerfilUsuarioEstadoExitosoAlEliminarUsuario) {
          showDialog<void>(
            context: context,
            builder: (_) => EscuelasDialog.exitoso(
              context: context,
              onTap: () {
                context.router.push(const RutaComunidadAcademica());
                Navigator.of(context).pop();
              },
              content: Text(
                  '${usuario?.nombre} ${usuario?.apellido}${l10n.pageUserProfileTeacherSuccessfullyEliminated}'),
            ),
          );
        }
      },
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
              rolesAsignados: state.usuario?.nombreRoles ?? '',
              nombreUsuario: state.usuario?.nombre ?? '',
              apellidoUsuario: state.usuario?.apellido ?? '',
              urlImage: state.usuario?.urlFotoDePerfil ?? '',
              idUsuario: state.usuario?.id ?? 0,
            ),
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DatosPersonales(),
                    SeccionCursos(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
