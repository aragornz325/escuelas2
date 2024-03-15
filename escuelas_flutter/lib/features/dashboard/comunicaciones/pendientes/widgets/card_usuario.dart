import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template CardUsuario}
/// Componente con nombre e imagen de perfil del usuario
/// {@endtemplate}
class CardUsuario extends StatelessWidget {
  /// {@macro CardUsuario}
  const CardUsuario({
    required this.urlImagenDePerfil,
    required this.nombre,
    required this.apellido,
    super.key,
  });
  final String urlImagenDePerfil;
  final String nombre;
  final String apellido;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Container(
      width: 128.pw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.sw)),
        color: colores.tertiary,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.pw, vertical: 4.ph),
        child: Row(
          children: [
            SizedBox(
              width: 36.pw,
              height: 36.ph,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(100.sw)),
                child: Image.network(
                  urlImagenDePerfil,
                  width: 36.pw,
                  height: 36.ph,
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
            SizedBox(width: 2.pw),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 82.pw,
                  child: Text(
                    nombre,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 16.pf),
                  ),
                ),
                SizedBox(
                  width: 82.pw,
                  child: Text(
                    apellido,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 16.pf),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
