import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/perfil_comunicados/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// {@template ListaDeComentarios}
/// Lista de comentarios de una notificacion.
/// {@endtemplate}
class ListaDeComentarios extends StatefulWidget {
  /// {@macro ListaDeComentarios}
  const ListaDeComentarios({
    required this.comentarios,
    required this.agregarComentario,
    required this.controller,
    required this.onPressed,
    this.onFieldSubmitted,
    super.key,
  });

  /// Es para saber si se agrega un nuevo comentario oculta el boton de agregar
  /// un nuevo comentario.
  final bool agregarComentario;

  /// Controller del textfield para agregar un nuevo comentario.
  final TextEditingController controller;

  /// Funcion para agregar un nuevo comentario.
  final void Function(String)? onFieldSubmitted;

  /// Funcion para el boton de agregar un nuevo comentario y ocultarlo.
  final VoidCallback onPressed;

  /// Lista de comentarios de una notificacion.
  final List<ComentarioHiloDeNotificaciones> comentarios;

  @override
  State<ListaDeComentarios> createState() => _ListaDeComentariosState();
}

class _ListaDeComentariosState extends State<ListaDeComentarios> {
  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: colores.secondary),
        ...widget.comentarios.reversed.map(
          (comentario) => ComentarioConFotoDePerfil(
            comentario: comentario,
          ),
        ),
        if (widget.agregarComentario)
          TextFieldComentario(
            controller: widget.controller,
            onFieldSubmitted: widget.onFieldSubmitted,
          ),
        if (!widget.agregarComentario)
          BotonAgregarComentario(
            onPressed: widget.onPressed,
          ),
      ],
    );
  }
}
