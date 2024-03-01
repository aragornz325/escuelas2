import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

/// {@template BotonesAgregarNuevaYMarcarTodosComoLeidos}
/// TODO(mati) add docu
/// {@endtemplate}
class BotonesAgregarNuevaYMarcarTodosComoLeidos extends StatelessWidget {
  /// {@macro BotonesAgregarNuevaYMarcarTodosComoLeidos}
  const BotonesAgregarNuevaYMarcarTodosComoLeidos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            // TODO(mati): hacer que habra el popup de agregar nueva notificacion.
          },
          child: Row(
            children: [
              Text(
                'Agregar nueva', //TODO (mati): traducciones
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
            // TODO(mati): hacer que habra el popup de agregar nueva notificacion.
          },
          child: Row(
            children: [
              Text(
                'Marcaar todo como leido', //TODO (mati): traducciones
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10.pf,
                  color: colores.primary,
                ),
              ),
              Icon(
                Icons.mark_email_read_outlined,
                size: 20.sw,
                color: colores.primary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
