import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template FotosYFechasDelComentario}
/// Son la fotos del usuario del comentario con el nombre y la fecha en la que
/// envio el comentario.
/// {@endtemplate}
class FotosYFechasDelComentario extends StatelessWidget {
  /// {@macro FotosYFechasDelComentario}
  const FotosYFechasDelComentario({
    required this.notificacion,
    super.key,
  });

  /// Notificacion a mostrar.
  final HiloDeNotificaciones notificacion;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            SizedBox(width: 50.pw),
            Positioned(
              child: CircleAvatar(
                backgroundColor: colores.secondary,
                backgroundImage: NetworkImage(
                  notificacion.autor?.urlFotoDePerfil ?? '',
                ),
                radius: 15.sw,
              ),
            ),
            Positioned(
              left: 20.sw,
              child: CircleAvatar(
                backgroundColor: colores.secondary,
                backgroundImage: NetworkImage(
                  notificacion.estudiante?.urlFotoDePerfil ?? '',
                ),
                radius: 15.sw,
              ),
            ),
          ],
        ),
        Text(
          notificacion.fechaRecienteComentario(context),
          style: TextStyle(
            color: colores.onBackground,
            fontSize: 8.pf,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
