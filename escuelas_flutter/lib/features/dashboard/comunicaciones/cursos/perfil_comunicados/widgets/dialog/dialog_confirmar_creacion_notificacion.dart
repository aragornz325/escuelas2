import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/perfil_comunicados/bloc/bloc_perfil_comunicados.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialogConfirmarCreacionNotificacion}
/// Dialos para confirmar la creacion de una notificacion.
/// {@endtemplate}
class DialogConfirmarCreacionNotificacion extends StatefulWidget {
  /// {@macro DialogConfirmarCreacionNotificacion}
  const DialogConfirmarCreacionNotificacion({
    required this.crearConPlantillaPredeterminada,
    required this.necesitaSupervision,
    required this.descripcion,
    this.tituloPlantilla,
    super.key,
  });

  /// Titulo de la plantilla en caso de que el usuario quiera crear una
  /// notificacion con una plantilla predeterminada.
  final String? tituloPlantilla;

  /// Crear una notificacion con una plantilla predeterminada.
  final bool crearConPlantillaPredeterminada;

  /// Descripcion de la notificacion o primer mensaje a enviar.
  final String descripcion;

  /// Indica si la notificacion necesita Supervision.
  final bool necesitaSupervision;

  @override
  State<DialogConfirmarCreacionNotificacion> createState() =>
      _DialogConfirmarCreacionNotificacionState();
}

class _DialogConfirmarCreacionNotificacionState
    extends State<DialogConfirmarCreacionNotificacion> {
  late bool _necesitaSupervision;

  @override
  void initState() {
    super.initState();
    _necesitaSupervision = widget.necesitaSupervision;
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return EscuelasDialog.solicitudDeAccion(
      context: context,
      onTapConfirmar: () {
        Navigator.of(context).pop();
        context.read<BlocPerfilComunicados>().add(
              BlocPerfilComunicadosEventoCrearNotificacion(
                crearNuevaPlantilla: widget.crearConPlantillaPredeterminada,
                tituloPlantilla: widget.tituloPlantilla,
                descripcion: widget.descripcion,
                necesitaSupervision: _necesitaSupervision,
              ),
            );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sw),
      ),
      content: Column(
        children: [
          if (widget.crearConPlantillaPredeterminada) ...[
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: l10n.commonAttention,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.pf,
                      color: colores.grisSC,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: max(5.ph, 5.sh)),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '“${widget.tituloPlantilla}” ',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.pf,
                      color: colores.grisSC,
                    ),
                  ),
                  TextSpan(
                    text: l10n.dialogCreationNotificationWasTemplate,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.pf,
                      color: colores.grisSC,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: max(15.ph, 15.sh)),
            Text(
              l10n.dialogCreationNotificationConfimationSend,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.pf,
                color: colores.grisSC,
              ),
            ),
          ],
          if (widget.crearConPlantillaPredeterminada)
            Text(
              l10n.dialogCreationNotificationWillCreateNotification,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.pf,
                color: colores.grisSC,
              ),
            ),
          SizedBox(height: max(5.ph, 5.sh)),
          Text(
            l10n.dialogCreationNotificationWantToContinue,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.pf,
              color: colores.grisSC,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Tooltip(
                message: l10n.dialogCreationNotificationTooltip,
                decoration: BoxDecoration(
                  color: colores.secondary,
                  borderRadius: BorderRadius.circular(5.sw),
                ),
                textStyle: TextStyle(
                  color: colores.onBackground,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.pf,
                ),
                margin: EdgeInsets.symmetric(horizontal: 80.pw),
                textAlign: TextAlign.center,
                height: 50.ph,
                padding: EdgeInsets.zero,
                preferBelow: true,
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: colores.grisSC),
                    SizedBox(width: 5.pw),
                    Text(
                      l10n.dialogCreationNotificationNeedsupervision,
                      style: TextStyle(
                        color: colores.grisSC,
                        fontSize: 13.pf,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Checkbox(
                value: _necesitaSupervision,
                onChanged: (v) => setState(
                  () => _necesitaSupervision = v ?? false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
