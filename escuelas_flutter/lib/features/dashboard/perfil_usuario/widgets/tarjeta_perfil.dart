import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:escuelas_flutter/app/auto_route/auto_route.gr.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/perfil_usuario/bloc/bloc_perfil_usuario.dart';
import 'package:escuelas_flutter/gen/assets.gen.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template TarjetaPerfil}
/// Tarjeta de perfil donde se muestra la informacion del usuario, foto, nombre
/// y rol
/// {@endtemplate}
class TarjetaPerfil extends StatelessWidget {
  /// {@macro TarjetaPerfil}
  const TarjetaPerfil({
    required this.rolesAsignados,
    required this.nombreUsuario,
    required this.apellidoUsuario,
    this.idUsuario,
    this.urlImage,
    super.key,
  });

  /// Rol del usuario seleccionado
  final String rolesAsignados;

  /// Nombre del usuario seleccionado
  final String nombreUsuario;

  /// Apellido del usuario seleccionado
  final String apellidoUsuario;

  /// Url de la foto de perfil del usuario seleccionado
  final String? urlImage;

  /// Id del usuario
  final int? idUsuario;

  /// Dialog de confirmacion para eliminar el usuario
  Future<void> _confirmarEliminado(BuildContext context) {
    final l10n = context.l10n;
    final usuario = context.read<BlocPerfilUsuario>().state.usuario;

    return showDialog<void>(
      context: context,
      builder: (_) => EscuelasDialog.solicitudDeAccion(
        context: context,
        onTapConfirmar: () {
          Navigator.of(context).pop();
          context.read<BlocPerfilUsuario>().add(
                BlocPerfilUsuarioEventoEliminarDocente(
                  idUsuario: idUsuario!,
                ),
              );
        },
        titulo: l10n.commonAttention.toUpperCase(),
        content: Column(
          children: [
            Text(
                '${l10n.pageUserProfileConfirmDeleteQuestion}${usuario?.nombre.toUpperCase()} ${usuario?.apellido.toUpperCase()} ${l10n.pageUserProfileTeacherList}'),
            Text(l10n.commonWantToContinue),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    final roles = rolesAsignados.capitalize;
    return IntrinsicHeight(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.sw),
        padding: EdgeInsets.all(20.sw),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.sw),
          color: colores.tertiary,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100.sw),
              child: SizedBox(
                width: 110.sw,
                height: 110.sh,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(100.sw)),
                  child: Image.network(
                    urlImage!,
                    fit: BoxFit.cover,
                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) =>
                        Image.asset(
                      Assets.images.usuario.path,
                      color: colores.onBackground,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 20.pw),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      '$nombreUsuario $apellidoUsuario',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        color: colores.onBackground,
                        fontSize: 20.pf,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.ph),
                    child: Text(
                      roles,
                      style: TextStyle(
                        color: colores.grisSC,
                        fontSize: 14.pf,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  EscuelasBoton.texto(
                    width: 185.pw,
                    estaHabilitado: true,
                    onTap: () => context.router
                        .push(RutaKyCEdicionUsuario(idUsuario: idUsuario ?? 0)),
                    color: colores.primaryContainer,
                    texto: l10n.commonEdit,
                    fontSize: 12.pf,
                    context: context,
                  ),
                  SizedBox(height: max(8.ph, 8.sh)),
                  EscuelasBoton.texto(
                    width: 185.pw,
                    estaHabilitado: true,
                    onTap: () {
                      _confirmarEliminado(context);
                    },
                    color: colores.rojoTED,
                    texto: l10n.pageUserProfileButtonDeleteTeacher,
                    fontSize: 12.pf,
                    context: context,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
