import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template NombreNotificacionYMarcarComoLeido}
/// es la parte superior de la notificacion donde muestra el nombre de la
/// notificacion y el boton para marcar como leido.
/// {@endtemplate}
class NombreNotificacionYMarcarComoLeido extends StatelessWidget {
  /// {@macro NombreNotificacionYMarcarComoLeido}
  const NombreNotificacionYMarcarComoLeido({
    required this.estaExpandido,
    super.key,
  });

  /// Indica si la notificacion esta expandida o no en caso de que este
  /// expandido oculta las primeras 2 fotos de los comentarios.
  final bool estaExpandido;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Row(
      children: [
        Row(
          children: [
            SizedBox(
              width: estaExpandido ? null : 110.pw,
              child: Text(
                'Uso de uniforme', // TODO(mati): aca va el nombre de la notificacion
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.pf,
                  color: colores.onBackground,
                ),
              ),
            ),
            SizedBox(
              width: estaExpandido ? null : 50.pw,
              child: Text(
                '(notificacion)', // TODO(mati): aca va el tipo de plantilla que uso/ nombre de la plantilla
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.pf,
                  color: colores.secondary,
                ),
              ),
            ),
          ],
        ),
        if (estaExpandido) SizedBox(width: 10.pw),
        // TODO(mati): en caso de que la notificacion no este en el estado de leida tiene que aparecer esto
        CircleAvatar(
          backgroundColor: colores.primaryContainer.withOpacity(.7),
          radius: 5.sw,
        ),
        SizedBox(width: 10.pw),
        IconButton(
          onPressed: () {
            // TODO(mati): funcionamiento para marcar como leida esta notificacion en caso de que no este leida
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
