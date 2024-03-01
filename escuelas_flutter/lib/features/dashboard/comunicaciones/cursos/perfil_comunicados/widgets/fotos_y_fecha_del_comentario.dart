import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template FotosYFechasDelComentario}
/// TODO(mati) add docu
/// {@endtemplate}
class FotosYFechasDelComentario extends StatelessWidget {
  /// {@macro FotosYFechasDelComentario}
  const FotosYFechasDelComentario({super.key});

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
              child: Hero(
                tag: 'hero 1',
                child: CircleAvatar(
                  backgroundColor: colores.secondary,
                  backgroundImage: NetworkImage(
                    'https://picsum.photos/200',
                  ), // TODO(mati): hacer que reciba la imagen del usuario/alumno de una notificacion
                  radius: 15.sw,
                ),
              ),
            ),
            Positioned(
              left: 20.sw,
              child: Hero(
                tag: 'hero 2',
                child: CircleAvatar(
                  backgroundColor: colores.secondary,
                  backgroundImage: NetworkImage(
                    'https://picsum.photos/200',
                  ), // TODO(mati): hacer que reciba la imagen del usuario/alumno de una la conversacion
                  radius: 15.sw,
                ),
              ),
            ),
          ],
        ),
        Text(
          DateTime.now().periodoFechaEnviada(
            context,
          ), //TODO(mati): aca va la fecha del ultimo comentario?
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
