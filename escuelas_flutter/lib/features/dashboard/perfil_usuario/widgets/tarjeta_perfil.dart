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

    final roles = '${l10n.commonRoles}: ${rolesAsignados.capitalize}';

    return Container(
      height: 140.ph,
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
                child: (urlImage != null && urlImage != '')
                    ? Image.network(
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
                      )
                    : Icon(
                        Icons.person,
                        color: colores.onBackground,
                        size: 30.sw,
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
                    nombreUsuario,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: colores.onBackground,
                      fontSize: 20.pf,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    apellidoUsuario,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
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
                  estaHabilitado: true,
                  // TODO(Gon): Dar funcion
                  onTap: () => showDialog<void>(
                    context: context,
                    builder: (context) =>
                        EscuelasDialog.featNoDisponible(context: context),
                  ),
                  color: colores.azul,
                  texto: l10n.commonContact,
                  fontSize: 12.pf,
                  context: context,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
