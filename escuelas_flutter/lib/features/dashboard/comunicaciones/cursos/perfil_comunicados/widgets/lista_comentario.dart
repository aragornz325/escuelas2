import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/perfil_comunicados/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// {@template ListaDeComentarios}
/// Lista de comentarios de una notificacion.
/// {@endtemplate}
class ListaDeComentarios extends StatelessWidget {
  /// {@macro ListaDeComentarios}
  const ListaDeComentarios({
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

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: colores.secondary),

        /// TODO(mati): agregar lista de comentarios de una notificacion
        const ComentarioConFotoDePerfil(),
        if (agregarComentario)
          TextFieldComentario(
            controller: controller,
            onFieldSubmitted: onFieldSubmitted,
          ),
        if (!agregarComentario)
          BotonAgregarComentario(
            onPressed: onPressed,
          ),
      ],
    );
  }
}
