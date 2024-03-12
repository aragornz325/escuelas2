import 'dart:math';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ComentarioConFotoDePerfil}
/// Esto es un comentario en una notificacion con la foto del usuario y la fecha
/// de creacion con el nombre del usuario.
/// {@endtemplate}
class ComentarioConFotoDePerfil extends StatelessWidget {
  /// {@macro ComentarioConFotoDePerfil}
  const ComentarioConFotoDePerfil({
    required this.comentario,
    super.key,
  });

  /// Comentario de una notificacion.
  final ComentarioHiloDeNotificaciones comentario;

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
                color: colores.grisBotonPresionado,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.pw,
                  vertical: max(5.ph, 5.sh),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: colores.secondary,
                      backgroundImage: NetworkImage(
                        comentario.autor?.urlFotoDePerfil ?? '',
                      ),
                      radius: 15.sw,
                    ),
                    Text(
                      comentario.ultimaModificacion
                          .toUtc()
                          .horaFechaEnviada(context),
                      style: TextStyle(
                        color: colores.onBackground,
                        fontSize: 8.pf,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '${comentario.autor?.nombre ?? ''}'
                      ' ${comentario.autor?.apellido ?? ''}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
                color: colores.grisBotonPresionado,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.pw,
                  vertical: max(5.ph, 5.sh),
                ),
                child: Text(
                  comentario.contenido,
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
