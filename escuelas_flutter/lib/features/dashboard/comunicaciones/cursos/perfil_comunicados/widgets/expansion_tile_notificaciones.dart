import 'dart:math';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/perfil_comunicados/bloc/bloc_perfil_comunicados.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/perfil_comunicados/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template ExpansionTileNotificaciones}
/// Es la expansion tile de las notificaciones donde se muestran los comentarios
/// de la notificacion y el boton para agregar un nuevo comentario a la
/// notificacion.
/// {@endtemplate}
class ExpansionTileNotificaciones extends StatefulWidget {
  /// {@macro ExpansionTileNotificaciones}
  const ExpansionTileNotificaciones({
    required this.notificacion,
    super.key,
  });

  /// Notificacion a mostrar.
  final HiloDeNotificaciones notificacion;

  @override
  State<ExpansionTileNotificaciones> createState() =>
      _ExpansionTileNotificacionesState();
}

class _ExpansionTileNotificacionesState
    extends State<ExpansionTileNotificaciones> {
  /// Para saber si esta expandido el expansion tile en caso de que este
  /// expandido oculta las primeras 2 fotos de los comentarios.
  bool _estaExpandido = false;

  /// Para saber si se agrego un nuevo comentario a la notificacion en caso de
  /// este en true oculta el boton para agregar un nuevo comentario.
  bool _agregarComentario = false;

  /// Controller para agregar un nuevo comentario.
  final _controllerComentario = TextEditingController();

  @override
  void dispose() {
    _controllerComentario.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: max(5.ph, 5.sh)),
      child: ExpansionTile(
        onExpansionChanged: (value) => setState(() => _estaExpandido = value),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.sw),
          side: BorderSide(color: colores.secondary, width: 1.pw),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.sw),
          side: BorderSide(color: colores.secondary, width: 1.pw),
        ),
        leading: _estaExpandido
            ? null
            : FotosYFechasDelComentario(
                notificacion: widget.notificacion,
              ),
        title: NombreNotificacionYMarcarComoLeido(
          notificacion: widget.notificacion,
          estaExpandido: _estaExpandido,
        ),
        children: [
          ListaDeComentarios(
            comentarios: widget.notificacion.comentarios ?? [],
            agregarComentario: _agregarComentario,
            controller: _controllerComentario,
            onPressed: () =>
                setState(() => _agregarComentario = !_agregarComentario),
            onFieldSubmitted: (value) {
              if (value.trim().isNotEmpty &&
                  _controllerComentario.text.isNotEmpty) {
                context.read<BlocPerfilComunicados>().add(
                      BlocPerfilComunicadosEventoCrearComentario(
                        idHiloDeNotificacion: widget.notificacion.id ?? 0,
                        comentario: _controllerComentario.text,
                      ),
                    );
              }

              setState(() {
                _agregarComentario = !_agregarComentario;
                _controllerComentario.clear();
              });
            },
          ),
        ],
      ),
    );
  }
}
