import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template TextFieldComentario}
/// TODO(mati) add docu
/// {@endtemplate}
class TextFieldComentario extends StatelessWidget {
  /// {@macro TextFieldComentario}
  const TextFieldComentario({
    required this.controller,
    this.onFieldSubmitted,
    super.key,
  });

  ///
  final void Function(String)? onFieldSubmitted;

  ///
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: max(5.ph, 5.sh),
        horizontal: 5.pw,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 3),
            curve: Curves.fastOutSlowIn,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sw),
                color: colores.primary.withOpacity(.2),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.pw,
                  vertical: max(5.ph, 5.sh),
                ),
                child: IntrinsicHeight(
                  child: SizedBox(
                    width: 230.pw,
                    height: max(100.ph, 100.sh),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Escriba aqui...', //TODO (mati) agregar l10n
                      ),
                      textInputAction: TextInputAction.send,
                      onFieldSubmitted: onFieldSubmitted,
                      controller: controller,
                      maxLines: 5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
