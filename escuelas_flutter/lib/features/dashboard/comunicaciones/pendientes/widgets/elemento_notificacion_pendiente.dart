// ignore_for_file: lines_longer_than_80_chars

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/pendientes/bloc_comunicaciones_pendientes/bloc_comunicaciones_pendientes.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/pendientes/widgets/dialogs/dialog_aprobar_notificacion.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/pendientes/widgets/expansion_tile_title_notificacion.dart';
import 'package:escuelas_flutter/l10n/l10n.dart';
import 'package:escuelas_flutter/theming/base.dart';
import 'package:escuelas_flutter/widgets/escuelas_boton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ElementoNotificacionPendiente}
/// Elemento que contiene informacion de la notificacion, el profesor y el
/// alumno y el contenido de la misma.
/// {@endtemplate}
class ElementoNotificacionPendiente extends StatefulWidget {
  /// {@macro ElementoNotificacionPendiente}
  const ElementoNotificacionPendiente({
    required this.solicitudNotificacion,
    super.key,
  });

  /// Solicitud del envio de la notificacion.
  final SolicitudEnvioNotificacion solicitudNotificacion;

  @override
  State<ElementoNotificacionPendiente> createState() =>
      _ElementoNotificacionPendienteState();
}

class _ElementoNotificacionPendienteState
    extends State<ElementoNotificacionPendiente> {
  /// Indica si el container esta expandido.
  bool estaExpandido = false;

  /// Controller del titulo de la notificacion
  final TextEditingController _tituloNotificacionController =
      TextEditingController();

  /// Controller del cuerpo de la notificacion
  final TextEditingController _cuerpoNotificacionController =
      TextEditingController();

  /// Indica si el componente esta en edicion
  bool esEdicion = false;

  @override
  void initState() {
    super.initState();
    _tituloNotificacionController.text =
        widget.solicitudNotificacion.notificacion?.titulo ?? '';
    _cuerpoNotificacionController.text =
        widget.solicitudNotificacion.notificacion?.cuerpo ?? '';
  }

  @override
  void dispose() {
    _tituloNotificacionController.dispose();
    _cuerpoNotificacionController.dispose();

    super.dispose();
  }

  /// Dialog que permite al usuario aprobar la notificacion.
  Future<void> _onAprobarNotificacion(
    BuildContext context,
  ) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocComunicacionesPendientes>(),
        child: DialogAprobarNotificacion(
          idSolicitud: widget.solicitudNotificacion.solicitudId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    final l10n = context.l10n;

    final notificacion = widget.solicitudNotificacion.notificacion;

    return Container(
      width: 375.pw,
      padding: EdgeInsets.symmetric(horizontal: 12.pw, vertical: 8.ph),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.sw)),
        border: Border.all(
          color: colores.grisSobreBackground,
          width: 1.pw,
        ),
        color: colores.background,
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 1.pw),
        title: ExpansionTileTitleNotificacion(
          alumno: widget.solicitudNotificacion.alumno,
          docente: widget.solicitudNotificacion.docente,
        ),
        trailing: Icon(
          estaExpandido ? Icons.expand_less : Icons.expand_more,
          color: colores.grisSC,
          size: 25.pw,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.sw),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.sw),
        ),
        onExpansionChanged: (value) => setState(() => estaExpandido = value),
        backgroundColor: colores.background,
        children: <Widget>[
          Divider(
            height: .2,
            color: colores.grisSobreBackground,
          ),
          ListTile(
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 250.pw,
                      child: TextFormField(
                        readOnly: !esEdicion,
                        controller: _tituloNotificacionController,
                        decoration: esEdicion
                            ? InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.pw,
                                  vertical: 8.ph,
                                ),
                                filled: true,
                                fillColor: colores.background,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.sw)),
                                  borderSide: BorderSide(
                                    color: colores.grisSobreBackground,
                                    width: 1.pw,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.sw)),
                                  borderSide: BorderSide(
                                    color: colores.grisSobreBackground,
                                    width: 1.pw,
                                  ),
                                ),
                              )
                            : const InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                        style: TextStyle(
                          color: colores.onBackground,
                          fontSize: 16.pf,
                          fontWeight: FontWeight.w800,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10.pw),
                      child: GestureDetector(
                        onTap: () => setState(() {
                          esEdicion = true;
                        }),
                        child: Icon(
                          Icons.edit_outlined,
                          color: colores.grisDetalleFecha,
                          size: 16.pw,
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.ph),
                    child: SizedBox(
                      width: 319.pw,
                      child: TextFormField(
                        maxLines: 5,
                        readOnly: !esEdicion,
                        controller: _cuerpoNotificacionController,
                        style: TextStyle(
                          color: colores.onBackground,
                          fontSize: 16.pf,
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                        ),
                        decoration: esEdicion
                            ? InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.pw,
                                  vertical: 8.ph,
                                ),
                                filled: true,
                                fillColor: colores.background,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.sw)),
                                  borderSide: BorderSide(
                                    color: colores.grisSobreBackground,
                                    width: 1.pw,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.sw)),
                                  borderSide: BorderSide(
                                    color: colores.grisSobreBackground,
                                    width: 1.pw,
                                  ),
                                ),
                              )
                            : const InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: .1,
                  color: colores.grisSobreBackground,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.pw),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      EscuelasBoton.outlinedConIcono(
                        context: context,
                        estaHabilitado: true,
                        onTap: () => esEdicion
                            ? setState(() {
                                context
                                    .read<BlocComunicacionesPendientes>()
                                    .add(
                                      BlocComunicacionesPendientesEventoEditarNotificaciones(
                                        tituloNotificacionEditada:
                                            _tituloNotificacionController.text,
                                        cuerpoNotificacionEditada:
                                            _cuerpoNotificacionController.text,
                                        notificacionId:
                                            widget.solicitudNotificacion.id ??
                                                0,
                                      ),
                                    );
                                esEdicion = false;
                              })
                            : _onAprobarNotificacion(context),
                        height: 40.ph,
                        colorOutline: colores.grisSobreBackground,
                        width: 126.pw,
                        texto: esEdicion ? l10n.commonSave : l10n.commonApprove,
                        colorDeTexto: colores.onBackground,
                        icono: Icon(
                          esEdicion ? Icons.save_outlined : Icons.check,
                          color: colores.verdeConfirmar,
                          size: 24.sw,
                        ),
                      ),
                      SizedBox(
                        width: 30.pw,
                      ),
                      EscuelasBoton.outlinedConIcono(
                        context: context,
                        estaHabilitado: true,
                        onTap: () => esEdicion
                            ? setState(() {
                                esEdicion = false;
                                _tituloNotificacionController.text =
                                    notificacion?.titulo ?? '';
                                _cuerpoNotificacionController.text =
                                    notificacion?.cuerpo ?? '';
                              })
                            : context.read<BlocComunicacionesPendientes>().add(
                                  BlocComunicacionesPendientesEventoEnviarEstadoNotificaciones(
                                    estadoSolicitud:
                                        EstadoDeSolicitud.rechazado,
                                    solicitudId: widget
                                        .solicitudNotificacion.solicitudId,
                                  ),
                                ),
                        height: 40.ph,
                        colorOutline: colores.grisSobreBackground,
                        width: 126.pw,
                        texto:
                            esEdicion ? l10n.commonCancel : l10n.commonDecline,
                        colorDeTexto: colores.onBackground,
                        icono: Icon(
                          Icons.close,
                          color: colores.error,
                          size: 24.sw,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.sw),
                bottomRight: Radius.circular(20.sw),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
