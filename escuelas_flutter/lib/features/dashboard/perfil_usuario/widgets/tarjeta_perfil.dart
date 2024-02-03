import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/gen/assets.gen.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:flutter/material.dart';
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
    this.urlImage,
    super.key,
  });

  final String rolesAsignados;

  final String nombreUsuario;

  final String apellidoUsuario;

  final String? urlImage;

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
                    //! TODO(Manu): Dar funcion
                    onTap: () => showDialog<void>(
                      context: context,
                      builder: (context) =>
                          EscuelasDialog.featNoDisponible(context: context),
                    ),
                    color: colores.primaryContainer,
                    texto: l10n.commonEdit,
                    fontSize: 12.pf,
                    context: context,
                  ),
                  SizedBox(height: max(8.ph, 8.sh)),
                  EscuelasBoton.texto(
                    width: 185.pw,
                    estaHabilitado: true,
                    //! TODO(Manu): Dar funcion
                    onTap: () => showDialog<void>(
                      context: context,
                      builder: (context) =>
                          EscuelasDialog.featNoDisponible(context: context),
                    ),
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
