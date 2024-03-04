import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ComentarioConFotoDePerfil}
/// Esto es un comentario en una notificacion con la foto del usuario y la fecha
/// de creacion con el nombre del usuario.
/// {@endtemplate}
class ComentarioConFotoDePerfil extends StatelessWidget {
  /// {@macro ComentarioConFotoDePerfil}
  const ComentarioConFotoDePerfil({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: max(5.ph, 5.sh),
        horizontal: 5.pw,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicHeight(
            child: Container(
              width: 80.pw,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sw),
                color: colores.primary.withOpacity(.2),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.pw,
                  vertical: max(5.ph, 5.sh),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'hero 1',
                      child: CircleAvatar(
                        backgroundColor: colores.secondary,
                        backgroundImage: NetworkImage(
                          'https://picsum.photos/200',
                        ), // TODO(mati): hacer que reciba la imagen del usuario/alumno de una notificacion
                        radius: 15.sw,
                      ),
                    ),
                    Text(
                      DateTime.now().horaFechaEnviada(context),
                      style: TextStyle(
                        color: colores.onBackground,
                        fontSize: 8.pf,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Menem Garcia', // TODO(mati): nombre del mensaje recibido.
                      style: TextStyle(
                        color: colores.onBackground,
                        fontSize: 8.pf,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 10.pw),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sw),
                color: colores.primary.withOpacity(.2),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.pw,
                  vertical: max(5.ph, 5.sh),
                ),
                child: Text(
                  'asdasdsdadd \nasdsaasdads\nasdasdsdadd \nasdsaasdads\nasdasdsdadd \nasdsaasdads\nasdasdsdadd \nasdsaasdads\nasdasdsdadd \nasdsaasdads\nsdasdsada',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: colores.onBackground,
                    fontSize: 14.pf,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
