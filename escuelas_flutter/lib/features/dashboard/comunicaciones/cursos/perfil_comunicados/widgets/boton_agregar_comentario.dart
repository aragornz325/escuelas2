import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template BotonAgregarComentario}
/// Boton para agregar un nuevo comentario a una notificacion.
/// {@endtemplate}
class BotonAgregarComentario extends StatelessWidget {
  /// {@macro BotonAgregarComentario}
  const BotonAgregarComentario({
    required this.onPressed,
    super.key,
  });

  /// Funcion Para Agregar un nuevo comentario.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: max(5.ph, 5.sh),
        horizontal: 5.pw,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundColor: colores.primary.withOpacity(.3),
            radius: 20.sw,
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.add,
                size: 25.sw,
                color: colores.onBackground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
