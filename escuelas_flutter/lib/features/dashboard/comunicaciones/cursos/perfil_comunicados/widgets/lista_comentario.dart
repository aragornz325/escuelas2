import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/cursos/perfil_comunicados/widgets/widgets.dart';
import 'package:flutter/material.dart';

/// {@template ListaDeComentarios}
/// TODO(mati) add docu
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

  ///
  final bool agregarComentario;

  ///
  final TextEditingController controller;

  ///
  final void Function(String)? onFieldSubmitted;

  ///
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
