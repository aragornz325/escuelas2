import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/date_time.dart';
import 'package:flutter/material.dart';

/// Extension para los HiloDeNotificaciones.
/// Con una funcion para obtener la fecha mas reciente de la lista de
/// comentarios.
extension HiloDeNotificacionesX on HiloDeNotificaciones {
  /// Fecha mas reciente del ultimo comentario
  String fechaRecienteComentario(BuildContext context) {
    if ((comentarios ?? []).isEmpty && comentarios == null) {
      return ultimaModificacion.toUtc().periodoFechaEnviada(context);
    }
    comentarios!
        .sort((a, b) => b.fechaCreacion.toUtc().compareTo(a.fechaCreacion));

    return comentarios!.first.fechaCreacion
        .toUtc()
        .periodoFechaEnviada(context);
  }
}
