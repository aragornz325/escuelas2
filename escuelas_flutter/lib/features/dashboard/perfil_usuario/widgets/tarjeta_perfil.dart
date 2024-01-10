import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/extensiones/string.dart';
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
    required this.nombreRol,
    required this.nombreUsuario,
    required this.apellidoUsuario,
    super.key,
  });

  final String nombreRol;

  final String nombreUsuario;

  final String apellidoUsuario;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return Container(
      width: 340.pw,
      padding: EdgeInsets.all(20.sw),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.sw),
        color: colores.tertiary,
      ),
      child: SingleChildScrollView(
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100.sw),
              child: SizedBox(
                width: 110.sw,
                height: 110.sh,
                // TODO(Gon): Poner imagen del user
                child: Image.asset(Assets.images.usuario.path),
              ),
            ),
            SizedBox(width: 20.pw),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  nombreUsuario,
                  style: TextStyle(
                    color: colores.onBackground,
                    fontSize: 20.pf,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  apellidoUsuario,
                  style: TextStyle(
                    color: colores.onBackground,
                    fontSize: 20.pf,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.ph),
                  child: Text(
                    nombreRol.capitalize,
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
          ],
        ),
      ),
    );
  }
}
