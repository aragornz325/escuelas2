import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/perfil_comunicados/bloc/bloc_perfil_comunicados.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/perfil_comunicados/widgets/widgets.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_dialog.dart';
import 'package:escuelas_flutter/widgets/escuelas_dropdown_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template DialgoCrearNotificacion}
/// Dialog para crear una nueva notificacion con o sin una plantilla.
/// {@endtemplate}
class DialgoCrearNotificacion extends StatefulWidget {
  /// {@macro DialgoCrearNotificacion}
  const DialgoCrearNotificacion({super.key});

  @override
  State<DialgoCrearNotificacion> createState() =>
      _DialgoCrearNotificacionState();
}

class _DialgoCrearNotificacionState extends State<DialgoCrearNotificacion> {
  /// Controller del titulo de la notificacion
  final _controllerTitulo = TextEditingController();

  /// Controller del contenido de la notificacion
  final _controllerContenido = TextEditingController();

  /// Indica si quiere crear la notificacion con una plantilla predeterminada.
  bool _crearConPlantillaPredeterminada = false;

  /// Muestra el proximo dialog de crear notificacion para confirmar la creacion
  /// de la notificacion
  void _dialogConfimarCreacionNotificacion(BuildContext context) {
    Navigator.of(context).pop();
    showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocPerfilComunicados>(),
        child: const DialogConfirmarCreacionNotificacion(
            // TODO(mati): nombre de la plantilla en caso de que elija una predeterminada.
            // tituloPlantilla: 'ejemplo 1',
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    return EscuelasDialog.solicitudDeAccion(
      context: context,
      onTapConfirmar: () => _dialogConfimarCreacionNotificacion(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sw),
      ),
      content: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Text(
              l10n.dialogCreationNotificationCreateNotification,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16.pf,
                color: colores.onBackground,
              ),
            ),
            SizedBox(height: max(10.ph, 10.sh)),
            TextFormField(
              controller: _controllerTitulo,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                color: colores.onBackground,
                fontWeight: FontWeight.w400,
                fontSize: 16.pf,
              ),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.sw),
                  borderSide: BorderSide(color: colores.secondary, width: 1.sw),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.sw),
                  borderSide: BorderSide(color: colores.secondary, width: 1.sw),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.sw),
                  borderSide: BorderSide(color: colores.secondary, width: 1.sw),
                ),
                hintText: l10n.dialogCreationNotificationTitleTextfield,
                hintStyle: TextStyle(
                  color: colores.secondary,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.pf,
                ),
              ),
            ),
            SizedBox(height: max(10.ph, 10.sh)),
            TextFormField(
              controller: _controllerContenido,
              textAlignVertical: TextAlignVertical.center,
              maxLines: 5,
              style: TextStyle(
                color: colores.onBackground,
                fontWeight: FontWeight.w400,
                fontSize: 16.pf,
              ),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.sw),
                  borderSide: BorderSide(color: colores.secondary, width: 1.sw),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.sw),
                  borderSide: BorderSide(color: colores.secondary, width: 1.sw),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.sw),
                  borderSide: BorderSide(color: colores.secondary, width: 1.sw),
                ),
                hintText: l10n.commonSearchWithDots,
                hintStyle: TextStyle(
                  color: colores.secondary,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.pf,
                ),
              ),
            ),
            SizedBox(height: max(10.ph, 10.sh)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.dialogCreationNotificationWithTemplateDefault,
                  style: TextStyle(
                    color: colores.grisSC,
                    fontSize: 13.pf,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Checkbox(
                  value: _crearConPlantillaPredeterminada,
                  onChanged: (v) => setState(
                    () => _crearConPlantillaPredeterminada = v ?? false,
                  ),
                ),
              ],
            ),
            SizedBox(height: max(10.ph, 10.sh)),
            SizedBox(
              height: max(50.ph, 50.sh),
              width: 300.pw,
              child: EscuelasDropdownPopup(
                // TODO (mati): reemplazar por la lista de plantillas del bloc
                list: const [
                  PopupOption(id: 1, name: 'Crear Nueva Plantilla'),
                  PopupOption(id: 2, name: 'Falta de respeto'),
                  PopupOption(id: 3, name: 'Uso de recursos inapropiados'),
                ],
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
