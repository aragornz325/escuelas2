import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/perfil_comunicados/bloc/bloc_perfil_comunicados.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/perfil_comunicados/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template BotonesAgregarNuevaYMarcarTodosComoLeidos}
/// Son los botones para agregar una nueva notificacion y marcar todas como
/// leidas.
/// {@endtemplate}
class BotonesAgregarNuevaYMarcarTodosComoLeidos extends StatelessWidget {
  /// {@macro BotonesAgregarNuevaYMarcarTodosComoLeidos}
  const BotonesAgregarNuevaYMarcarTodosComoLeidos({
    required this.notificaciones,
    super.key,
  });

  /// Notificaciones a marcar como leidas.
  final List<HiloDeNotificaciones> notificaciones;

  /// Getter para saber si todas las notificaciones estan leidas.
  bool get estanTodasLeidas => notificaciones.any(
        (notificacion) => notificacion.comentarios!
            .any((comentario) => comentario.fechaLectura == null),
      );

  /// Dialog para crear una nueva notificacion.
  void _dialogAgregarNuevaNotificacion(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocPerfilComunicados>(),
        child: const DialogCrearNotificacion(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // TODO(mati): agregar notificacion dependiendo de los roles del usuario
        // si es directivo/docente puede agregar una nueva notificacion.
        InkWell(
          onTap: () => _dialogAgregarNuevaNotificacion(context),
          child: Row(
            children: [
              Text(
                l10n.pageCommunicationProfileAddNewNotification,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.pf,
                  color: colores.primary,
                ),
              ),
              Icon(
                Icons.add,
                size: 20.sw,
                color: colores.primary,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            if (estanTodasLeidas) {
              context.read<BlocPerfilComunicados>().add(
                    BlocPerfilComunicadosEventoNotificacionMarcarTodasComoLeidas(),
                  );
            }
          },
          child: Row(
            children: [
              Text(
                l10n.pageCommunicationProfileMarkAllRead,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10.pf,
                  color: estanTodasLeidas
                      ? colores.primary
                      : colores.grisDeshabilitado,
                ),
              ),
              Icon(
                Icons.mark_email_read_outlined,
                size: 20.sw,
                color: estanTodasLeidas
                    ? colores.primary
                    : colores.grisDeshabilitado,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
