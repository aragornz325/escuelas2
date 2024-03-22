import 'dart:math';

import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/extensiones/meses.dart';
import 'package:escuelas_flutter/utilidades/enums/enum_meses.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/full_responsive.dart';

// TODO(ANYONE): Agregar a factory elemento lista

/// {@template ElementoListaMes}
/// Elementos de la lista donde se muestran todos los meses en la
/// vista de calificaciones anuales
/// {@endtemplate}
class ElementoListaMes extends StatelessWidget {
  /// {@macro ElementoListaMes}
  const ElementoListaMes({required this.mes, super.key});

  /// Mes del index actual para obtener el nombre.
  final Meses mes;

  @override
  Widget build(BuildContext context) {
    final colores = context.colores;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50.sw)),
          color: colores.tertiary,
        ),
        child: SizedBox(
          height: max(50.sh, 50.ph),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.pw,
              vertical: max(5.sh, 5.ph),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                mes.obtenerNombreMes(context),
                style: TextStyle(
                  color: colores.onBackground,
                  fontSize: 16.pf,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
