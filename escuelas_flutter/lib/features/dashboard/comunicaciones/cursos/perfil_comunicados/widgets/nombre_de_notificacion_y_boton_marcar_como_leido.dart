import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/perfil_comunicados/bloc/bloc_perfil_comunicados.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template NombreNotificacionYMarcarComoLeido}
/// es la parte superior de la notificacion donde muestra el nombre de la
/// notificacion y el boton para marcar como leido.
/// {@endtemplate}
class NombreNotificacionYMarcarComoLeido extends StatelessWidget {
  /// {@macro NombreNotificacionYMarcarComoLeido}
  const NombreNotificacionYMarcarComoLeido({
    required this.estaExpandido,
    required this.notificacion,
    super.key,
  });

  /// Indica si la notificacion esta expandida o no en caso de que este
  /// expandido oculta las primeras 2 fotos de los comentarios.
  final bool estaExpandido;

  /// Notificacion a mostrar.
  final HiloDeNotificaciones notificacion;

  /// Indica si hay un comentario sin leer y muestra un circulo de color azul.
  bool get hayComentariosSinLeer => !(notificacion.comentarios ?? [])
      .every((comentario) => comentario.fechaLectura != null);

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;
    return Row(
      children: [
        Row(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: estaExpandido ? 215.pw : 150.pw,
              ),
              child: IntrinsicWidth(
                child: Text(
                  notificacion.titulo,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.pf,
                    color: colores.onBackground,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 10.pw),
        if (hayComentariosSinLeer)
          CircleAvatar(
            backgroundColor: colores.primaryContainer.withOpacity(.7),
            radius: 5.sw,
          ),
        SizedBox(width: 10.pw),
        if (hayComentariosSinLeer)
          IconButton(
            onPressed: () {
              context.read<BlocPerfilComunicados>().add(
                    BlocPerfilComunicadosEventoMarcarNotificacionComoLeidas(
                      notificacion: notificacion,
                    ),
                  );
            },
            icon: Icon(
              Icons.check,
              color: colores.onBackground,
            ),
          ),
      ],
    );
  }
}
